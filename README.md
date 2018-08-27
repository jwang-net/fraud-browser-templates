Build docker containers with a specified browser and browser version.
Currently only chrome and firefox supported. Browsers are continuously
archived in the S3 bucket 'fraud-browsers-archive' as new versions are
released.

## Requirements
```
```

## Build Instructions
The build script will handle building docker images for the desired
 browser and version. It must be run from the root directory of this project.
```
# Chrome example standalone without grid
source build.sh --simple --chrome_version=<version>

# Firefox example standalone without grid
source build.sh --simple --firefox_version=<version>

# Chrome example with grid hub and node
source build.sh --grid --chrome_version=<version>

# Firefox example with grid hub and node
source build.sh --grid --firefox_version=<version>
```

## Cleanup Instructions
The cleanup script will remove all the docker images and containers started
by this
```
source cleanup.sh
```

## Docker Container Usage Instructions
```
# Checking your images created by the build.sh script
[jenkins@vendo-123-103 ~]$ docker images
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
chrome_68.0.3440.87_simple   latest              30dec0f95f37        11 minutes ago      1.91GB
python                       2.7                 17c0fe4e76a5        4 weeks ago         908MB

# Using a bash shell to execute commands on a Docker container
[jenkins@vendo-123-103 ~]$ docker run -it chrome_68.0.3440.87_simple /bin/bash
root@e3ef43784a13:/home# echo $(/usr/bin/google-chrome -version | awk '{ print $3 }')
68.0.3440.84

# Running a simple test on the container with specified version of chrome
root@e3ef43784a13:/home# python test_simple.py
INFO:root:Prepared chrome browser..
INFO:root:Accessed http://www.github.com/ ..
INFO:root:Page title: The world’s leading software development platform · GitHub

# Running the trimtricks test on the container with specified version of chrome
root@e3ef43784a13:/home/charmer# ./test-runner --location=local --chrome --test=/home/swarm-js/test/python/component/test_homies.py
py.test ['-ra', '-v', '-n', '1', '/home/swarm-js/test/python/component/test_homies.py', '--junitxml', '/home/charmer/reports/2018-Aug-27_17-40-11.714820.xml', '--html', '/home/charmer/reports/html/2018-Aug-27_17-40-11.714820.html']
============================================================================= test session starts =============================================================================
platform linux2 -- Python 2.7.15, pytest-3.3.1, py-1.5.4, pluggy-0.6.0 -- /usr/local/bin/python
cachedir: ../.cache
metadata: {'Python': '2.7.15', 'Platform': 'Linux-4.4.41-36.55.amzn1.x86_64-x86_64-with-debian-9.5', 'Packages': {'py': '1.5.4', 'pytest': '3.3.1', 'pluggy': '0.6.0'}, 'Plugins': {'ordering': '0.5', 'xdist': '1.20.1', 'rerunfailures': '3.1', 'html': '1.14.2', 'forked': '0.2', 'metadata': '1.5.1'}}
rootdir: /home, inifile:
plugins: xdist-1.20.1, rerunfailures-3.1, ordering-0.5, metadata-1.5.1, html-1.14.2, forked-0.2
[gw0] linux2 Python 2.7.15 cwd: /home/charmer
[gw0] Python 2.7.15 (default, Jul 25 2018, 18:19:34)  -- [GCC 6.3.0 20170516]
gw0 [1]
scheduling tests via LoadScheduling

../swarm-js/test/python/component/test_homies.py::Homies_chrome_::test_homies
[gw0] [100%] PASSED ../swarm-js/test/python/component/test_homies.py::Homies_chrome_::test_homies

-------------------------------------------------- generated xml file: /home/charmer/reports/2018-Aug-27_17-40-11.714820.xml --------------------------------------------------
---------------------------------------------- generated html file: /home/charmer/reports/html/2018-Aug-27_17-40-11.714820.html -----------------------------------------------
========================================================================== 1 passed in 7.54 seconds ===========================================================================
root@e3ef43784a13:/home# exit
exit
[jenkins@vendo-123-103 ~]$
```
