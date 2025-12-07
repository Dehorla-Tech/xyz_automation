||| XYZ Cloud Automation Demo

A fully automated cloud-native setup showing how XYZ can move from slow, inconsistent on-prem deployments to fast, reliable, automated cloud environments using:

Terraform · GitHub Actions · Docker · Kubernetes · AWS · Husky · Node.js


||| Overview

This project demonstrates a complete Infrastructure-as-Code workflow to deploy a Node.js application to AWS EKS using GitHub Actions, Terraform, Docker, and Kubernetes.

The app exposes a simple REST endpoint:

{
  "message": "Automate all the things!",
  "timestamp": 1529729125
}


Everything runs automatically through one GitHub Actions pipeline, triggered on every push.

||| How This Solves XYZ’s Problems

Below are the exact issues raised by XYZ—and how each technology solves them.

  || Kickstarting New Environments

Problem:
Developers struggle to set up new dev/test environments. Setup is manual, slow, and inconsistent.

Solution → Terraform
Terraform provisions AWS infrastructure (VPC, EKS cluster, networking) automatically and repeatedly using code.
This means:

New environments spin up with one command

No more manual AWS console clicking

Environments are identical every time

Infrastructure becomes traceable, version-controlled, reproducible

Terraform = fast, consistent environment creation.

   || Long Development Cycles

Problem:
Deployments take too long and require multiple manual steps.

Solution → GitHub Actions
GitHub Actions automates the entire CI/CD pipeline:

Builds & tests the Node.js app

Runs Husky checks before pushing

Builds Docker image

Pushes image to DockerHub

Runs Terraform to update AWS

Deploys app to Kubernetes

Every push = automatic deployment.

This eliminates manual deployment steps → shorter development cycles.

   || Lack of Consistency Between Environments

Problem:
Apps behave differently on developer machines, test servers, and production.

Solution → Docker
Docker ensures every developer, every server, every environment runs the app inside the exact same container.

Same OS

Same Node.js version

Same dependencies

Same behavior everywhere

Docker = environment consistency guaranteed.

  || Downtime During Deployments

Problem:
Production experiences outages whenever new code is deployed.

Solution → Kubernetes (K8s)
The app is deployed to an AWS EKS Kubernetes cluster, giving:

Rolling updates (no downtime)

Automatic restart of failed pods

Load balancing

Self-healing workloads

Kubernetes ensures deployments happen without taking the app offline.

 || Tech Stack Summary
Technology	Purpose
Node.js	Simple REST API application
Docker	Consistent runtime environment
DockerHub	Container registry
Terraform	Infrastructure provisioning (AWS + EKS)
AWS (EKS)	Managed Kubernetes cluster
Kubernetes	Zero-downtime deployments, scaling
GitHub Actions	CI/CD pipeline
Husky	Pre-push code quality checks
  || Deployment Flow (What Happens on Push)

You push your code

Husky runs tests/lint before allowing the push

GitHub Actions workflow starts

Docker builds & pushes the image to DockerHub

Terraform provisions or updates AWS resources

Kubernetes deploys the updated container

LoadBalancer exposes your app publicly

  || Endpoint

Once deployed, access the service:

GET http://<load-balancer-url>/


Returns:

{
  "message": "Automate all the things!",
  "timestamp": 1695000000
}

   || In Summary

This project shows XYZ exactly how to:

Automate environment creation → Terraform

Shorten developer cycles → GitHub Actions

Ensure consistent environments → Docker

Prevent deployment downtime → Kubernetes

All running on AWS with clean, modern DevOps practices.