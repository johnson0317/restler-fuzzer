FROM mcr.microsoft.com/dotnet/sdk:6.0 as builder
USER root
RUN apt-get update -y && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y 

COPY src ./src
COPY restler ./restler
COPY build-restler.py .

RUN python3 build-restler.py --dest_dir /build

RUN python3 -m compileall -b /build/engine

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as target

USER root
RUN mkdir /app
RUN apt-get update -y && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y && \
    apt-get install curl -y

RUN python3 -m pip install requests applicationinsights
COPY --from=builder /build /RESTler

COPY ./script.sh .
COPY ./merge-files.py .


CMD ["./script.sh", "http://localhost:9000/api/v1/openapi.json", "localhost", "9000", "1"]
