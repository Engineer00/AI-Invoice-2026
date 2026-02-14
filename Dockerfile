# AI Invoice Backend - Railway deploy
# Needs full repo (backend + invoice_extractor) for imports
FROM python:3.12-slim

WORKDIR /app

# Copy backend and invoice_extractor (required for import)
COPY backend/ ./backend/
COPY invoice_extractor/ ./invoice_extractor/

# Install dependencies
RUN pip install --no-cache-dir -r backend/requirements.txt

# Run from /app so backend can resolve REPO_ROOT and import invoice_extractor
WORKDIR /app
EXPOSE 8000

CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT --app-dir backend
