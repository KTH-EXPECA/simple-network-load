FROM alpine

RUN apk update && apk add bash iperf3 iputils
ENTRYPOINT ["/bin/bash"]