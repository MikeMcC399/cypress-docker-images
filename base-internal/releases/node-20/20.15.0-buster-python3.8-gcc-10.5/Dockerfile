# build it with command
#   docker build -t cypress/base-internal:20.15.0-buster-python3.8-gcc-10.5 --platform linux/amd64 .
#
FROM cypress/base-internal:20.15.0-buster

RUN apt-get update && \
  apt-get install -y \
  wget \
  xz-utils \
  bzip2 \
  make \
  autoconf \
  gcc-multilib \
  g++-multilib \
  # clean up
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean


# Install GCC 10.5. Note that there may be ways to optimize this
# but it is functional and takes a long time to build (over 8 hours)
# so it is not worth optimizing for now
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-10.5.0/gcc-10.5.0.tar.gz \
  && tar xf gcc-10.5.0.tar.gz \
  && cd gcc-10.5.0 \
  && wget https://gmplib.org/download/gmp/gmp-6.2.0.tar.xz \
  && tar xf gmp-6.2.0.tar.xz \
  && mv gmp-6.2.0 gmp \
  && wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz \
  && tar xf mpfr-4.1.0.tar.gz \
  && mv mpfr-4.1.0 mpfr \
  && wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz \
  && tar xf mpc-1.2.1.tar.gz \
  && mv mpc-1.2.1 mpc \
  && wget ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2 \
  && tar xf isl-0.18.tar.bz2 \
  && mv isl-0.18 isl \
  && ./configure --prefix=/usr --enable-languages=c,c++ \
  && make -j$(nproc) \
  && make install
  
# Clean up
RUN rm -rf gcc-10.5.0 gcc-10.5.0.tar.gz

# Install Python 3.8
RUN wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
RUN tar xvf Python-3.8.0.tgz
RUN cd Python-3.8.0 && ./configure --enable-optimizations --prefix=/usr && make altinstall
RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3
# Clean up
RUN rm -rf Python-3.8.0 Python-3.8.0.tgz
