---
title: "Creating a ReasonML Native App: Configuration Files"
date: 2018-09-08T13:33:01-05:00
tags: ["reason", "functional"]
series: ["Reason Native App"]
draft: true
---

This is going to be a fairly short post, as it focuses on using the `config-file` library. As previously mentioned, when I mention a library in RasonML's native context, chances are pretty good that I am referring to one of OCaml's many available libraries.

<!--more-->

Our configuration files are not going to be json-formatted of xml-based; instead they are a tad...OCaml-ish, which of course is only true because of the comments:

```ocaml
host_info = {
  (* Server ip address or host name *)
  ip = "127.0.0.1"
  (* User name (or none if no login is required) *)
  user = user
...
}
```

This library's usage is pretty straightforward: after opening the library, we instantiate a new `group` object. The first thing we will do is create a default configuration file with sane values. Thus far, we have:

```ocaml
open Config_file;
let group = new group;
...
group#write("config/default.cfg");
```

{{% notice %}}Classes' members are accessed using `objectname#member` and not using dot notation. This behavior is inherited from OCaml.{{% /notice %}}

To be clear, this code does not do much of anything: it is writing an empty configuration file. What we need to do, before writing the file, is create a few entries:

```ocaml
let _ip = (new string_cp)(
  ~group,
  ["host_info", "ip"],
  "127.0.0.1",
  "Server ip address or host name");
...
```

The library supports several types of configuration objects:

- int_cp, float_cp, bool_cp, string_cp, list_cp, option_cp, enumeration_cp, tuple2_cp, tuple3_cp, tuple4_cp, string2_cp, font_cp, filename_cp

We construct an object with:

- which group this preference belongs to, the key's hierarchy, a default value and a description.


{{% notice %}}You can use a shortand when passing a variable named after the option being targeted: `myname = myname` => `~myname`{{% /notice %}}

**But, what if you want to make a preference optional?**

This is the `option_cp` type. Use a wrapper to turn objects into these option types. For instance, to provide an optional string:

```ocaml
let _start_at = (new option_cp)(
  string_wrappers,
  ~group,
  ["run_info", "start_at"],
  None,
  "Only start test when matching this record timestamp/duration");
```

Rather than `None` obviously our default value could have been `Some("my-time")`

**Reading**

Reading a configuration file is just as straightforward:

```ocaml
let read_config_file = (dir_path) => {
  group#read(
    ~on_type_error=
      (groupable_cp, raw_cp, output, filename, in_channel) =>
        {
          /*
           * Handle read error. Parameter names can be retrieved using
           *  String.concat(".", groupable_cp#get_name),
           */
        },
    sprintf("%s/default.cfg", dir_path));
};
```

**Bonus: reading a .ignore file line-by-line**

This is helpful for quick prototyping: how do you read an arbitrary collection of strings from a file?

```ocaml
let read_ignore_list = (dir_path, name) =>
  List.fold_left((accu, item) =>
    StringSet.add(item, accu),
    StringSet.empty,
    Str.split(
      Str.regexp("\n"),
      my_read_file_function(sprintf("%s/ignored.%s", dir_path, name)))
  );
```
