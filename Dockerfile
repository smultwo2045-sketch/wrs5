FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    WRS_DATA_DIR=/data \
    PYTHONPATH=/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY app ./app
COPY start.sh ./start.sh
RUN chmod +x ./start.sh && mkdir -p /data

EXPOSE 8000

CMD ["./start.sh"]
