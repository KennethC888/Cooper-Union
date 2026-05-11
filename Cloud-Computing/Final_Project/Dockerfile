FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# Unbuffered output so Python print statements show up immediately in Docker logs
ENV PYTHONUNBUFFERED=1 
CMD ["python", "node.py"]