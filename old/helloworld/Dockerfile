FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY src/ ./src/

WORKDIR /app/src

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/helloworld main.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/helloworld .

CMD ["./helloworld"]

