FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install -y \
    build-essential \
    make
WORKDIR app/
COPY Makefile sniffer.c ./
RUN make

FROM ubuntu:latest AS runner
WORKDIR app/
COPY --from=builder /app/sniffer ./
CMD ["sh", "-c", "./sniffer -l -b ${SPEED:=9600} -P ${PARITY:=N} -S ${STOP_BITS:=1} -t ${INTERVAL:=1500} -p ${SERIAL_PORT}"]
