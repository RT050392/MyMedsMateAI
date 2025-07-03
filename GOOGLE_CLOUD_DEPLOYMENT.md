# Google Cloud Deployment Guide for MyMedsMate

## The Python Version Issue

The error you encountered is due to Google Cloud trying to use Python 3.13, which has compatibility issues with some dependencies (especially numpy/pandas).

## Solution: Force Python 3.9

### Option 1: Google Cloud Run with Docker (Recommended for your case)

1. **Update app.yaml** (already done):
```yaml
runtime: python39
entrypoint: python main.py

env_variables:
  FLASK_ENV: production
  OPENAI_API_KEY: "your-openai-api-key-here"  # Add your actual key here

automatic_scaling:
  min_instances: 0
  max_instances: 10
  target_cpu_utilization: 0.6

resources:
  cpu: 1
  memory_gb: 1
```

2. **Deploy**:
```bash
gcloud app deploy app.yaml
```

### Option 2: Google Cloud Run with Dockerfile

Create a `Dockerfile` with explicit Python 3.9:
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY mymedsmate_requirements.txt .
RUN pip install -r mymedsmate_requirements.txt

COPY . .
EXPOSE 5000

CMD ["python", "main.py"]
```

Deploy:
```bash
gcloud run deploy mymedsmate \
  --source . \
  --set-env-vars OPENAI_API_KEY="your-openai-api-key" \
  --allow-unauthenticated \
  --port=5000
```

### Option 3: Use .python-version file

Create `.python-version` file:
```
3.9.18
```

## Updated Requirements (Compatible Versions)

The `mymedsmate_requirements.txt` now uses version ranges for better compatibility:
```
Flask>=2.3.0,<3.0.0
azure-storage-blob>=12.17.0,<13.0.0
pandas>=2.0.0,<2.2.0
numpy>=1.24.0,<2.0.0
Werkzeug>=2.3.0,<3.0.0
gunicorn>=21.0.0,<22.0.0
openai>=1.3.0,<2.0.0
```

## Environment Variables Required

Only one environment variable is needed:
- `OPENAI_API_KEY`: Your OpenAI API key

## Deployment Steps

1. **Set your OpenAI API key** in `app.yaml`:
   ```yaml
   env_variables:
     FLASK_ENV: production
     OPENAI_API_KEY: "sk-your-actual-openai-api-key-here"
   ```

2. **Deploy to App Engine**:
   ```bash
   gcloud app deploy app.yaml
   ```

3. **Test the deployment**:
   ```bash
   gcloud app browse
   ```

## Resource Requirements

- **Memory**: 1 GB (recommended)
- **CPU**: 1 vCPU
- **Scaling**: 0-10 instances (auto-scale)

## Default Login Credentials

- Username: `admin`
- Password: `admin`

## Troubleshooting

If you still get Python version errors:
1. Use the Dockerfile approach (Option 2)
2. Or specify `python_version: "3.9"` in your app.yaml
3. Ensure you're using the updated requirements file with version ranges

The app should now deploy successfully on Google Cloud Platform!