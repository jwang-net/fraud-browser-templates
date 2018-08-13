import boto3
from botocore.exceptions import ClientError
import sys


s3 = boto3.client('s3')
bucket = 'fraud-browsers-archive'
browser = sys.argv[1]
browser_version = sys.argv[2]
os = 'linux-x86_64'
if sys.argv[3] == 'grid':
    local_path = browser
else:
    local_path = '{}_{}'.format(browser, 'simple')


if browser == 'chrome':
    key = '{}/{}/chrome64_{}.deb'.format(browser, os, browser_version)
    local_filename = '{}/chrome64_{}.deb'.format(local_path, browser_version)
elif browser == 'firefox':
    key = '{}/{}/firefox_{}.tar.bz2'.format(browser, os, browser_version)
    local_filename = '{}/firefox_{}.tar.bz2'.format(local_path, browser_version)
else:
    raise Exception('ERROR: Unsupported browser {}.'.format(browser))


try:
    s3.download_file(bucket, key, local_filename)
    print 'Downloaded {} to {} from bucket {}.'.format(key, local_filename, bucket)
except ClientError as e:
    if e.response['Error']['Code'] == '404':
            print 'Object {} does not exist.'.format(key)
    else:
        raise
