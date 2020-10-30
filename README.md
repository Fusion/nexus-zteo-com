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

# Web Mentions

We are already including a Javascript header that leverages https://webmention.io/

For now, visiting this website and logging in using RelMeAuth lets me access the configuration and mentions.

To display mentions, an easy method would be to download https://github.com/PlaidWeb/webmention.js and including it under each post.
