"""
MyMedsMate - Main entry point for Google Cloud deployment
"""

import os
import sys
from app import app

if __name__ == "__main__":
    try:
        # Use Cloud Run's PORT environment variable or default to 8080
        port = int(os.environ.get("PORT", 8080))
        print(f"Starting MyMedsMate on port {port}")
        
        # Ensure the app starts properly
        app.run(host="0.0.0.0", port=port, debug=False, threaded=True)
    except Exception as e:
        print(f"Failed to start application: {e}")
        sys.exit(1)