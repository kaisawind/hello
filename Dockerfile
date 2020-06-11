FROM golang:alpine AS builder
ENV GO111MODULE=on
# 替换原始apk地址
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
# 安装必备软件
RUN apk add upx make git
# 设置工作目录
WORKDIR /go/src/github.com/kaisawind/hello
# 设置GO代理
RUN go env -w GOPROXY=https://goproxy.io
RUN go build main.go

FROM alpine
LABEL MAINTAINER="kaisawind <wind.kaisa@gmail.com>"
COPY --from=builder /go/src/github.com/kaisawind/hello/main /main 
CMD ["/main"]