FROM golang:1.21 AS build

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o app

FROM debian:bookworm-slim

WORKDIR /app
COPY --from=build /app/app .

ENTRYPOINT ["./app"]
