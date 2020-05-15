# cloudMA

My cloud deployment.

The main objective of this project was how I learned Terraform. Before, I only used Docker with the run command, but to learn how to automate everything, first I learned to write a docker-compose, and in order to create resources in GCP from Terraform I had to stop using the UI and switch to using the API.

Why do I use GPC instead of AWS? I started my tests with public clouds years ago and didn't take advantage of the potential to learn and use the test of both clouds (12 months of AWS is a great opportunity to learn, I used it twice).
I use GCP because the free tier after testing allows me to use various resources like instances, IoT, some storages, and NoSQL DB (AWS also has free resources but less). That allows me to learn without having to spend a fortune.

In summary, in order to automate my cloud testing lab, I had to learn:

- Explore more docker
- Scripting
- Some Google Cloud APIs
- Terraform

To final put my PiHole server in Google Cloud.

## General

I used several environment and normal variables to 'keep safe' sensitive data and can update/change names, services, etc easily.

### Requirements

- Account in Google Cloud
- [Terraform CLI](https://learn.hashicorp.com/terraform/getting-started/install)
- [Cloud SDK : Command-Line tool (gcloud)](https://cloud.google.com/sdk/docs)
- Docker (for testing)
- Your favorite editor

## Google Cloud part

## Docker part

I used docker-compose and .env file for environment variables

- In docker-compose I put several services: a reverse proxy with [Traefik](https://docs.traefik.io/), my ad blocking [PiHole](https://pi-hole.net/) service, [DuckDNS](https://www.duckdns.org/) free dynamic DNS without having to confirm every 30 days, not like NoIP and optional Portainer.

- Volumes for persistent data and when updating container images, don't lose data.

- The environment variables are in the .env file as follows:

        PIHOLE_PASS=mypass
        DUCKDNS_TOKEN=123abc-345def-768hij
        DUCKDNS_SUB=mysubdomain
        TRAEFIK_AUTH=admin:12dasd2134s

    This file you can name as .env and put together docker-compose file. You can get more information [here](https://docs.docker.com/compose/environment-variables/#the-env-file).

- Before apply docker-compose file, I created a 'proxy network' through which the traffic of the containers that we want in the proxy. On each services container must be set this network

        docker network create proxy_net

### Reverse proxy

With Traefik you can have a reverse proxy with easy SSL and DuckDNS subdomain, [this is good starting guide](https://docs.traefik.io/user-guides/docker-compose/acme-dns/). 

In proxy container, you need pass following commands in docker-compose file.

    command:

        - "--entrypoints.web.address=:80"
        - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
        - "--entrypoints.web.http.redirections.entryPoint.scheme=https"
        - "--entrypoints.websecure.address=:443"
        
        - "--certificatesresolvers.myresolver.acme.dnschallenge=true"
        - "--certificatesresolvers.myresolver.acme.dnschallenge.provider=duckdns"
        - "--certificatesresolvers.myresolver.acme.email=${EMAIL}"
        - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"

This http traffic to be redirected to https and sets the DuckDNS provider to 'DnsChallenge' to help us create a certificates for each web services container

On each services the ports and several labels must be set to include it in Traefik and it can certificates automatically with Let's Encrypt.

    expose:
        - "9000"

    labels: 
        - "traefik.http.routers.portainer.rule=Host(`portainer.${DUCKDNS_SUB}.duckdns.org`)"
        - "traefik.http.routers.portainer.tls.certresolver=myresolver"

This mean if you have a portainer service, you need EXPOSE the web port used by Portainer into proxy_network, Traekf will detect it automatically and route portainer.${DUCKDNS_SUB}.duckdns.org to Portainer service.

Maybe the container expose several ports, as PiHole, and Traefik detect port 53 as web server, so yo need specify the web port.

        expose: 
            - "80"    

        labels: 
            - "traefik.http.routers.pihole.rule=Host(`pihole.${DUCKDNS_SUB}.duckdns.org`)"
            - "traefik.http.routers.pihole.tls.certresolver=myresolver"
            - "traefik.http.services.pihole.loadbalancer.server.port=80"
