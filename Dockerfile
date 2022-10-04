FROM swift:5.7

ARG SWIFT_RELEASENOTES_REPOSITORY="https://github.com/SwiftPackageIndex/ReleaseNotes.git"
ARG SWIFT_RELEASENOTES_BRANCH="main"

LABEL Description="Docker Container for GitHub action swift-package-dependencies-check"
LABEL repository="http://github.com/MarcoEidinger/swift-package-dependencies-check/edit/main/Dockerfile"
LABEL maintainer="Marco Eidinger <eidingermarco@gmail.com>"

RUN git clone -b  $SWIFT_RELEASENOTES_BRANCH $SWIFT_RELEASENOTES_REPOSITORY _swift-release-notes \
    && cd _swift-release-notes \
    && git checkout 7a2ea33cc4731e93797f8447fb430ffe20b6afed \
    && apt-get update \
    && apt-get install make \
    && make install \
    && cd

ADD entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
