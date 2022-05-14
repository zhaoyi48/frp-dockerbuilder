FROM alpine:latest

ADD builds/frp/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*
ENV TZ=Asia/Shanghai
USER nobody

CMD echo $EXEC_COMMAND && $EXEC_COMMAND
