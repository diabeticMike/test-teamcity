FROM golang:1.19-buster AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

RUN go build -o /app ./main.go

FROM gcr.io/distroless/base-debian10

COPY --from=build /app /app

ENTRYPOINT ["/app/main"]
