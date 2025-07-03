FROM python:3.9-slim

WORKDIR /app

# Copy requirements and install dependencies
COPY mymedsmate_requirements.txt .
RUN pip install --no-cache-dir -r mymedsmate_requirements.txt

# Copy application files
COPY . .

# Expose port (Cloud Run uses PORT env var)
EXPOSE $PORT

# Run the application with proper port binding
CMD python main.py