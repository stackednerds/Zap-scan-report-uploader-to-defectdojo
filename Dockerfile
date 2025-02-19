# Use Alpine Linux (lightweight)
FROM alpine:latest

# Install curl (required for API requests)
RUN apk add --no-cache curl bash

# Set working directory inside the container
WORKDIR /app

# Copy the script into the container
COPY upload.sh /app/upload.sh

# Ensure the script has execute permissions
RUN chmod +x /app/upload.sh && ls -l /app/upload.sh

# Set entrypoint
ENTRYPOINT ["/app/upload.sh"]
