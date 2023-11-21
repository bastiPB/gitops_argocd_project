FROM python:3.9-slim-buster
RUN pip install flask
WORKDIR /app
COPY app.py .
EXPOSE 5001
ENTRYPOINT [ "python","app.py" ]
