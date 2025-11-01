#import "../../page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(
  title: title,
  desc: desc,
)

= What Are Kubernetes Addons

Kubernetes addons are a collection of utilities that make life easier for
cluster operators. They often include networking plugins (CNI), metrics servers,
and other tools to enhance cluster functionality. Most cloud providers ship
clusters with these essentials by default.

For example, EKS provide the followings:
- vpc-cni
- coredns
- metrics-server

= Addons in My Cluster

My EKS cluster is managed through a GitOps workflow powered by FluxCD. Each
addon is deployed as a `HelmRelease` object and organized by overlay layers
corresponding to their namespace or function group (e.g., `infra`, `mon`,
`pgsql`):

== Core Infrastructure

*Traefik* and *Traefik CRDs* serve as the main ingress controller in the
cluster. Instead of using traditional Ingress objects, I adopt the experimental
#link("https://gateway-api.sigs.k8s.io/")[Kubernetes Gateway API], which
provides a more expressive and extensible model for routing. This setup allows
both L7 HTTP traffic and raw TCP streams to be aggregated under the same
`LoadBalancer` service — a single entry point managed by #link(
  "https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html",
)[AWS Load Balancer Controller], which automatically provisions the
corresponding AWS NLB resources.

For observability, I use #link(
  "https://github.com/prometheus-community/helm-charts/charts/kube-prometheus-stack",
)[kube-prometheus-stack], a comprehensive monitoring suite combining Prometheus,
Alertmanager, and Grafana. It's a straightforward, production-ready solution for
cluster operations, offering metrics, alerting, and dashboards out of the box.

When bootstrapping a new cluster, my FluxCD reconciles prometheus first, before
any workload or operator depending on CRDs such as ServiceMonitor. This ensures
that custom monitoring resources are recognized and registered properly during
subsequent deployments.
