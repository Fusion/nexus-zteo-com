---
title: "Creating a ReasonML Native App: Installing, Editing, Configuring"
date: 2018-09-08T13:33:01-02:00
tags: ["reason", "functional"]
series: ["Reason Native App"]
draft: false
---

# Installing Reason

First, we will need OCaml. This is because our Reason code will be compiled to OCaml, then, using the OCaml compiler, to native code.

<!--more-->

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
