# Tensorflow in Go Docker image

Docker image to succesfully run tensorflow 2.1 in Go.

## Getting started

Due to the fact that regular installation of tensorflow in Go does not work as specified in [here](https://www.tensorflow.org/install/lang_go), the Tensorflow C library must be build from source accroding to [this](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/go/README.md).

The Docker image is built form Ubuntu 18.04, latest version of Go is installed, protocol buffer compiler is installed and bazelisk is used to automatically pick the right version of Bazel to build the C library.

A git checkout is made to reverse to version 2.1 of tensorflow, where the library for Go works with no problems.

## Built with

* [Tensorflow](https://github.com/tensorflow/tensorflow)
* [Go](https://golang.org/)
* [Docker](https://www.docker.com/)
* [Bazelisk](https://github.com/bazelbuild/bazelisk)
* [Bazelisk instructions](https://gist.github.com/philwo/f3a8144e46168f23e40f291ffe92e63c)

## Author

* **Juan Pablo Rojas ** - [Github](https://github.com/jp-rojas)
