FROM golang:1.15.6-alpine3.12 as builder

RUN apk add --update --no-cache git

RUN go get -v github.com/googleapis/google-cloud-go/bigtable/cmd/emulator/...

FROM alpine:3.13.1

COPY --from=builder /go/bin/emulator /cbtemulator

ENTRYPOINT ["/cbtemulator"]
CMD ["--host=0.0.0.0", "--port=8086"]
