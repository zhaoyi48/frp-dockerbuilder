FROM alpine:latest

ADD builds/frp/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*
ENV TZ=Asia/Shanghai
USER nobody
# ENV EXEC_COMMAND="xray run -c /etc/xray/config.json"
CMD echo $EXEC_COMMAND && $EXEC_COMMAND
