Build docker containers with a specified browser and browser version.
Currently only chrome and firefox supported. Browsers are continuously
archived in the S3 bucket 'fraud-browsers-archive' as new versions are
released.

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
