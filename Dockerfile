FROM golang:1.19 AS builder

RUN apt-get update && \
    apt-get install -y unzip \
    curl

# Download proto zip
ENV PROTOC_VERSION=21.12
ENV PROTOC_ZIP=protoc-${PROTOC_VERSION}-linux-x86_64.zip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${PROTOC_ZIP}
RUN unzip -o ${PROTOC_ZIP} -d ./proto
RUN chmod 755 -R ./proto/bin

# Copy into path
ENV BASE=/usr
RUN cp ./proto/bin/protoc ${BASE}/bin/
RUN cp -R ./proto/include/* ${BASE}/include/

# install go protocol buffers
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# remove downloaded files
RUN rm -f ${PROTOC_ZIP}

WORKDIR /app/common

# copy proto files
COPY . .

# generate Go code
RUN protoc \
    -I=./ \
    --go_out=./ \
    --go_opt=module=github.com/cvetkovski98/zvax-common \
    --go-grpc_out=./ \
    --go-grpc_opt=module=github.com/cvetkovski98/zvax-common \
    ./proto/*/*.proto

FROM scratch AS final

WORKDIR /app/common

COPY --from=builder /app/common .
