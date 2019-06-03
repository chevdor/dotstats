FROM phusion/baseimage
MAINTAINER "chevdor@gmail.com"

WORKDIR /app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get -y install python g++ make openssl git pdftk nodejs yarn wget && \
    apt-get clean && apt-get autoremove --purge && \
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    chmod u+x "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install `cat .nvmrc`

COPY . .
RUN yarn && \
    yarn build:common && \
    yarn build:backend && \
    yarn build:frontend

EXPOSE 8080 3000 1024

# Frontend is exposing 3000
# Backend is exposing 8080

CMD ["echo", "Start with either: \n - docker run -p 3000:3000 yarn start:frontend\n - docker run -p 8080:8080 -p 1024:1024 yarn start:backend"]
