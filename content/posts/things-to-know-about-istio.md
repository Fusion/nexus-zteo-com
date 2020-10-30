+++
date = "2020-10-06T10:54:24-08:00"
draft = false
title = "Things to know about Istio"
slug = "things-to-know-about-istio"
tags = ["kubernetes","service mesh"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = ""
featured = false
description = ""
+++

**This post has spent so much time in my draft folder that I am finally pulling the trigger even though I would styll very much find the time to tell you about these additional points:**

- major bug: 443
- there are simpler alternatives: linkerd
- should u use in production?
- yes it is a steep learning curve
- breaking changes
not negative: like changes are good -- also very flexible
complexity debugging routes for instance01~


So, without further ado:
# Some major bugs are lurking

For instance, here is one I wasted quite a lof of time figuring out: all outgoing HTTPS connections were failing with protocol error messages. As I will discuss in another post, this was making it difficult to convince Argocd to communicate with Github. But why?

Eventually, I found this discussion about port 443 ingress conflicts as well as how the gateway is not supposed to support TLS in istio: 
{{<linkpreview
type="horizontal"
href="https://github.com/istio/istio/issues/16458"
title="Github&nbsp;Issue"
description="Any HTTP service will block all HTTPS/TCP traffic on the same port"
>}}

This bug report, as well as [https://github.com/istio/istio/issues/14264](https://github.com/istio/istio/issues/14264) point out that it is not possible to call external services if any internal service is listening on port 443!

There is hope it will be fixed in the 1.6 branch.

Careful, though! While some bugs disappear with a new release, new ones may take their place. According to Reddit, quality varies greatly. According to the world, 503 errors are likely bugs.

In order to get a better grasp of what is an aberrant behavior vs something simply surprising, I strongly recommend familiarizing yourself with the concepts of Envoy. Bonus: you can also use Envoy without Istio, so that knowledge is not wasted. For instance, when using ingress gateways sitting directly on top of Kubernetes, I tend to favor Contour, which is one of the many packages that rely on Envoy.

{{<linkpreview
src="/images/envoy-proxy-logo.png"
href="https://www.envoyproxy.io/"
title="Envoy"
description="A self contained, high performance server with a small memory footprint.">}}
{{<linkpreview
src="/images/contour-logo.png"
href="https://projectcontour.io/"
title="Contour"
description="An open source Kubernetes ingress controller providing the control plane for the Envoy edge and service proxy.">}}

# Production or Development?

Nick Joyce made a good introductory post about cautiously introducing a production cluster to Istio: 
{{<linkpreview
type="horizontal"
href="https://blog.realkinetic.com/introducing-istio-to-a-production-cluster-ef5820148fe4"
title="Blog&nbsp;Post"
description="Introducing Istio to a production cluster"
>}}

# Simpler Alternatives

# Steep Learning Curve

And you will keep on learning, mostly through failure. Sometimes, limitations that are built in Kubernetes itself will bite you. For instance, the fact that side cars are started in a non deterministic order, meaning that if Istio's sidecar doesn't start first, your app may not be able to exit the mesh. Of course, your design is robust enough to survive that, right? It is pretty easy to find entertaining youtube videos where the presenter explains the various ways they imagined to manager their sidecars run order, as well as how these failed.

At least, starting with Kubernetes 1.18, sidecard containers can at least be prioritized to run first. Read more about this [here](https://banzaicloud.com/blog/k8s-sidecars/).

# Breaking Changes

not negative: like changes are good -- also very flexible
complexity debugging routes for instance
