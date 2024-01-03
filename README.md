[under revision]

# Node.JS + MySQL Web App.<br><br>Setting up service mesh with Istio.<br><br>Observability with Kiali, Jaeger, Prometheus, Grafana.

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
   - EKS cluster
   - A service mesh based on Istio with integrated Kiali, Jaeger, Prometheus and Grafana.
     
2. We will use V1 and V2 versions of the app which were previously uploaded into this demo [DockerHub repository](https://hub.docker.com/repository/docker/montcarotte/fullstack_nodejs_mysql_demo/general)
   - V1 deployment which will host the version 1 of the app.
   - V2 deployment which will host the version 2 of the app.

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
