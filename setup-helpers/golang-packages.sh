printf "Begin Go Package Install Script"

printf "\n\n"
printf "dep - Go dependency tool"
printf "\n\n"
go get -u -v -t github.com/golang/dep/cmd/dep

printf "\n\n"
printf "xsdgen; make sure you remove UseFieldNames() from config and recompile"
printf "\n\n"
go get -u -v -t aqwari.net/xml/cmd/xsdgen

printf "\n\n"
printf "protoc-gen-go"
printf "\n\n"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
printf "\n\n"
printf "protoc-gen-grpc-gateway"
printf "\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
printf "\n\n"
printf "protoc-gen-swagger"
printf "\n\n"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

printf "\n\n"
printf "End Go Package Install Script"
