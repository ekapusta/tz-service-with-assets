FROM racemap/tz-service

WORKDIR /app

COPY assets.sh .

RUN ./assets.sh
