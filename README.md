### flywheel/mri-deface


This Dockerfile will create a Docker image with the mri\_deface tool (v1.22) from FreeSurfer.

* No other FreeSurfer tools are within this Docker image
* Unlike the full FreeSurfer software, a license file is not necessary to use these tools
* You can change ```build.sh``` to edit the repository name for the image (default=flywheel/mri-deface).
* The resulting image is ~0.5GB

### Build the Image
To build the image, either download the files from this repo or clone the repo:
```
git clone https://github.com/flywheel-apps/mri-deface
./build.sh
```

### Example Usage ###
To run a the mri_deface command in this image, do the following:
```
docker run --rm -ti \
  -v </path/to/input/data>:/flywheel/v0/input/anatomical \
  -v </path/for/output/data>:/flywheel/v0/output \
  flywheel/mri-deface
```
* Note that you are mounting the directory (```-v``` flag) which contains the input data in the container at ```/flywheel/v0/input/anatomical``` and mounting the directory where you want your output data within the container at ```/flywheel/v0/output```.
