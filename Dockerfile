FROM alpine

RUN apk update && apk add bash iperf3
ENTRYPOINT ["/bin/bash"]