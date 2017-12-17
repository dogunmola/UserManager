#!/bin/bash

# Author: Damilare Ogunmola

# Simple script to create two containers - a web node and a db node

# Create a dockerfile for the app node

cat > Dockerfile-App << "APP"

FROM node:6

# Update
# RUN apk add --update nodejs

# Set /app as the working directory
WORKDIR /app

# Install app dependencies
COPY package.json /app/package.json
RUN npm install

# Bundle app source
COPY . /app

EXPOSE  3000
CMD ["npm", "start"]

APP

# Create a dockerfile for the db node

cat > Dockerfile-DB << "DB"

FROM mongo

EXPOSE 27017

DB

# create .env file with port and db url
cat > .env << "ENV"
PORT=3000
DB_URL='mongodb://mongodb/users'

ENV


# build the docker files

sudo docker build -f Dockerfile-App -t damiogunmola/node-container .
sudo docker build -f Dockerfile-DB -t damiogunmola/mongodb-container .

# run the containers

sudo docker run -d --name myMongoDB damiogunmola/mongodb-container
sudo docker run -p 3000:3000 --link=myMongoDB:mongodb -it --name myNode damiogunmola/node-container

# end
