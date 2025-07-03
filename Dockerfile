FROM python:3.9-slim

WORKDIR /app

# Copy requirements and install dependencies
COPY mymedsmate_requirements.txt .
RUN pip install --no-cache-dir -r mymedsmate_requirements.txt

# Copy application files
COPY . .

# Set default PORT if not provided
ENV PORT=8080

# Expose the port
EXPOSE $PORT

# Use gunicorn for production deployment with explicit port binding
CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 main:app
