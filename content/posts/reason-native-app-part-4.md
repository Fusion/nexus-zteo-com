---
title: "Creating a ReasonML Native App: Command Line Arguments"
date: 2018-09-08T13:33:01-04:00
tags: ["reason", "functional"]
series: ["Reason Native App"]
draft: true
---

Before going into how specific features were implemented with Reason and OCaml's help, let's have a quick look at our application's logic

<!--more-->

(Refresh if the diagram below doesn't display properly)

{{<mermaid>}}
graph TB;
    main --> |play scenario| run
    main --> |edit scenario| editor
    main --- |read/reset| Config
    editor --- |r/w content| Web
    run --> |delegate| Web
    run --- |interact with| Plugins
    run --- |compare| Entities
    Web -.- |r/w| cookies
    Web -.- |r/w| headers
    Web -.- |r/w| sessions
    Web -.- |r/w| content
    cookies -.- ws["web sites"]
    headers -.- ws["web sites"]
    sessions -.- ws["web sites"]
    content -.- ws["web sites"]
    Web --- |delegate| CfrIO
    Web --- |manipulate| WebContext
    CfrIO -.- |r/w json| js["file system"]
    CfrIO -.- |execute| cmds["local commands"]
{{< /mermaid >}}

You will immediately notice that:

- This is a CLI application, with some help from NCurses when editing a scenario file.
- We try to keep all local side effects isolated in their own class.
- Surely, most of this business must be asynchronous!

Since this is a CLI application, the first thing we are going to do is try to figure out what it is the user wants us to do. That is...

# Handling command line arguments

The beauty of having pattern matching available is that we can quickly write some arguments handling without requiring an additional library.

First, we are going to have a quick look at `Sys.argv` to determine what high level operation we are trying to perform. We may wish to run a scenario, edit its json file, display our program's help page, etc.

Keeping in mind that, as in any language, argv[0] represents our executable itself, here is some simple routing:

```ocaml
let () =
  switch (Sys.argv) {
  | [|_|] => display_help()
  | [|_, "test"|] => run_test()
  | [|_, "help"|] => display_help()
  | [|_, "sanity"|] => display_sanity()
  | [|_, "timestamp", ts, te|] => display_timestamp(ts, te)
  | [|_, "reset"|] => Config.write_default_config_file()
  | arguments when arguments[1] == "run" => 
  ...
  | [|_, "modified"|] => display_modifications()
  | [|_, "edit", fn|] => Editor.edit_source(fn)
  | _ => display_help()
  };
```

If the user, for instance, types `./reasonable-fidelity timestamp` and omits both timestamp parameters, we will default to displaying the help page.

{{% notice %}}In ReasonML, arrays are denoted by `[| |]` while lists use `[ ]`{{% /notice %}}

Our most interesting match is the `run` argument, which was purposefuly elided here. What our program does is check for pre-requisites, take the relevant remaining arguments and passes them to a function that will then match these arguments to build an array of valid requests:

```ocaml
let rec process_args = (args, ret) =>
  switch (args) {
  | [] => ret
  | [head, ...tail] =>
    switch (head) {
    | "--csv" => ArgSet.add(Csv, process_args(tail, ret))
    | "--forcelogin" => ArgSet.add(ForceLogin, process_args(tail, ret))
    | "--source" =>
      switch (tail) {
      | [] => raise(MissingArgument("--source"))
      | [arg1, ...tail] =>
        ArgSet.add(Source_file(arg1), process_args(tail, ret))
      }
    | "--config" =>
      switch (tail) {
      | [] => raise(MissingArgument("--config"))
      | [arg1, ...tail] =>
        ArgSet.add(Config_dir(arg1), process_args(tail, ret))
      }
    | arg_ => raise(InvalidArgument(arg_))
    }
  };
```

These valid requests were declared as a [variant type](https://reasonml.github.io/docs/en/variant):

```ocaml
type cmdlineargs =
  | Source_file(string)
  | Config_dir(string)
  | ForceLogin
  | Csv;
```

Now that we have a normalized array of requests, we can process it:

```ocaml
let arg_use_csv = ref(false);
let arg_no_login = ref(true);
let arg_source_file = ref("example.har");
let arg_dir_path = ref("config");
ArgSet.iter(
    k =>
    switch (k) {
    | Csv => arg_use_csv := true
    | ForceLogin => arg_no_login := false
    | Source_file(file_name) => arg_source_file := file_name
    | Config_dir(dir_path) => arg_dir_path := dir_path
    },
    args,
);
```

Using mutability, we will set some variables to default sane values, then update them with our array's content.

{{% notice %}}In ReasonML, mutable variables can be declared using `ref(value)` and that referenced value can be updated using the `:=` operator.{{% /notice %}}

**But, what is ArgSet?**

The missing piece: ReasonML lets you create modules based on other modules, to implement your own behaviors. In this example, we are talking about a very light implementation:

```ocaml
module ArgSet =
  Set.Make({
    type t = cmdlineargs;
    let compare = Pervasives.compare;
  });
```

We are creating a new module, meant to store requests in a set. This set is declared to be of a type `cmdlineargs` (see above) and its components can be compared using the default `Pervasives` module's comparison method. If you are not yet familiar with this module, please [bookmark this page](https://reasonml.github.io/api/Pervasives.html) as it provides basic operations over ReasonML's built-in types.

As you write more ReasonML, you will see lots of references to `type t` as an object's type. This convention is used for clarity. For instance, it could be used when [destructuring](https://reasonml.github.io/docs/en/destructuring) objects to write concise matching.

Finally, we use a couple exceptions to denote incorrect arguments:

```ocaml
exception MissingArgument(string);
exception InvalidArgument(string);
```

Yes, ReasonML has exceptions support. No, you should not use them in idiomatic code. Here, I am using exceptions because I wish to bail out of the program itself. If it was in the middle of, say, processing files in a fairly long loop, returning an `option` object would allow the program to treat this error code as any expected condition.
The authors of the Rust language decided not to support exceptions and instead always provide error codes. This forces the developer to immediately think about how to handle these errors, as opposed to passing the buck further up the execution stack.


