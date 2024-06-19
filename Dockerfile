# Use the official R base image
FROM rocker/r-ver:latest

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev \
  libicu-dev \
  libsodium-dev \
  libssl-dev \
  make \
  zlib1g-dev \
  && apt-get clean
  
# Install plumber
RUN Rscript -e "install.packages('renv')"
RUN Rscript -e "renv::restore()"

# Copy your plumber API code to the Docker image
COPY . /app

# Set the working directory
WORKDIR /app

# Expose the port that your API will run on
EXPOSE 7680

# Define the command to run your API
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host = '0.0.0.0', port = 7680)"]
