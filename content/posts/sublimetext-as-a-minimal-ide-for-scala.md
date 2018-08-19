---
title: "SublimeText as a minimal IDE for Scala"
description: "SublimeText as a minimal IDE for Scala"
slug: sublimetext-as-a-minimal-ide-for-scala
date: 2012-11-26 07:01:03
draft: false
summary: "Well, the Coursera \"Functional Programming Principles in Scala\" class was a success. Both&nbsp;Tom Chappell&nbsp;and I really enjoyed it.&nbsp;However, I've never much liked Eclipse as an IDE. Here is how I am using Sublime Text 2 instead."
image: "edfccf8a-cbfd-47fe-bedb-fb9eb79bdfd6.png"
---


Well, the Coursera "[Functional Programming Principles in Scala](https://class.coursera.org/progfun-2012-001/class/index)" class was a
success. Both [Tom Chappell](http://tomchappell.com/) and I really enjoyed it.
However, I've never much liked Eclipse as an IDE. Here is how I am using
Sublime Text 2 instead.

![](/images/Screenshot%2011:25:12%2011:20%20PM.png)

**Syntax highlighting, error detection**

1-Install Sublime Text 2

2- Now, let's prepare our environment for Ensime (aka "ENhanced Scala
Interaction Mode for Emac") and its "sbt" plugin:

* Add to the end of ~/.sbt/plugins/plugins.sbt (or create it if needed):

```scala
addSbtPlugin("org.ensime" % "ensime-sbt-cmd" % "0.1.0")
```

* Add ensime to Sublime Text 2:

Preferences > Package Control > Install Package > Ensime or  
    
```bash
git clone git://github.com/sublimescala/sublime-ensime.git Ensime
```

3-Install the Ensime server:

* Download it from <https://github.com/sublimescala/ensime/downloads>
* Command line:

```bash
tar zxvf to ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Ensime
mv 'ensime_xxxx' to 'server'
```

* Restart Sublime Text 2
* Start the Ensime server: {Cmd}{S}P Ensime: Startup or Tools > Maintenance > Startup

4-Let's a couple templates for Scala projects:

* Install Conscript:

```bash
curl https://raw.github.com/n8han/conscript/master/setup.sh | sh
```

* Using Conscript, install giter8: 

```bash
cs n8han/giter8
```

* g8 templates found at: <https://github.com/n8han/giter8/wiki/giter8-templates>:

"ymasory/sbt" is a good start for github; "typesafehub/scala-sbt" is total
boilerplate 5-This is the interesting part. We can now create a project and
prepare its template and Ensime server:

* Command line:

```bash
cd /your project home directory/
gr8 typesafehub/scala-sbt
sbt
ensime generate
```

* Run Subime Text 2:

```bash
subl .
```

* Display Ensime's console window: Tools > Ensime > Development > Show Notes

**Using the Scala REPL** **  

* Install SublimeREPL (instructions by fellow Coursera student Alexei Alekhin!)

We wish to install a version of SublimeREPL that support sbt; therefore,
rather than using the main branch:

Preferences > Package Control > Install Package > Ensime > Package Control: Add repository

Add this path: https://github.com/laughedelic/SublimeREPL/archive/sbt.zip

Preferences > Package Control > Install Package > SublimeREPL

* Not working? Make sure that sbt or a link to sbt is found in /usr/local/bin/
* OPTIONAL: Install the companion  app: LoadFileToRepl

Preferences > Package Control > Install Package > LoadFiletoRepl  
  
**Building/Running  **

* Create new build profile

```json
{
"cmd": ["/usr/local/bin/sbt -Dsbt.log.noformat=true compile"],
    "file_regex": "^\\[error\\] ([.a-zA-Z0-9/-]+[.]scala):([0-9]+):",
    "selector": "source.scala",
    "working_dir": "${project_path:${folder}}",
    "shell": "true"
}
```

* Use /F4/ and /Shift//F4/ to navigate through errors

That's it for now. I'll be sure to add more info if I find wasy to provide
even tighter integration.

