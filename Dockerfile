# Use a base image
FROM ubuntu:latest

# Install required packages (curl for downloading, adduser for creating non-root user)
RUN apt-get update && apt-get install -y curl adduser

# Create a non-root user
RUN adduser --disabled-password --gecos '' energiuser

# Switch to non-root user
USER energiuser

# Define working directory
WORKDIR /home/energiuser

# Set environment variables
ENV ENERGI_VERSION=v1.1.7
ENV ENERGI_CHECKSUM_URL=https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/${ENERGI_VERSION}/SHA256SUMS
ENV ENERGI_DOWNLOAD_URL=https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/${ENERGI_VERSION}/energi3-${ENERGI_VERSION}-linux-amd64.tgz

# Download the SHA256SUMS file and the Energi release
RUN curl -LO ${ENERGI_CHECKSUM_URL} \
    && curl -LvO ${ENERGI_DOWNLOAD_URL}

RUN grep energi3-v1.1.7-linux-amd64.tgz SHA256SUMS > checksum.txt

# Verify the checksum
RUN sha256sum -c checksum.txt || exit 1


EXPOSE 39797 39798

# Run the Energi client and print output to console
CMD ["./energi3-${ENERGI_VERSION}-linux-amd64/bin/energi3", "-daemon"]
