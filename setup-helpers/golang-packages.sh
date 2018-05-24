printf "Begin Go Package Install Script"

printf "\n\ndep - Go dependency tool\n\n"
go get -u -v -t github.com/golang/dep/cmd/dep

printf "\n\ngometalinter - lint 'em all\n\n"
go get -u -v -t github.com/alecthomas/gometalinter
gometalinter --install

printf "\n\nyaml2json - useful utility\n\n"
go get -u -v -t github.com/bronze1man/yaml2json

printf "\n\nxsdgen - structs from XSD\n\n"
go get -u -v -t aqwari.net/xml/cmd/xsdgen

printf "\n\ngojsondiff - diff JSON files in Go\n\n"
go get -u -v -t github.com/yudai/gojsondiff/jd

printf "\n\nBuffalo - API Development in Go\n\n"
go get -u -v -t github.com/gobuffalo/buffalo/buffalo


printf "\n\nCobra - CLI Manager\n\n"
go get -u -v -t github.com/spf13/cobra/cobra

printf "\n\nprotoc-gen-go\n\n"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
printf "\n\nprotoc-gen-grpc-gateway\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
printf "\n\nprotoc-gen-swagger\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

printf "\n\njsonnet\n"
go get -u -v -t github.com/google/go-jsonnet/jsonnet

printf "\n\n"
printf "\n\nEnd Go Package Install Script\n\n"
