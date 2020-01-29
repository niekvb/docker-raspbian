# Use Raspbian stretch as base image
FROM balenalib/rpi-raspbian:stretch

# Install prerequisites for compiling Python 3.7.6
RUN apt-get update && apt-get install -y build-essential checkinstall
RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev \
  libgdbm-dev libc6-dev libbz2-dev libffi-dev wget tar

# Download and extract Python source
WORKDIR /usr/src/python/
RUN wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz && tar xzf Python-3.7.6.tgz

# Compile, build and install Python
WORKDIR /usr/src/python/Python-3.7.6/
RUN ./configure --enable-optimizations && make altinstall
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python \
  && ln -s /usr/local/bin/python3.7 /usr/bin/python3 \
  && ln -s /usr/local/bin/python3.7 /usr/bin/python3.7 \
  && ln -s /usr/local/bin/pip3.7 /usr/bin/pip \
  && ln -s /usr/local/bin/pip3.7 /usr/bin/pip3 \
  && ln -s /usr/local/bin/pip3.7 /usr/bin/pip3.7

# Remove Python source code
RUN rm -R /usr/src/python/
WORKDIR /

CMD ["/bin/echo", "Entrypoint is undefined! Use this image as base for other Docker images..."]
