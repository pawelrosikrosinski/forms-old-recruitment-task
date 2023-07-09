FROM nimmis/alpine-apache
WORKDIR /app
COPY ./angular/ /app
RUN apk add npm
RUN npm install -g @angular/cli
WORKDIR /app/forms-frontend
RUN npm install
RUN ng build
RUN cp -r dist/forms-frontend /web/html
