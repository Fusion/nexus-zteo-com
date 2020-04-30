To create a new post:
```
hugo new posts/{filename.md}
```

To serve locally:
```
hugo server -D
```

Where is my theme? Where are my shortcodes?
```
cp -r theme_bleak_tweaked/* themes/bleak/
```

Before deploying/building, we should pull our `public` submodule:
```
git submodule update --init --remote -- public
```
