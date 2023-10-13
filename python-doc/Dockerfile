# Use an official Python runotime as a parent image
ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run app.py when the container launches
CMD ["python", "app.py"]

