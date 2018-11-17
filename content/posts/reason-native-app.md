---
title: "Creating a ReasonML Native App: What We Are Building"
date: 2018-09-08T13:33:01-01:00
tags: ["reason", "functional"]
series: ["Reason Native App"]
draft: true
---

I believe this is, as of now (2018), one of few articles you will find about creating a native application using [ReasonML](https://reasonml.github.io/). While Facebook came up with this interesting language/syntax that compiles to OCaml, it seems that they have focused their energy on transpiling it to JavaScript using [BuckleScript](https://github.com/BuckleScript/bucklescript)

<!--more-->

This means that if you wish to create a "native" application, it seems that you are expected to rely on ~~Node and Electron~~. And that's a shame, because OCaml itself provides a very competent native compiler and we are going to use it. I hope I can remember all the hoops I had to jump through so that you don't have to.

# My goal

Creating an application that provides an easy way to check that a web site — especially a single page application ('SPA') — reliably sends the same replies to the same queries, thus avoiding regressions due to new features being added or old issues being addressed.

This application needs to be fast and multi platforms.

## How?

You favorite web browser likely provides a way to generate a HAR file, and we are going to leverage this file. A [.har file](https://en.wikipedia.org/wiki/.har)  contains, in json format, a list of all HTTP queries and the website's responses.

For instance, in Chrome:

- Open a tab to the page you are planning on automating
- Open the developer console (on MacOS: {{< keypress "⌘" >}}{{< keypress "Opt" >}}{{< keypress "i" >}}) and click {{< simpleitem 1 >}}[ ] Preserve log{{< /simpleitem >}}
- Navigate to the {{< simpletab 1>}}Network{{< /simpletab >}} tab
- Perform all desired interactions with the web page/application
- When done, right-click anywhere in the now sizable list of network events
- Select {{< simpleitem 1 >}}Save as HAR with content{{< /simpleitem >}} and save with a memorable name.

This was step #1. Step #2 consists of running our application ("reasonable fidelity") and make sure that it is happy.

# So, what will we learn?

- Installing Reason and OCaml
- Configuring our favorite editor as an IDE
- Configuring a native application
- Building and running a native application
- Handling command line arguments
- Reading configuration files
- Creating an interactive terminal interface using NCurses
- Wiring in Python plugins
- Native File I/Os
- Native Promises
- Web Requests, posting, cookies and tokens
- Invoking the Shell
- Exporting to CSV[?]
- Parsing/Generating JSON Natively (no JavaScript library)
- Memoizing DNS queries


## TLDR

Yes, there's a -- very -- short version:

* Forget about all the JavaScript interop literature you will find online
* OCaml -- and its vast library -- is your secret weapon: after all, Reason lives on top of OCaml!

Don't panic! If you are not all that familiar with OCaml's syntax, Reason comes with an excellent tool called `refmt` which allows you to translate OCaml code to Reason.

Keep in mind that, target-wise, native compiling and using BuckleScript **do not** intersect:
{{<mermaid>}}
graph TB;
    sc["Reason Code"] --> |compile| oc["Ocaml Code"]
    oc --- |link| ol["OCaml Libraries"]
    subgraph _
        ol --> |native compile| nb["Native Binary"]
    end
    oc --- |link| bl["BuckleScript Libraries"]
    subgraph __
        bl --> |BuckleScript compile| JavaScript
    end
{{< /mermaid >}}

