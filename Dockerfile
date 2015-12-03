FROM ubuntu:14.04
MAINTAINER dan@hammockdistrict.com

RUN apt-get update && apt-get install -y \
  build-essential \
  wget \
  curl \
  clang \
  libedit2 \
  libicu52

# Version variables
ENV SWIFT_BUILDS_DIR ubuntu1404
ENV SWIFT_VERSION 2.2-SNAPSHOT-2015-12-01-b
ENV SWIFT_PLATFORM ubuntu14.04

ENV SWIFT_DIST swift-${SWIFT_VERSION}-${SWIFT_PLATFORM}
ENV SWIFT_DIST_TGZ ${SWIFT_DIST}.tar.gz
ENV SWIFT_DIST_SIG ${SWIFT_DIST_TGZ}.sig

ENV SWIFT_SNAPSHOT https://swift.org/builds/${SWIFT_BUILDS_DIR}/swift-${SWIFT_VERSION}/${SWIFT_DIST_TGZ}
ENV SWIFT_SIGNATURE https://swift.org/builds/${SWIFT_BUILDS_DIR}/swift-${SWIFT_VERSION}/${SWIFT_DIST_SIG}

# install dir
ENV SWIFT_HOME /opt/swift

RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
RUN gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
RUN mkdir -p $SWIFT_HOME

WORKDIR $SWIFT_HOME

# Download and verify. Done with && to prevent layers with the tar.gz file
RUN curl -SLO $SWIFT_SIGNATURE \
  && curl -SLO $SWIFT_SNAPSHOT \
  && gpg --verify ${SWIFT_DIST_SIG} \
  && tar xzf $SWIFT_DIST_TGZ \
  && rm $SWIFT_DIST_TGZ $SWIFT_DIST_SIG

ENV PATH $SWIFT_HOME/$SWIFT_DIST/usr/bin:$PATH
