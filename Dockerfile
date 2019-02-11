FROM rocker/r-base
MAINTAINER Jeff Allen <docker@trestletech.com>

## dependencies that are needed, default-jdk for java for h2o
RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  default-jdk

## RUN R -e 'install.packages(c("devtools"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
# We need the plumber and h2o package
RUN install2.r plumber
RUN install2.r h2o

## copy the saved h2o model opbejct to the docker image
## copy the R plumber file that imolements the API 
ADD ./huismodel.h2o /huismodel.h2o
ADD plumber.R plumber.R

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/plumber.R"]