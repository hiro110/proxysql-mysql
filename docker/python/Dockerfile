FROM --platform=linux/arm64 python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    default-mysql-client \
    gettext

COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./app.py app.py

EXPOSE 8080

CMD ["python", "app.py"]