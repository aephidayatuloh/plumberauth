# Use the official R base image
FROM rocker/r-ver:4.4.0

ENV RENV_CONFIG_REPOS_OVERRIDE https://packagemanager.rstudio.com/cran/latest

# create a non-root user to run the app
RUN useradd --create-home appuser

# Set the working directory
ENV HOME=/home/appuser
WORKDIR $HOME

# Create the .cache directory and give appuser permission to write to it
RUN mkdir -p /home/appuser/.cache && chown -R appuser:appuser /home/appuser/.cache
# Create the .cache/pins/url directory and give appuser permission to write to it
RUN mkdir -p /home/appuser/.cache/pins/url && chown -R appuser:appuser /home/appuser/.cache/pins/url

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev \
  libicu-dev \
  libsodium-dev \
  libssl-dev \
  libpq-dev \ 
  libxml2-dev \ 
  make \
  zlib1g-dev \
  && apt-get clean
  

# Copy your plumber API code to the Docker image
COPY renv.lock renv.lock

# Install packages
RUN Rscript -e "install.packages('renv')"
RUN Rscript -e "renv::restore()"

COPY plumber.R plumber.R
COPY auth.R auth.R
COPY db_connect.R db_connect.R
COPY config.yml config.yml

# Expose the port that your API will run on
EXPOSE 7860
#EXPOSE 8000

# Define the command to run your API
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host = '0.0.0.0', port = 7860)"]
#ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host = '0.0.0.0', port = 8000)"]
