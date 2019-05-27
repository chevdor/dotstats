FROM node:alpine
MAINTAINER "chevdor@gmail.com"

WORKDIR /app

RUN apk update && apk add python g++ make openssh
COPY . .
RUN export PYTHONPATH=${PYTHONPATH}:/usr/lib/python2.7 && \
    yarn 

EXPOSE 8080 3000 1024

# Frontend is exposing 3000
# Backend is exposing 8080
# No need for expose, if using docker-compose & docker run -p 3000:3000

CMD ["echo", "Start with either: \n - yarn start:frontend\n - yarn start:backend"]
