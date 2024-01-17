[under revision]

# Node.JS + MySQL Web App.<br><br>Setting up a service mesh with Istio. Traffic management.<br><br>Observability with Kiali, Jaeger, Prometheus, Grafana.

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

<p align="center">
  <img width="300" alt="Screenshot 2024-01-16 at 20 44 03" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/a7802bc5-60f0-4cbe-8400-57fdb6ce6b0a">
  <img width="300" alt="Screenshot 2024-01-16 at 20 44 26" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/4f932371-c0e6-4a4e-b881-08647f209767">
</p>

<br>

## Deployment Strategy

1. We will be using these official [Terraform-based EKS Blueprints]() for Istio to deploy:
   - An **EKS cluster** and other relevant resources.
   - A service mesh based on **Istio**.
     
2. We will use V1 and V2 versions of the app which were previously uploaded into this demo [DockerHub repository](https://hub.docker.com/repository/docker/montcarotte/fullstack_nodejs_mysql_demo/general)
   - V1 deployment which will host the version 1 of the app.
   - V2 deployment which will host the version 2 of the app.
  
3. We will deploy both app versions simultaneously using **HELM**
   
5. We will deploy Istio services using **HELM** as well:
   - Gateway
   - A virtual service
  
5. We switch traffic from V1 to V2 which will represent a **"Blue-Green"** deployment strategy

6. Then we will re-arrange the Istio Virtual Service to redistribute the traffic to V1 and V2 in 80%/20% ratio which will represent a **"Canary"** deployment strategy

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

This two-tier web application interfaces with a MySQL database, facilitating CRUD (Create, Read, Update, Delete) operations on the database records.

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

## Architecture

<br>

<img width="1400" alt="Screenshot 2024-01-17 at 00 21 51" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/8b83455f-c0b6-406c-a78b-8a9c27b27e8a">

<br>

<br>

## Prerequisites

- A work station or an **EC2 instance**.
- I will be using **AWS EKS**, and this official **Terraform** blueprint to deploy AWS resources, EKS cluster and Istio: <br>
  https://istio.io/latest/docs/setup/platform-setup/amazon-eks/ <br>
  https://aws-ia.github.io/terraform-aws-eks-blueprints/patterns/istio/

  so:
  ```
  terraform init
  terraform apply --auto-approve
  ```
  
- **HELM** [installed](https://helm.sh/docs/intro/install/)
- **ISTIO** [installed](https://istio.io/latest/docs/setup/getting-started/)
- **Kubectl** [installed](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
- **AWS CLI** [installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
- **AWS configured** with a command `aws configure`
- **Kubernetes cluster configured (update kubeconfig)**

  ```
  aws eks --region us-west-2 update-kubeconfig --name istio-on-eks
  ```
  
  <img width="800" alt="Screenshot 2024-01-14 at 21 09 50" src="https://github.com/otam-mato/istio/assets/113034133/b79cb294-f06e-40db-b517-ef66a106d43e">


<br>

## Steps

### Setting up Istio and deploying observability tools

1. Enable Istio in the working namespace. Mine is default.

   ```bash
   kubectl label namespace default istio-injection=enabled
   ```
   <img width="800" alt="Screenshot 2024-01-15 at 21 28 18" src="https://github.com/otam-mato/istio/assets/113034133/df2bc9a6-d317-4c75-a77f-2fc6c2413d6f">

2. Use the following code snippet to add the Istio Observability Add-ons on the EKS cluster with deployed Istio.

   ```
   for ADDON in kiali jaeger prometheus grafana
   do
       ADDON_URL="https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/$ADDON.yaml"
       kubectl apply -f $ADDON_URL
   done
   ```
   <img width="800" alt="Screenshot 2024-01-15 at 21 40 31" src="https://github.com/otam-mato/istio/assets/113034133/ea46157e-0859-4d1f-8c56-e933fd8e7916">

3. Validate the setup of the observability add-ons by running the following commands and accessing each of the service endpoints using this URL of the form http://localhost:<port> where <port> is one of the port number for the corresponding service.

   ```bash
   # Visualize Istio Mesh console using Kiali
   kubectl port-forward svc/kiali 20001:20001 -n istio-system
    
   # Get to the Prometheus UI
   kubectl port-forward svc/prometheus 9090:9090 -n istio-system
    
   # Visualize metrics in using Grafana
   kubectl port-forward svc/grafana 3000:3000 -n istio-system
    
   # Visualize application traces via Jaeger
   kubectl port-forward svc/jaeger 16686:16686 -n istio-system
   ```

### Deploying the app V1 with HELM

1. Deploying the app
   ```
   git clone https://github.com/otam-mato/istio_nodejsapp_demo.git
   ```
   ```
   cd istio_nodejsapp_demo/helm_charts_app/v1_app_deployment_chart
   ```
   ```
   helm lint .
   ```
   ```
   helm template v1app .
   ```
   ```
   helm install v1app .
   ```

3. Deploying the istio components (Gateway and a VirtualService)
   ```
   cd ../../../helm_istio_services_charts
   ```
   ```
   helm lint .
   ```
   ```
   helm template istiocomponents .
   ```
   ```
   helm install istiocomponents .
   ```

   <img width="800" alt="Screenshot 2024-01-16 at 20 44 03" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/a7802bc5-60f0-4cbe-8400-57fdb6ce6b0a">
   
5. Monitoring with **KIALI**

   Now the V1 of the app is available and the traffic distribution looks like this:
   
   <img width="800" alt="Screenshot 2024-01-15 at 16 57 52" src="https://github.com/otam-mato/istio/assets/113034133/29fd9c65-d181-4da9-8406-ecf5416df0af">

### Deploying the app V2 with HELM and switching 100% of traffic to V2

1. Deploying the app
   ```
   cd istio_nodejsapp_demo/helm_charts_app/v2_app_deployment_chart
   ```
   ```
   helm lint .
   ```
   ```
   helm template v2app .
   ```
   ```
   helm install v2app .
   ```

2. Re-deploying the istio components (Gateway and a VirtualService)
   ```
   helm delete istiocomponents
   ```
   change the values of for istio Virtual Service to V2
   ```
   cat istio_nodejsapp_demo/helm_istio_services_charts/values.yaml

   # values.yaml
   nodeApp:
     releaseName: v2app
   ```
   ```
   helm lint
   ```
   ```
   helm template istiocomponents .
   ```
   ```
   helm install istiocomponents .
   ```
   <img width="800" alt="Screenshot 2024-01-16 at 20 44 26" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/4f932371-c0e6-4a4e-b881-08647f209767">
   
3. Monitoring with **KIALI**

   Now both versions of app V1 and V2 deployed but the traffic is switched 100% to V2 and looks like this:
   
   <img width="800" alt="Screenshot 2024-01-16 at 21 04 58" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/7882e48e-6862-4ece-a3e7-60f73f12ad2a">


### Demo of the observability tools

1. Demo of Prometheus
   
   <img width="800" alt="Screenshot 2024-01-15 at 22 35 39" src="https://github.com/otam-mato/istio/assets/113034133/6507b117-a5de-43ca-aca0-9d4332e3412a">
   <img width="800" alt="Screenshot 2024-01-15 at 22 36 52" src="https://github.com/otam-mato/istio/assets/113034133/1b92b73f-9427-4d09-990e-0e7ed403e0a2">
   <img width="800" alt="Screenshot 2024-01-15 at 22 37 34" src="https://github.com/otam-mato/istio/assets/113034133/ced9c917-851d-4fcf-bda2-d4c4641fbe65">

3. Demo of Grafana
   
   <img width="800" alt="Screenshot 2024-01-15 at 22 40 47" src="https://github.com/otam-mato/istio/assets/113034133/e90e5446-c9dc-40bc-8d9e-8f34c29013a9">
   <img width="800" alt="Screenshot 2024-01-15 at 22 42 12" src="https://github.com/otam-mato/istio/assets/113034133/c66a8655-576d-4b74-9cf6-58bb20a49fd2">
   <img width="800" alt="Screenshot 2024-01-15 at 22 43 39" src="https://github.com/otam-mato/istio/assets/113034133/f920c10c-57ee-42a4-94f2-aa228a014c82">
   <img width="800" alt="Screenshot 2024-01-15 at 22 46 16" src="https://github.com/otam-mato/istio/assets/113034133/e7124474-28a1-4181-bada-756651ddba69">

5. Demo of Jaeger
   
   <img width="800" alt="Screenshot 2024-01-15 at 22 27 24" src="https://github.com/otam-mato/istio/assets/113034133/2540476a-45fb-44f8-a1a7-3e08260cb52a">
   <img width="800" alt="Screenshot 2024-01-15 at 22 28 53" src="https://github.com/otam-mato/istio/assets/113034133/45c1a84d-cfaf-4ca5-a7e9-8bca74cb99a0">
   <img width="800" alt="Screenshot 2024-01-15 at 22 29 46" src="https://github.com/otam-mato/istio/assets/113034133/981549be-43d3-479b-a63f-069c2bbc069e">

<br>

### Traffic management

Implementing **"Canary"** deployment with traffic distribution:
  - 80% to V1 of the app
  - 20% to V2 of the app


We need to re-deploy the istio components (Gateway and a VirtualService) from the [helm_istio_services_charts_canary]() folder


This is modified VirtualService for the reference (it is available in helm_istio_services_charts_canary directory)
   ```yml
   # Istio VirtualService Canary
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: node-app-canary
  spec:
    hosts:
    - "*"
    gateways:
    - node-app-gateway
    http:
    - route:
      - destination:
          host: {{ .Values.nodeApp.releaseOneName }}
          port:
            number: 80
        weight: 80
      - destination:
          host: {{ .Values.nodeApp.releaseTwoName }}
          port:
            number: 80
        weight: 20
   ```

   ```
   helm delete istiocomponents
   ```
   change the folder where the modified Istio components are available (a Gateway and a VirtualService)
   ```
   cd istio_nodejsapp_demo/helm_istio_services_charts_canary
   ```
   ```
   helm lint
   ```
   ```
   helm template istiocomponents .
   ```
   ```
   helm install istiocomponents .
   ```

Now both app versions available at the Istio VirtualService loadbalancer's dns name. When you update the page a few times you will see the V1 and V2 and the traffic distribution like this:

   <img width="800" alt="Screenshot 2024-01-16 at 20 44 03" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/a7802bc5-60f0-4cbe-8400-57fdb6ce6b0a">
   <img width="800" alt="Screenshot 2024-01-16 at 20 44 26" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/4f932371-c0e6-4a4e-b881-08647f209767">

   <img width="800" alt="Screenshot 2024-01-16 at 20 43 21" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/4724436e-3f3f-494b-a50d-a33f65b2be45">
   <img width="800" alt="Screenshot 2024-01-16 at 20 43 12" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/0ffc0a4e-0124-4448-bbe2-ad24e878c2e7">

   <img width="800" alt="Screenshot 2024-01-16 at 20 27 28" src="https://github.com/otam-mato/istio_nodejsapp_demo/assets/113034133/1a1b2ae4-ec4b-4829-b0c7-b829290f4fbc">

<br>


Thanks for reading up to this point! :)
