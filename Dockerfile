# Docker image for the DevOps student application (Alibek Konayev)
FROM python:3.12-slim

# All following instructions run inside /app
WORKDIR /app

# Copy only the application code into the image
COPY app/ /app/

# Build-time commands: check that the code compiles, create a log folder
RUN python -m py_compile /app/app.py && mkdir -p /app/logs

# Default student data; can be overridden with: docker run -e STUDENT_NAME=...
ENV STUDENT_NAME="Alibek" \
    STUDENT_SURNAME="Konayev" \
    STUDENT_GROUP="IT2-2304" \
    STUDENT_ID="38386" \
    APP_PORT=5000 \
    PYTHONUNBUFFERED=1

# The application listens on this port (documentation; publish with -p)
EXPOSE 5000

# Command executed when the container starts
CMD ["python", "app.py"]
