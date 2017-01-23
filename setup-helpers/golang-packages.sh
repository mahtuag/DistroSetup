echo "Begin Go Package Install Script"

echo "delve - a debugger for Go"
go get -u -v -t github.com/derekparker/delve/cmd/dlv

echo "gocode - an autocompletion daemon for Go"
go get -u -v -t github.com/nsf/gocode

echo "godef - prints where symbols are defined in Go source code"
go get -u -v -t github.com/rogpeppe/godef

echo "gogetdoc - gets documentation for items in Go source code"
go get -u -v -t github.com/zmb3/gogetdoc

echo "goimports - updates your import lines, adds missing ones, removes unreferenced ones"
go get -u -v -t golang.org/x/tools/cmd/goimports

echo "gometalinter - concurrently run go lint tools and normalize their output"
go get -u -v -t github.com/alecthomas/gometalinter

echo "gorename - precise, type-safe renaming of identifiers in Go source code"
go get -u -v -t golang.org/x/tools/cmd/gorename

echo "goreturns - a gofmt/goimports-like tool for Go programmers that fills in Go return statements with zero values to match the func return types"
go get -u -v -t github.com/sqs/goreturns

echo "guru - a tool for answering questions about Go source code"
go get -u -v -t golang.org/x/tools/cmd/guru

echo "protoc-gen-go"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
echo "protoc-gen-grpc-gateway"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
echo "protoc-gen-swagger"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

echo "End Go Package Install Script"
