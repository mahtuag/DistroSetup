echo "Begin Go Package Install Script"

echo "\n\n"
echo "delve - a debugger for Go"
go get -u -v -t github.com/derekparker/delve/cmd/dlv

echo "\n\n"
echo "gocode - an autocompletion daemon for Go"
go get -u -v -t github.com/nsf/gocode

echo "\n\n"
echo "godef - prints where symbols are defined in Go source code"
go get -u -v -t github.com/rogpeppe/godef

echo "\n\n"
echo "gogetdoc - gets documentation for items in Go source code"
go get -u -v -t github.com/zmb3/gogetdoc

echo "\n\n"
echo "goimports - updates your import lines, adds missing ones, removes unreferenced ones"
go get -u -v -t golang.org/x/tools/cmd/goimports

echo "\n\n"
echo "golint - the lint tool developed by Google for Go"
go get -u -v -t github.com/golang/lint/golint

echo "\n\n"
echo "gometalinter - concurrently run go lint tools and normalize their output"
go get -u -v -t github.com/alecthomas/gometalinter

echo "\n\n"
echo "gorename - precise, type-safe renaming of identifiers in Go source code"
go get -u -v -t golang.org/x/tools/cmd/gorename

echo "\n\n"
echo "goreturns - a gofmt/goimports-like tool for Go programmers that fills in Go return statements with zero values to match the func return types"
go get -u -v -t github.com/sqs/goreturns

echo "\n\n"
echo "guru - a tool for answering questions about Go source code"
go get -u -v -t golang.org/x/tools/cmd/guru

echo "\n\n"
echo "protoc-gen-go"
go get -u -v -t github.com/golang/protobuf/protoc-gen-go
echo "\n\n"
echo "protoc-gen-grpc-gateway"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
echo "\n\n"
echo "protoc-gen-swagger"
go get -u -v -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

echo "\n\n"
echo "End Go Package Install Script"
