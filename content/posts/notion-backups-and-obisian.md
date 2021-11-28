+++
date = "2021-11-27T10:54:24-08:00"
draft = false
title = "Notion Backups and Obsidian"
slug = "notion-backups-and-obsidian"
tags = ["productivity"]
image = "notion-obsidian-github.png"
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = ""
featured = false
description = ""
summary = "Notion backups and Obsidian search, also for idiots like me."

+++

{{<hero image="notion-obsidian-github.png" height="300px">}}

Who knew that I would start creating more posts for people who are challenged by every day tools like me? Well, here we are.

## What is this?

I am trying to kill two birds with one stone:

1. Ensure that I have backups of my Notion notebooks. Notion is a well-funded SaaS and I am not too worried about them going under and losing my data anytime soon, but one can never be too careful when a single notebook grows to tens of thousands of entries. In addition, there is always the issue of Notion being usable offline. Since I drank the kool-aid long ago and decided that Notion was, indeed, going to be where I offload everything I would otherwise have to keep inside my head, I'd rather not lose it all.
2. I wish there was a way to keep a graph of links between notions notes, **and** I wish Notion's search feature worked a bit (or a lot) faster, and was more powerful, elastic-like.

Surely, item #1 can be addressed through regular backups, and #2 would, ideally, require a plugin of some kind that provides a strong search feature and note correlations while understanding Notion's underlying schema. Absent that, if I can import my notes in [Obsidian](https://obsidian.md), I can get pretty close to this ideal scenario.

<figure>

![obsidian](/images/obsidian-sc.png)<figcaption>Obsidian screenshot</figcaption>

</figure>

Of course, all of this was inspired by "prior art."

Obsidian integration: the idea came from using a MacOS tool called [NotePlan](https://noteplan.co) which works well with my workflow. It's the only GTD approach that has really "stuck" over time: there is a page for every day, and this page can contain tasks, notes, etc. These tasks can then be reviewed periodically, prioritized, etc. And yes, while I promised that I would talk about three tools, you are getting information on an awesome fourth one for free! :)

<figure>

![noteplan](/images/noteplan-sc.jpg)<figcaption>NotePlan screenshot</figcaption>

</figure>

Since I wanted to be able to consult my NotePlan notes on my Android phone(!), I needed a viewed, and Obsidian provided just that. NotePlan's developer has been extremely active and engaged with their users (their Discord channel is very busy), and they even [created a write-up on how to integrate with Obsidian](https://help.noteplan.co/article/61-use-noteplan-with-obsidian).

GitHub backups: This is the blog post where I got the idea from: https://artur-en.medium.com/automated-notion-backups-f6af4edc298d. This was a good starting point. However, it was reliant on GitLab while I was more interested in pushing my backups to GitHub. I loved the idea of using GitHub's own workflows to keep this operation entirely autonomous so the implementation was going to be quite similar to the one used with Gitlab.

## Implementation

### GitHub Backup

{{<alert "w3-deep-purple" "Note" "Because I do not wish to abuse GitHub's resources, I am 'only' running the backup script one a week. Feel free to adapt the workflow to fit your own needs." >}}

You will need to retrieve the values for `NOTION2_TOKEN_V2` and `NOTION2_SPACE_ID` as described in the aforementioned blog post. I am reproducting the steps here (although somewhat simplified) in case that post disappears:

1. Open http://notion.so/, go to “Settings & Members” → “Settings”
2. Open [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools) by pressing Command+Option+J (Mac) or Control+Shift+J (Windows, Linux, Chrome OS)
3. Go to the Network tab
4. Enable “XHR” filter (1), clear console (2), start the export (3), select “enqueueTask” (4)
5. In the "Headers" tab, search the `cookie:` value for a `token_v2` assignment
6. Then, under "Request Payload" capture the value assigned to `spaceId`
7. Save these two values in your workflow file

Now, create your backup repository in GitHub. In my case, it is a private repo.

By default, this repo comes with two files:

`.github/workflows/github-actions-backup.yml`

```yaml
name: GitHub Actions Notion Backup
on:
  schedule:
    - cron:  '0 0 * * SUN'
jobs:
  Export-Notion:
    runs-on: ubuntu-latest
    steps:
      - name: Sync repo
        uses: actions/checkout@v2
      - name: Setup Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.8'
          architecture: 'x64'
      - name: Run Python script
        env:
          NOTION_TOKEN_V2: ${{ secrets.NOTION2_TOKEN_V2 }}
          NOTION_SPACE_ID: ${{ secrets.NOTION2_SPACE_ID }}
        run: python export.py
      - name: Packing up results
        run: |
          git config user.name <your name>
          git config user.email <your email address>
          git pull
          mkdir -p backup
          rm -rf backup/*
          unzip -q export.zip -d backup/
          printf "Updated: %s\n\nUpdates: %s" "$(date)" "$stats" > README.md
          git add backup README.md
          git commit -m "Updates: $(git diff --shortstat | xargs)"
          git push origin HEAD:main
```

Note that the you need to store the `NOTION_*` variables in GitHub as [encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

Also, if you desire to modify the schedule for this workflow's runs, you will need to follow the CRON syntax. Here is a [handy tool](https://crontab.guru) to create your own expressions.

The second file is the python script that will be executed to perform the actual export.

`export.py`

```python
#!/usr/bin/env python
import os
import json
import time
import urllib
import urllib.request

TZ = os.getenv("TZ", "Americas/Los_Angeles")
NOTION_API = os.getenv('NOTION_API', 'https://www.notion.so/api/v3')
EXPORT_FILENAME = os.getenv('EXPORT_FILENAME', 'export.zip')
NOTION_TOKEN_V2 = os.environ['NOTION_TOKEN_V2']
NOTION_SPACE_ID = os.environ['NOTION_SPACE_ID']

ENQUEUE_TASK_PARAM = {
    "task": {
        "eventName": "exportSpace", "request": {
            "spaceId": NOTION_SPACE_ID,
            "exportOptions": {"exportType": "markdown", "timeZone": TZ, "locale": "en"}
        }
    }
}


def request(endpoint: str, params: object):
    req = urllib.request.Request(
        f'{NOTION_API}/{endpoint}',
        data=json.dumps(params).encode('utf8'),
        headers={
            'content-type': 'application/json',
            'cookie': f'token_v2={NOTION_TOKEN_V2}; '
        },
    )
    response = urllib.request.urlopen(req)
    return json.loads(response.read().decode('utf8'))


def export():
    task_id = request('enqueueTask', ENQUEUE_TASK_PARAM).get('taskId')
    print(f'Enqueued task {task_id}')

    while True:
        time.sleep(2)
        tasks = request("getTasks", {"taskIds": [task_id]}).get('results')
        task = next(t for t in tasks if t.get('id') == task_id)
        print(f'\rPages exported: {task.get("status").get("pagesExported")}', end="")
        if task.get('state') == 'success':
            break

    export_url = task.get('status').get('exportURL')
    print(f'\nExport created, downloading: {export_url}')

    urllib.request.urlretrieve(
        export_url, EXPORT_FILENAME,
        reporthook=lambda c, bs, ts: print(f"\r{int(c * bs * 100 / ts)}%", end="")
    )
    print(f'\nDownload complete: {EXPORT_FILENAME}')


if __name__ == "__main__":
    export()
```

That's it.

### Obsidian Setup

First, you will need to create a local clone of your repository. No way around that. For reference, as I previously mentioned my main Notion notebook is several tens of thousands of pages thick and this weighs in at about 1.6GB of storage.

I recommend perfoming the original clone operation as:

```bash
git clone --depth=1 <github URL>
```

Open Obsidian and, as described in the previously mentioned page on NotePlan integration, simply open a new vault. This vault's location will be the `backup` folder in your repository. Obsidian will automatically start indexing your knowledge base.

Do not forget to regularly `git pull` this repository's content (in my case, once a week at most)!

## Obsidian Search

First, I would like to show you what Obsidian's graph view of my Notion notes look like:

![noteplan](/images/obsidian-sc-2.png)

You'll get a better idea of the value I can get from this graph when I display the "local graph" for the search `kubernetes OR swam`:

![noteplan](/images/obsidian-sc-3.png)

Obviously, an refined naming scheme for the saved items would improve legibility dramatically!	

Search syntax is, however, when Obsidian currently shines, when compared to notion (well, syntax and **speed**!):

- `kubernetes OR swarm` (equivalent do `kubernetes<space>swarm`)
- `kubernetes AND docker`
- `"kubernetes docker"` will search for this phrase
- `kubernetes -docker` to reject the second word
- `(kubernetes OR swarm) AND docker`
- `/kubernete[sz]` yes regex is supported
- `file:.png` to find png images
- [and many more!](https://help.obsidian.md/Plugins/Search)



{{% posse %}}
