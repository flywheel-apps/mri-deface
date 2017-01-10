# flywheel/mri-deface

# start with ubuntu
FROM ubuntu:trusty
MAINTAINER Jennifer Reiter <jenniferreiter@invenshure.com>

# Install gzip and wget
RUN apt-get update \
    && apt-get -y install unzip gzip wget
# Download Free Surfer Deface from MGH
RUN cd /opt && wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/mri_deface-v1.22-Linux64.gz
# Download additional files needed for Defacing algorithm
RUN cd /opt && wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/face.gca.gz
RUN cd /opt && wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/talairach_mixed_with_skull.gca.gz

# Unzip all of the gz files
RUN cd /opt && gunzip talairach_mixed_with_skull.gca.gz
RUN cd /opt && gunzip face.gca.gz
RUN cd /opt && gunzip mri_deface-v1.22-Linux64.gz

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}
COPY run ${FLYWHEEL}/run
COPY manifest.json ${FLYWHEEL}/manifest.json

# Install jq to parse the JSON config file
RUN cd /usr/bin && wget http://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x /usr/bin/jq

# Copy all files over to /flywheel/v0 and rename mri_deface-v1.22-Linux to mri_deface
RUN cp /opt/talairach_mixed_with_skull.gca /flywheel/v0
RUN cp /opt/face.gca /flywheel/v0
RUN cp /opt/mri_deface-v1.22-Linux64 /flywheel/v0/mri_deface
RUN chmod a+x /flywheel/v0/mri_deface

# Cleanup files from /opt
RUN rm /opt/*

# Set the entrypoint
ENTRYPOINT ["/flywheel/v0/run"]