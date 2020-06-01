FROM ubuntu:18.04

RUN apt update && apt install -y git curl python3-dev python3-pip 
#autoconf automake libtool make g++

# install go
ENV GO_VERSION 1.14.3
RUN curl -Lo go.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p $GOPATH/src $GOPATH/bin && chmod -R 777 $GOPATH
WORKDIR $GOPATH

# install bazel
ENV BAZEL_VERSION 1.1.0
RUN curl -Lo /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v${BAZEL_VERSION}/bazelisk-linux-amd64 && \
    chmod +x /usr/local/bin/bazel && bazel version

# install protobuf 
RUN apt install -y libprotobuf-dev protobuf-compiler
#ENV PROTO_VERSION 3.12.2
#RUN curl -Lo proto.tar.gz https://github.com/protocolbuffers/protobuf/releases/download/v${PROTO_VERSION}/protobuf-all-${PROTO_VERSION}.tar.gz && \
#    tar -xzf proto.tar.gz && rm proto.tar.gz && \
#    cd protobuf-${PROTO_VERSION} && ./configure && make && make check && make install && ldconfig

# download tensorflow source
RUN go get -d github.com/tensorflow/tensorflow/tensorflow/go; exit 0
RUN pip3 install -U pip six numpy wheel setuptools mock && link /usr/bin/python3 /usr/bin/python
RUN cd ${GOPATH}/src/github.com/tensorflow/tensorflow && \
    git checkout v2.1.0  && \
    ./configure && bazel build --jobs=1 -c opt  //tensorflow:libtensorflow.so

ENV LD_LIBRARY_PATH ${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
ENV LIBRARY_PATH ${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow

# build tensorflow go
RUN go generate github.com/tensorflow/tensorflow/tensorflow/go/op; exit 0 && \
    go test github.com/tensorflow/tensorflow/tensorflow/go; exit 0

