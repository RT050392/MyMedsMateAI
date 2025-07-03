FROM python:3.9-slim

WORKDIR /app

# Copy requirements and install dependencies
COPY mymedsmate_requirements.txt .
RUN pip install --no-cache-dir -r mymedsmate_requirements.txt

# Copy application files
COPY . .

# Expose port 8080 (Cloud Run default)
EXPOSE 8080

# Run the application
CMD ["python", "main.py"]