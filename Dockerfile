FROM golang:1.21 AS builder

WORKDIR /app
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -o app

FROM gcr.io/distroless/static:nonroot

COPY --from=builder /app/app /

USER nonroot
ENTRYPOINT ["/app"]
