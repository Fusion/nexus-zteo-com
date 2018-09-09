---
title: "Creating a ReasonML Native App -- Part 1"
date: 2018-09-08T13:33:07-07:00
tags: ["reason", "functional"]
series: ["Reason Native App"]
draft: true
---

I believe this is, as of now (2018), one of few articles you will find about creating a native application using [ReasonML](https://reasonml.github.io/). While Facebook came up with this interesting language/syntax that compiles to OCaml, it seems that they have focused their energy on transpiling it to JavaScript using [BuckleScript](https://github.com/BuckleScript/bucklescript)

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

A very helpful note on that secret weapon: if you are not all that familiar with OCaml's syntax, Reason comes with an excellent tool called `refmt` which allows you to translate OCaml code to Reason.

# Installing Reason

First, we will need OCaml. This is because our Reason code will be compiled to OCaml, then, using the OCaml compiler, to native code.

I would strongly recommend installing opam, rather than directly installing any distribution-native flavor of OCaml. The simplest way is using this bootstrap script:
```bash
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
```
You can now simply update and install the desired version of OCaml. Right now, Reason works best with versions ~ 4.05:
```bash
opam update && opam switch 4.05.0
```
And finally reason and merlin, its completion tool:
```bash
opam install reason merlin
```

# Configuring our favorite editor

If you happen to be in love with [VSCode](https://marketplace.visualstudio.com/items?itemName=jaredly.reason-vscode), you'are almost there. It's definitely the editor that Reason's authors seem to favor.

If you are more interested in the nitty gritty of a proper, clean install for native code, let's have a look at my `vim` setup...

## Our favorite editor is vim (today, anyway)

{{% notice %}}Note: recently, support for Reason was baked into OniVim. This makes it a very easy starting point! [Check it out](https://github.com/jaredly/reason-language-server#onivim){{% /notice %}}

First, you need to install the [OCaml language server](https://github.com/freebroccolo/ocaml-language-server). I know a language server specific to Reason also exists, but again, that plugin may not perform as well w/r/t native OCaml integrations.
```bash
npm install -g ocaml-language-server
```
Yes,I know: Node, again, totally inescapable!

Now, let's install our vim plugins: [Language Support Client](https://github.com/autozimu/LanguageClient-neovim) and [vim-reason-plus](https://github.com/reasonml-editor/vim-reason-plus) -- if you are using Vim-Plug (my favorite plugin manager) simply add these lines to your `~/.vimrc`
```vim
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
...
autocmd BufReadPost *.re setlocal filetype=reason
...
let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }
let g:LanguageClient_autoStart = 1

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>
```

After opening a Reason project directory (dumb way: `vim src/*.re`) you may find that the first file is not properly highlighted: you may need to issue a `:e` command. Worse: if you open all the files together (`vim -p src/*.re`) you will have to repeat this for every buffer. Hit me up if you figure out what I've done wrong!

At this point, I recommend that you clone 'reasonable fidelity' so that you can follow along:
```bash
git clone git@github.com:Fusion/reasonable-fidelity.git
```
Of particular interest: `src/jbuild` -- we are going to list all our libraries in this file to provide some helpful hints to editors and builder:
```lisp
(jbuild_version 1)

(executable
 ((name main)
  (public_name reasonable-fidelity)
  (libraries (lwt cohttp cohttp-lwt-unix yojson str config-file extlib lymp diff curses))))
```
You can use the same list, almost verbatim, to manually install the required libraries:
```bash
opam install lwt cohttp cohttp-lwt-unix yojson str config-file extlib lymp diff curses
```

We are now ready to get to work...
