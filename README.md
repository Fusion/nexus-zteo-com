# To create a new post:
```
hugo new posts/{filename.md}
```

# To serve locally:
```
hugo server -D
```

# Where is my theme? Where are my shortcodes?
```
cp -r theme_bleak_tweaked/* themes/bleak/
```

# Notes

Before deploying/building, we should pull our `public` submodule:
```
git submodule update --init --remote -- public
```

# Short Codes

## alert title content
TODO: Example
## anycaption title="caption"
```
{{< anycaption title="Nice picture caption" >}}
...
{{< /anycaption >}}
```
## button href="href" [icon="icon"] [icon-position="left|right"]
```
{{% button href="https://getgrav.org/" icon="fas fa-download" %}}Get Grav with icon{{% /button %}}
```
## codecaption title="caption" [lang="lang"]
```
{{< codecaption lang="html" title="Code caption shortcode" >}}
...
{{< /codecaption >}}
```
## expand
```
{{%expand "Is this a good test?" %}}
```
## flex
```
{{< flex >}}
    {{< flex-column >}}
        <center>
            <p>this is your first (leftmost) column!</p>
        </center>
    {{< /flex-column >}}
    {{< flex-column >}}
        <center>
            <p>this is your second (rightmost) column!</p>
        </center>
    {{< /flex-column >}}
{{< /flex >}}
```
## fluid-imgs
```
{{< fluid-imgs
    "pure-u-1-3|/images/Grumpy-Cat.jpg"
    "pure-u-1-3|/images/Grumpy-Cat.jpg"
    "pure-u-1-3|/images/Grumpy-Cat.jpg"
>}}
```
## gist
```
{{< gist index >}}
```
## gistf
```
{{< gistf id="index" file="file" >}}
```
## img-post
```
{{< img-post "/images" "Grumpy-Cat.jpg" "Grumpy Cat" "left" >}}
lorem ipsum...
{{< /img-post >}}
```
## img-process
```
{{< img-process ProgrammerInterrupted.png Resize "60x" prgint >}}
```
## imgblur
```
{{< imgblur prefix="path" >}}
```
## keypress
```
{{< keypress "key" >}}
```
## lightbox
```
{{< lightbox id="prgint" type=scrollable >}}<img src="/images/ProgrammerInterrupted.png">{{< /lightbox >}}
```
## linkprevieew
```
{{<linkpreview
   src="/images/istio-logo.png"
   href="https://istio.io/docs/setup/getting-started/#download"
   title="Istio"
   description="Getting Started">}}

```
## mermaid
```
{{<mermaid>}}
...
{{</mermaid>}}
```
## notice
```
{{% notice tip %}}
A tip disclaimer
{{% /notice %}}
```
## raw-html
```
{{<raw-html>}}<b>hello</b>{{</raw-html>}}
```
## section
```
{{<section>}}
lorem ipsum
{{</section>}}
```
## simpleitem
```
{{<simpleitem 1>}}Security and Privacy{{</simpleitem>}}
```
## simpletab
```
go to the {{< simpletab 1>}}Privacy{{< /simpletab >}} tab
```
## table
```
{{< table caption="Configuration parameters" >}}
Parameter | Description | Default
:---------|:------------|:-------
`timeout` | The timeout for requests | `30s`
`logLevel` | The log level for log output | `INFO`
{{< /table >}}
```

# Alternatives

Lightbox: https://micro.json.blog/2019/12/30/223827.html (https://biati-digital.github.io/glightbox/)

# Web Mentions

We are already including a Javascript header that leverages https://webmention.io/

For now, visiting this website and logging in using RelMeAuth lets me access the configuration and mentions.

To display mentions, an easy method would be to download https://github.com/PlaidWeb/webmention.js and including it under each post.

This being said, I should also include an h-card (as defined in microforrmats2 spec):

```
<p class=“h-card vcard”>
   <a style=“text-decoration: none” href={{ .Site.BaseURL }} class=“p-name u-url url author metatag” rel=“me”> {{ .Site.Author.name }} </a> /
   <a class=“p-nickname u-email email metatag” rel=“me” href=“mailto:{{ .Site.Author.email }}“> {{ .Site.Author.nick }} </a>
   <img class=“u-photo” src=“img/headshot.png” alt=“” />
</p> 
```

More here: http://microformats.org/wiki/microformats2#h-card

Finally, **done**: research Bridgy (https://indieweb.org/Bridgy)

In the end, this blog implements:

- mf2: h-feed, h-entry, e-content, p-name, dt-published, u-url
- Webmention (including pingback)
- IndieAuth (rel=me)
- Open Graph (https://oqp.me)

