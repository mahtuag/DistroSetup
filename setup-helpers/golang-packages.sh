printf "Begin Go Package Install Script"

printf "\n\n"
printf "dep - Go dependency tool"
printf "\n\n"
go get -u -v -t github.com/golang/dep

printf "\n\n"
printf "delve - a debugger for Go"
printf "\n\n"
go get -u -v -t github.com/derekparker/delve/cmd/dlv

printf "\n\n"
printf "gocode - an autocompletion daemon for Go"
printf "\n\n"
go get -u -v -t github.com/nsf/gocode

printf "\n\n"
printf "godef - prints where symbols are defined in Go source code"
printf "\n\n"
go get -u -v -t github.com/rogpeppe/godef

printf "\n\n"
printf "gogetdoc - gets documentation for items in Go source code"
printf "\n\n"
go get -u -v -t github.com/zmb3/gogetdoc

printf "\n\n"
printf "goimports - updates your import lines, adds missing ones, removes unreferenced ones"
printf "\n\n"
go get -u -v -t golang.org/x/tools/cmd/goimports

printf "\n\n"
printf "golint - the lint tool developed by Google for Go"
printf "\n\n"
go get -u -v -t github.com/golang/lint/golint

printf "\n\n"
printf "gometalinter - concurrently run go lint tools and normalize their output"
printf "\n\n"
go get -u -v -t github.com/alecthomas/gometalinter

printf "\n\n"
printf "gorename - precise, type-safe renaming of identifiers in Go source code"
printf "\n\n"
go get -u -v -t golang.org/x/tools/cmd/gorename

printf "\n\n"
printf "goreturns - a gofmt/goimports-like tool for Go programmers that fills in Go return statements with zero values to match the func return types"
printf "\n\n"
go get -u -v -t github.com/sqs/goreturns

printf "\n\n"
printf "guru - a tool for answering questions about Go source code"
printf "\n\n"
go get -u -v -t golang.org/x/tools/cmd/guru

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
