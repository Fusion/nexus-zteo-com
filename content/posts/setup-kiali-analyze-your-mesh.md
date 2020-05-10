+++
date = "2020-05-06T10:54:24+02:00"
draft = false
title = "Setup Kiali, Analyse Your Mesh"
slug = "kiali-and-your-mesh"
tags = ["kubernetes","service mesh"]
image = "kiali2.png"
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = ""
featured = false
description = ""
+++

# Why would I want Kiali?

If you have been playing/using a service mesh for any length of time, you may have noticed that there is a certain cognitive overhead in trying to figure out traffic flows. Even using the CLI to understand injected routes can require spending a good long time in the "zone."

<!--more-->

{{< img-process ProgrammerInterrupted.png Resize "60x" prgint >}}
{{< lightbox id="prgint" type=scrollable >}}<img src="/images/ProgrammerInterrupted.png">{{< /lightbox >}}

# Installing

We can install Kiali, either from Istio or using its operator. It will then end up either in the `istio-system` namespace, or in both this namespace and in `kiali-operator`.

## Installing from Istio

Prepare a nice secret:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
type: Opaque
data:
  username: $KIALI_USERNAME
  passphrase: $KIALI_PASSPHRASE
EOF

```

Install:

```bash
istioctl manifest apply --set values.kiali.enabled=true
```

Note: after applying our manifest again, our ingress ports will have changed so just keep this in mind.

Then run the dashboard proxy — or not. See below.

```bash
istioctl dashboard kiali
```

### Uninstalling kiali

Convenient if you went down this path and found out you cannot use it properly.

```bash
kubectl delete all,secrets,sa,templates,configmaps,deployments,clusterroles,clusterrolebindings,virtualservices,destinationrules --selector=app=kiali -n istio-system
istioctl manifest apply --set values.kiali.enabled=false
```

## Installing latest release, using Operator

Here is a good motivation to go through the operator install: when installing directly from Istio, I was not able to log in as the login page itself was throwing Javascript errors. So, here goes:

```bash
bash <(curl -L https://kiali.io/getLatestKialiOperator) --accessible-namespaces '**'
```

# Using

This is the easiest part. While tutorials tell you about running `isctioctl dashboard kiali` why not instead setup a nice ingress route so that you can access it like any other first-class service?

```bash
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: acme-kiali-yourhost-com-certs
  namespace: istio-system
spec:
  dnsNames:
    - kiali.yourhost.com
  secretName: acme-kiali-yourhost-com-secret
  issuerRef:
    name: cloudflare-letsencrypt-prod
    kind: ClusterIssuer
---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: default
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 443
      name: https-kiali
      protocol: HTTPS
    hosts:
    - kiali.yourhost.com
    tls:
      credentialName: acme-kiali-yourhost-com-secret
      mode: SIMPLE
      privateKey: sds
      serverCertificate: sds
  - port:
      number: 80
      name: http-kiali
      protocol: HTTP
    tls:
      httpsRedirect: true
    hosts:
    - kiali.yourhost.com
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali
spec:
  hosts:
  - kiali.yourhost.com
  gateways:
  - kiali-gateway
  http:
  - name: http
    route:
    - destination:
        host: kiali.istio-system.svc.cluster.local
        port:
          number: 20001
```

And here we are, looking into Argocd's flows:
![Kiali](/images/kiali1.png)

And focusing on Redis' traffic:
![Kiali](/images/kiali2.png)

{{% notice info %}}
At this time, when exploring a service, you may see some red warnings. Yet, you are not able to dig in any further because we have not installed Jaeger. What a fun jigsaw!
{{% /notice %}}
