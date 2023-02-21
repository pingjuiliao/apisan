FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y git build-essential sudo cmake python3-dev python3-pip python-dev python-pip libboost-all-dev

WORKDIR /workdir/apisan
COPY . /workdir/apisan

RUN mkdir -p bin/llvm
RUN cd bin/llvm && cmake ../../llvm -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Release
RUN cd bin/llvm && make -j8
RUN pip3 install ply
