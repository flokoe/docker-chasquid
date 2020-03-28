# Stage for building the binaries.
FROM golang:1.13-buster AS build

ENV CHASQUID_VERSION v1.2

# Clone specific version (branch/tag) of chasquid repository
RUN git clone -b ${CHASQUID_VERSION} --single-branch https://blitiri.com.ar/repos/chasquid

WORKDIR /go/chasquid

# Run make to build all binaries
RUN make all


# Stage for final chasquid image
FROM debian:buster-slim

LABEL maintainer="Florian Koehler"

EXPOSE 25/tcp 465/tcp 587/tcp

#VOLUME /etc/chasquid/domains
#VOLUME /etc/chasquid/certs
#VOLUME /var/lib/chasquid

# Copy all needed binaries from building stage
COPY --from=build /go/chasquid/chasquid /usr/local/bin/
COPY --from=build /go/chasquid/chasquid-util /usr/local/bin/
COPY --from=build /go/chasquid/smtp-check /usr/local/bin/

# Copy conf files and entrypoint script
COPY conf /etc/chasquid
COPY run.sh /

# Make binaries executable
RUN chmod +x /usr/local/bin/chasquid /usr/local/bin/chasquid-util /usr/local/bin/smtp-check

#ENTRYPOINT ["/run.sh"]
CMD ["/run.sh"]

