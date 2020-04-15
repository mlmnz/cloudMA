# cloudMA

My cloud deployment.

The main objective of this project was how I learned Terraform. Before, I only used Docker with the run command, but to learn how to automate everything, I first learned to write a docker-compose, and in order to create resources in GCP from Terraform I had to stop using the UI and switch to using the API.

I use GCP because the free tier allows me to use various resources like instances, IoT, some storages and NoSQL DB. That allows me to learn without having to spend a fortune.

In summary, in order to automate my cloud testing lab, I had to learn:

- Explore more docker
- Scripting
- Some Google Cloud APIs
- Terraform

To final put my PiHole server in Google Cloud.

## Docker part

Here I used two files, the docker-compose.yml and .env

- In docker-compose I put two services: my ad blocking [PiHole](https://pi-hole.net/) and [DuckDNS](https://www.duckdns.org/) free dynamic DNS without having to confirm every 30 days no like NoIP.

- Volumes for persistent data and when updating container images, don't lose data.

- The environment variables are in the .env file as follows:

        PIHOLE_PASS=mypass
        DUCKDNS_TOKEN=123abc-345def-768hij
        DUCKDNS_SUB=mysubdomain
    This file you can name as .env and put together docker-compose file. You can get more information [here](https://docs.docker.com/compose/environment-variables/#the-env-file).
