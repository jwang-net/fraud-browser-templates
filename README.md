Build docker containers with a specified browser and browser version.
Currently only chrome and firefox supported. Browsers are continuously
archived in the S3 bucket 'fraud-browsers-archive' as they are released.

#### Build Instructions
```
# Chrome example
source build.sh --chrome_version=<version>

# Firefox example
source build.sh --firefox_version=<version>
```

#### Cleanup Instructions
```
source cleanup.sh
```
