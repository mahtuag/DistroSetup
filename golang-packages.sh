echo "Begin Go Package Install Script"

echo "gometalinter - lint 'em all"
go get -u -v -t github.com/alecthomas/gometalinter
gometalinter --install

echo "yaml2json - useful utility"
go get -u -v -t github.com/bronze1man/yaml2json

echo "xsdgen - structs from XSD"
go get -u -v -t aqwari.net/xml/cmd/xsdgen

echo "gojsondiff - diff JSON files in Go"
go get -u -v -t github.com/yudai/gojsondiff/jd

echo "Buffalo - API Development in Go"
go get -u -v -tags sqlite github.com/gobuffalo/buffalo/buffalo

echo "Cobra - CLI Manager"
go get -u -v -t github.com/spf13/cobra/cobra

echo "GRPC and Protocol Buffers stuff"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

echo "jsonnet"
go get -u -v -t github.com/google/go-jsonnet/jsonnet

echo "Delve with GUI"
go get -u -v -t github.com/go-delve/delve/cmd/dlv
go get -u -v -t github.com/aarzilli/gdlv

echo "End Go Package Install Script"
