# Infraestructura resiliente: diseño colaborativo con Kubernetes y Docker

Proyecto académico para desplegar una API contenerizada con Docker, administrada con Kubernetes (Minikube) y automatizada con Terraform. La solución demuestra escalabilidad, resiliencia ante fallos y buenas prácticas DevOps.

## Objetivo

Implementar un servicio web escalable y resiliente que permita:

- Construir y publicar una imagen Docker.
- Desplegar la aplicación en Kubernetes.
- Configurar escalabilidad automática con HPA.
- Probar recuperación automática ante fallos.
- Automatizar la infraestructura con Terraform.

## Tecnologías utilizadas

- Node.js + Express
- Docker
- Kubernetes
- Minikube
- kubectl
- Terraform
- Git y GitHub

## Estructura del proyecto

```text
infraestructura-resiliente/
├── app/
│   ├── package.json
│   ├── server.js
│   └── Dockerfile
├── kubernetes/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── hpa.yaml
│   └── kustomization.yaml
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variable.tf
│   ├── outputs.tf
├── docs/
│   └── evidencias/
└── README.md
```

## Requisitos previos

Verifica que estas herramientas estén instaladas:

```bash
docker --version
kubectl version --client
minikube version
git --version
terraform version
```

## 1. Levantar Minikube

```bash
minikube start --driver=docker
kubectl config use-context minikube
kubectl get nodes
minikube addons enable metrics-server
```

## 2. Crear y probar la aplicación localmente

Dentro de `app/`:

```bash
npm install
node server.js
```

Prueba:

```bash
curl http://localhost:3000
curl http://localhost:3000/health
```

## 3. Construir la imagen Docker

Dentro de `app/`:

```bash
docker build -t mi-api:latest .
docker run -d -p 3000:3000 mi-api:latest
curl http://localhost:3000
```

## 4. Publicar imagen en Docker Hub

Reemplaza `TU_USUARIO_DOCKERHUB` por tu usuario real:

```bash
docker login
docker tag mi-api:latest TU_USUARIO_DOCKERHUB/mi-api:latest
docker push TU_USUARIO_DOCKERHUB/mi-api:latest
```

## 5. Desplegar en Kubernetes

Asegúrate de que en `deployment.yaml` la imagen apunte a tu repositorio real de Docker Hub.

```bash
kubectl apply -k kubernetes/
kubectl get all -n mi-api-ns
kubectl get hpa -n mi-api-ns
minikube service mi-api-service -n mi-api-ns --url
```

## 6. Probar escalabilidad automática

```bash
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh
```

Dentro del contenedor:

```sh
while true; do wget -q -O- http://mi-api-service.mi-api-ns.svc.cluster.local/cpu; done
```

En otra terminal:

```bash
kubectl get hpa -n mi-api-ns -w
kubectl get pods -n mi-api-ns -w
```

## 7. Probar resiliencia

```bash
kubectl get pods -n mi-api-ns
kubectl delete pod <NOMBRE_DEL_POD> -n mi-api-ns
kubectl get pods -n mi-api-ns -w
```

## 8. Aplicar infraestructura como código con Terraform

Dentro de `terraform/`:

```bash
terraform init
terraform apply
```

Importante: si el namespace ya existe porque fue creado antes con `kubectl`, bórralo o impórtalo antes de ejecutar Terraform.


## Conclusiones

Este proyecto permite demostrar el uso integrado de Docker, Kubernetes y Terraform para construir una solución portable, escalable y resiliente. También fortalece competencias en automatización, observabilidad básica y operación de infraestructura bajo enfoque DevOps.

