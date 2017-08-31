[![Docker Pulls](https://img.shields.io/docker/pulls/flywheel/mri-deface.svg)](https://hub.docker.com/r/flywheel/mri-deface/)
[![Docker Stars](https://img.shields.io/docker/stars/flywheel/mri-deface.svg)](https://hub.docker.com/r/flywheel/mri-deface/)
# flywheel/mri-deface

Build context for a [Flywheel Gear](https://github.com/flywheel-io/gears/tree/master/spec) which runs the [MBIRN `mri_deface` tool](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_deface) (v1.22) from FreeSurfer.

* No other FreeSurfer tools are installed within this Docker image
* Unlike the full FreeSurfer software, a license file is not necessary to use this tool
* The resulting image is ~0.5GB

### Build the Image
To build the image:
```
git clone https://github.com/flywheel-apps/mri-deface
cd mri-deface
docker build -t flywheel/mri-deface .
```

### Example Local Usage ###
To run the `mri_deface` Gear your local instance with Docker, do the following:
```
docker run --rm -ti \
  -v </path/to/input/data>:/flywheel/v0/input/anatomical \
  -v </path/for/output/data>:/flywheel/v0/output \
  flywheel/mri-deface
```
Usage notes:
  * You are mounting the directory (using the ```-v``` flag) which contains the input data in the container at ```/flywheel/v0/input/anatomical``` and mounting the directory where you want your output data within the container at ```/flywheel/v0/output```
  * The "input" directory (mounted within the container at ```/flywheel/v0/input/anatomical```) should contain only the file you wish to 'deface'
  * Only the first file found in the input directory will be run through the algorithm
  * No input arguments are required for the container to be executed
