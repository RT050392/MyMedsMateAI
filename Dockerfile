FROM python:3.9-slim

WORKDIR /app

# Copy requirements and install dependencies
COPY mymedsmate_requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose port
EXPOSE 8080

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "app:app"]