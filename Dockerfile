MAINTAINER Nshah14

RUN apt-get update \
 && apt-get -y install nodejs npm git \
 && apt-get clean

RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# Add group
ENV EXAMPLE_GROUP example
RUN groupadd -r $EXAMPLE_GROUP

# Add user
ENV EXAMPLE_USER example
ENV EXAMPLE_UID 3000
RUN useradd -r -u $EXAMPLE_UID -g $EXAMPLE_GROUP $EXAMPLE_USER

# Build application
RUN mkdir /opt/example
WORKDIR /opt
RUN git clone -b 0.1.0 https://github.com/nshah14/sample-web-app.git
WORKDIR /opt/example
RUN npm install

EXPOSE 5000
USER $EXAMPLE_USER

ENV PORT=5000
CMD [ "npm", "start"]
