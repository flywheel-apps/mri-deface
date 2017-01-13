# flywheel/mri-deface

# start with ubuntu
FROM ubuntu:trusty
MAINTAINER Jennifer Reiter <jenniferreiter@invenshure.com>

# Install gzip and wget
RUN apt-get update && apt-get -y install \
    unzip \
    gzip \
    wget

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}
COPY run ${FLYWHEEL}/run
COPY manifest.json ${FLYWHEEL}/manifest.json

# Install jq to parse the JSON config file
RUN wget -N -qO- -O /usr/bin/jq http://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x /usr/bin/jq

# Download Free Surfer Deface from MGH and additional files needed for Defacing algorithm
RUN wget -N -qO- -O ${FLYWHEEL}/mri_deface.gz ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/mri_deface-v1.22-Linux64.gz && gunzip ${FLYWHEEL}/mri_deface.gz
RUN wget -N -qO- -O ${FLYWHEEL}/face.gca.gz ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/face.gca.gz && gunzip ${FLYWHEEL}/face.gca.gz
RUN wget -N -qO- -O ${FLYWHEEL}/talairach_mixed_with_skull.gca.gz ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/talairach_mixed_with_skull.gca.gz && gunzip ${FLYWHEEL}/talairach_mixed_with_skull.gca.gz
RUN chmod +x /flywheel/v0/mri_deface

# Set the entrypoint
ENTRYPOINT ["/flywheel/v0/run"]
