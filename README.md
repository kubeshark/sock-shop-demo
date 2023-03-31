> **Note:** The source code of the images related to the additions for gRPC, AMQP, Kafka and Redis protocols can be found in the `additions` folder.

# Sock Shop : A Microservice Demo Application

The application is the user-facing part of an online shop that sells socks. It is intended to aid the demonstration and testing of microservice and cloud native technologies.

It is built using [Spring Boot](http://projects.spring.io/spring-boot/), [Go kit](http://gokit.io) and [Node.js](https://nodejs.org/) and is packaged in Docker containers.

You can read more about the [application design](./internal-docs/design.md).

## Deployment Platforms

The [deploy folder](./deploy/) contains scripts and instructions to provision the application onto your favourite platform. 

Please let us know if there is a platform that you would like to see supported.

## TLS/eBPF Capture Test

Start with a clean cluster using `minikube` and deploy the bare minimums:

```shell
minikube start --driver=virtualbox --cpus 4 --memory 8192
kubectl apply -f deploy/kubernetes/manifests
ls deploy/kubernetes/manifests/extras/*outbound-tls*  | xargs -Ifile kubectl apply -f file
```

Then run Kubeshark:

```shell
kubeshark tap -n sock-shop && kubeshark clean
```

After approximately 1-2 minutes delay, you should start to see the encrypted traffic capture:

![TLS/eBPF Capture](/assets/tls_capture.png)
