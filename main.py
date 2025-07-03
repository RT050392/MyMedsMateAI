"""
MyMedsMate - Main entry point for Google Cloud deployment
"""

import os
from app import app

if __name__ == "__main__":
    # Use Cloud Run's PORT environment variable or default to 8080
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port, debug=False)