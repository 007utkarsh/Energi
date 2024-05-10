FROM alpine:latest

# Set environment variables
ENV ENERGI_VERSION=v1.1.7
ENV ENERGI_CHECKSUM_URL=https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/${ENERGI_VERSION}/SHA256SUMS
ENV ENERGI_DOWNLOAD_URL=https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/${ENERGI_VERSION}/energi3-${ENERGI_VERSION}-linux-amd64.tar.gz

# Install required packages (curl for downloading, gnupg for verification)
RUN apk --no-cache add curl gnupg

# Create a non-root user
RUN adduser -D energiuser

# Switch to non-root user
USER energiuser

# Download and verify the Energi release
RUN cd /tmp \
    && curl -LO ${ENERGI_DOWNLOAD_URL} \
    && curl -LO ${ENERGI_CHECKSUM_URL} \
    && sha256sum -c SHA256SUMS \
    && tar -xzf energi3-${ENERGI_VERSION}-linux-amd64.tar.gz -C /tmp \
    && mv /tmp/energi3-${ENERGI_VERSION}-linux-amd64/energi /home/energiuser/ \
    && rm -rf /tmp/*

# Define working directory
WORKDIR /home/energiuser

# Set permissions for the Energi executable
RUN chmod +x energi

# Expose necessary ports
EXPOSE 39797 39798

# Run the Energi client and print output to console
CMD ["./energi", "-daemon"]
