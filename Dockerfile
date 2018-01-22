FROM debian:testing

LABEL maintainer Diego Diez <diego10ruiz@gmail.com>

ENV VERSION=2.27.1

RUN apt-get update -y && \
    apt-get install -y \
      curl \
      g++ \
      make \
      python \
      zlib1g \
      zlib1g-dev \
      && \
    curl -L https://github.com/arq5x/bedtools2/releases/download/v$VERSION/bedtools-$VERSION.tar.gz > /tmp/bedtools-$VERSION.tar.gz && \
    cd /tmp && \
    tar xfzv bedtools-$VERSION.tar.gz && \
    cd bedtools2 && \
    make prefix=/opt install && \
    rm /tmp/bedtools-$VERSION.tar.gz && \
    rm -rf /tmp/bedtools2 && \
    apt-get clean -y && \
    apt-get purge -y \
      curl \
      g++ \
      make \
      python \
      zlib1g-dev \
      && \
    apt-get autoremove -y

ENV PATH /opt/bin:$PATH

# User.
RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev

CMD ["/bin/bash"]
