FROM rocker/r-base
MAINTAINER Jeff Allen <docker@trestletech.com>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  default-jdk

## RUN R -e 'install.packages(c("devtools"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN install2.r plumber
RUN install2.r h2o

ADD ./huismodel.h2o /huismodel.h2o
ADD plumber.R plumber.R
### H2o installeren en 
#### plumber file aanpassen voor h2o model serveren
### copieren van h2o model in docker

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/plumber.R"]