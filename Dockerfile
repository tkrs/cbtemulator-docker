FROM golang:1.16.5-alpine3.12 as builder

RUN apk add --update --no-cache git

RUN go get -v github.com/googleapis/google-cloud-go/bigtable/cmd/emulator/...

FROM alpine:3.12

COPY --from=builder /go/bin/emulator /cbtemulator

ENTRYPOINT ["/cbtemulator"]
CMD ["--host=0.0.0.0", "--port=8086"]
