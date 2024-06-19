# Use the official R base image
FROM r-base:latest

# Install plumber
RUN R -e "install.packages(c('RPostgres', 'config', 'plumber'))"

# Copy your plumber API code to the Docker image
COPY . /app

# Set the working directory
WORKDIR /app

# Expose the port that your API will run on
EXPOSE 8000

# Define the command to run your API
CMD ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host = '0.0.0.0', port = 8000)"]
