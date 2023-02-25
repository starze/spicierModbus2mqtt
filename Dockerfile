#FROM python:alpine
# use old python to omit following errors:
# Error talking to slave device:30 (ReadHoldingRegistersRequest.__init__() got multiple values for argument 'unit')
FROM python:3.7-alpine

WORKDIR /app

COPY modbus2mqtt.py ./
COPY modbus2mqtt modbus2mqtt/

RUN mkdir -p /app/conf/

# upgrade pip to avoid warnings during the docker build
RUN pip install  --upgrade pip

RUN pip install  --no-cache-dir pyserial pymodbus
RUN pip install  --no-cache-dir paho-mqtt

ENTRYPOINT [ "python", "-u", "./modbus2mqtt.py", "--config", "/app/conf/modbus2mqtt.csv" ]
