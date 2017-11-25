printf "Begin Go Package Install Script"

printf "\n\ndep - Go dependency tool\n\n"
go get -u -v -t github.com/golang/dep/cmd/dep

printf "\n\ngometalinter - lint 'em all\n\n"
go get -u -v -t github.com/alecthomas/gometalinter
gometalinter --install

printf "\n\nxsdgen - structs from XSD\n\n"
go get -u -v -t aqwari.net/xml/cmd/xsdgen

printf "\n\nprotoc-gen-go\n\n"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
printf "\n\nprotoc-gen-grpc-gateway\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
printf "\n\nprotoc-gen-swagger\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

printf "\n\n"
printf "\n\nEnd Go Package Install Script\n\n"
