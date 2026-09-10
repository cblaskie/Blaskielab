FROM ubuntu:26.04@sha256:513c074113a871b51a8d16ab445c88779d6452d937a164fb5cc479f32668a41d

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
