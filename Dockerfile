# This is a full version of Dockerfile, which remains all the build tools and dependencies.
FROM alpine:latest
EXPOSE 80

# Work directory
ENV PROJECT_DIR /archives_of_wind
# Set project name in CMakeLists.txt
ENV PROJECT_NAME archives_of_wind
# Set executable output path in CMakeLists.txt
ENV EXECUTABLE_OUTPUT_PATH $PROJECT_DIR/bin
# Executable path
ENV EXECUTABLE_PATH $EXECUTABLE_OUTPUT_PATH/$PROJECT_NAME

WORKDIR $PROJECT_DIR
COPY . $PROJECT_DIR/

# Install dependencies:
# - gcc, g++, cmake, make, git: build tools
# - drogon and its dependencies:
#   - mysql-dev: mysql client
#   - hiredis-dev, hiredis: redis client
#   - openssl-dev, openssl: ssl
#   - jsoncpp-dev, jsoncpp: json parser
#   - util-linux-dev, util-linux: uuid
#   - zlib-dev, zlib: zlib
#   - c-ares-dev, c-ares: c-ares
# - google test: unit test
# - google benchmark: benchmark
# - protobuf: protobuf
RUN apk update && \
    apk add --upgrade --no-cache gcc g++ cmake make git mysql-dev hiredis-dev hiredis openssl-dev openssl jsoncpp-dev jsoncpp util-linux-dev util-linux zlib-dev zlib c-ares-dev c-ares gtest-dev gtest benchmark-dev benchmark protobuf-dev protobuf && \
    git clone https://github.com/open-source-parsers/jsoncpp && \
    cd jsoncpp/ && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd $PROJECT_DIR && \
    git clone https://github.com/drogonframework/drogon && \
    cd drogon/ && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd $PROJECT_DIR && \
    cmake -S . -B build && \
    cmake --build build

CMD $EXECUTABLE_PATH
