FROM ubuntu:26.04@sha256:6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      imagemagick \
      inotify-tools \
      libheif1 \
      libheif-examples && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY router.sh /router.sh
RUN chmod +x /router.sh

ENTRYPOINT ["/router.sh"]
