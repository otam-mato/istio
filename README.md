[under revision]

# Node.JS + MySQL Web App.<br><br>Setting up a service mesh with Istio.<br><br>Observability with Kiali, Jaeger, Prometheus, Grafana.

<p align="center">
  <a href="https://skillicons.dev">
    <img height="50" width="50" src="https://cdn.simpleicons.org/Istio/#4863A0" /><img height="50" width="50" src="https://cdn.simpleicons.org/helm/blue" /><img src="https://skillicons.dev/icons?i=kubernetes,aws,docker,nodejs,mysql,prometheus,grafana"/><img height="50" width="40" src="https://github.com/otam-mato/istio/assets/113034133/1f62a830-6e8a-46bd-9e1b-ca60da77a662" /><img height="50" width="150" src="https://github.com/otam-mato/istio/assets/113034133/a1ebe489-2c75-41c2-9026-addaabc273d7" /><img height="50" width="50" src="https://cdn.simpleicons.org/terraform/blue" />
  </a>
</p>




<br>

> [!NOTE]
> This is a part of a series of demo projects in which I manipulate a Node.js application applying various technologies.<br>
>
> The app built using Node.js and Express and integrates with MySQL database, originally presented at this [GitHub Repository](https://github.com/otam-mato/nodejs_mysql_web_app_terraform.git). The previous [project](https://github.com/otam-mato/nodejs_mysql_web_app_kubernetes.git) involved deployment of the app on **Azure AKS**.
>
> Transition to microservices often brings complexities related to traffic management, security, and observability. This is where **Istio** steps in, offering a comprehensive service mesh solution that streamlines these challenges. Istio is an open source service mesh platform designed to enhance the management, security, policy enforcement, and observability of microservices-based applications.
> 
> In the current installment, we're setting up the service mesh with **Istio** and demonstrate observability features with **Kiali**, **Jaeger**, **Prometheus** and **Grafana**.
<br>

## Deployment Strategy

1. We will use these official [Terraform-based EKS Blueprints]() for Istio to deploy:
   - An EKS cluster
   - A service mesh based on Istio with integrated Kiali, Jaeger, Prometheus and Grafana.
     
2. We will use V1 and V2 versions of the app which were previously uploaded into this demo [DockerHub repository](https://hub.docker.com/repository/docker/montcarotte/fullstack_nodejs_mysql_demo/general)
   - V1 deployment which will host the version 1 of the app.
   - V2 deployment which will host the version 2 of the app.
  
3. We will deploy both app versions simultaneously using **HELM**

<br>

## Technologies used
- **Istio**
- **Amazon Web Services**
- **AWS EKS**
- **Kiali**
- **Jaeger**
- **Prometheus**
- **Grafana**
- **Node.JS**
- **Express**
- **JavaScript**
- **MySQL**
- **Docker**
- **Kubernetes**
- **HELM**
<br>

## Functionality

This web application interfaces with a MySQL database, facilitating CRUD (Create, Read, Update, Delete) operations on the database records.

**<details markdown=1><summary markdown="span">Detailed app description</summary>**

## Summary

The app sets up a web server for a supplier management system. It allows viewing, adding, updating, and deleting suppliers. 

#### **Dependencies and Modules**:
   - **express**: The framework that allows us to set up and run a web server.
   - **body-parser**: A tool that lets the server read and understand data sent in requests.
   - **cors**: Ensures the server can communicate with different web addresses or domains.
   - **mustache-express**: A template engine, letting the server display dynamic web pages using the Mustache format.
   - **serve-favicon**: Provides the small icon seen on browser tabs for the website.
   - **Custom Modules**: 
     - `supplier.controller`: Handles the logic for managing suppliers like fetching, adding, or updating their details.
     - `config.js`: Keeps the server's settings for connectind to the MySQL database.

#### **Configuration**:
   - The server starts on a port taken from a setting (like an environment variable) or uses `3000` as a default.

#### **Middleware**:
   - It's equipped to understand data in JSON format or when it's URL-encoded.
   - It can chat with web pages hosted elsewhere, thanks to CORS.
   - Mustache is the chosen format for web pages, with templates stored in a folder named `views`.
   - There's a public storage (`public`) for things like images or stylesheets, accessible by anyone visiting the site.
   - The site's tiny browser tab icon is fetched using `serve-favicon`.

#### **Routes (Webpage Endpoints)**:
   - **Home**: `GET /`: Serves the home page.
   - **Supplier Operations**: 
     - `GET /suppliers/`: Fetches and displays all suppliers.
     - `GET /supplier-add`: Serves a page to add a new supplier.
     - `POST /supplier-add`: Receives data to add a new supplier.
     - `GET /supplier-update/:id`: Serves a page to update details of a supplier using its ID.
     - `POST /supplier-update`: Receives updated data of a supplier.
     - `POST /supplier-remove/:id`: Removes a supplier using its ID.

#### **Starting Up**:
   - The server comes to life, starts listening for visits, and announces its awakening with a log message.

</details>

<br>


## Prerequisites

- A work station or an **EC2**.
- I will be using AWS EKS, and this official blueprint to deploy AWS resources, EKS cluster and Istio: <br>
https://istio.io/latest/docs/setup/platform-setup/amazon-eks/
https://aws-ia.github.io/terraform-aws-eks-blueprints/patterns/istio/
