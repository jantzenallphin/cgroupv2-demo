FROM golang:1.19-alpine AS build
WORKDIR /build
ADD . ./
RUN go mod download
RUN go build -o /cgroupsv2-demo
RUN addgroup -S demo && adduser -S demo -G demo


FROM scratch AS final
COPY --from=build /etc/passwd /etc/passwd
USER demo
COPY --from=build /cgroupsv2-demo /cgroupsv2-demo
ENTRYPOINT ["/cgroupsv2-demo"]
