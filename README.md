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

- In docker-compose I put two services: my ad blocking [PiHole](https://pi-hole.net/) service and [DuckDNS](https://www.duckdns.org/) free dynamic DNS without having to confirm every 30 days, not like NoIP.

- Volumes for persistent data and when updating container images, don't lose data.

- The environment variables are in the .env file as follows:

        PIHOLE_PASS=mypass
        DUCKDNS_TOKEN=123abc-345def-768hij
        DUCKDNS_SUB=mysubdomain
    This file you can name as .env and put together docker-compose file. You can get more information [here](https://docs.docker.com/compose/environment-variables/#the-env-file).
