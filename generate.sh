docker compose run protoc \
    -I=/proto \
    --go_out=/gen \
    --go_opt=module=github.com/cvetkovski98/zvax-common \
    --go-grpc_out=. \
    --go-grpc_opt=module=github.com/cvetkovski98/zvax-common \
    /proto/*/*.proto
