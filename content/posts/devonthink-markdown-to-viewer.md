---
title: "DEVONthink: MarkDown to Viewer"
description: "DEVONthink: MarkDown to Viewer"
slug: devonthink-markdown-to-viewer
date: 2012-01-19 22:43:42
draft: false
summary: "Like many other DEVONthink users, I have started to feel regret that MarkDown is not natively supported.Now, a piece of good news is that, as long as you edit a plain-text document in DT, you are, in effect, editing a potential MarkDown document.In the past, it was possible to open a DT document in an application such as the excellent Marked.app. But it is not any longer. I totally understand the author's argument: as a pure viewer, it feels wrong for an application to register as an editor."
image: "071c67b7-7c75-47f3-9feb-81a5e983ba72.jpg"
---


![](/images/DateLine.jpg)  
Like many other DEVONthink users, I have started to feel regret that MarkDown
is not natively supported.  
Now, a piece of good news is that, as long as you edit a plain-text document
in DT, you are, in effect, editing a potential MarkDown document.  
In the past, it was possible to open a DT document in an application such as
the excellent Marked.app. [But it is not any longer](http://support.markedapp.com/discussions/problems/30-marked-no-longer-appears-in-open-with-context-menu). I totally understand the author's
argument: as a pure viewer, it feels wrong for an application to register as
an editor.

So, here is my solution:

Create a short script

```applescript
tell application id "com.devon-technologies.thinkpro2"  
    set docInfo to the content record  
    set docPath to get the path of docInfo  
    tell application "Marked"  
        activate  
        open docPath  
    end tell  
end tell
```

Save this script as _/Application\ Support/DEVONthink\ Pro\ 2/Scripts/DTInMarkdown.scpt_  
Note: your actual DEVONthink folder name may differ based on which version you
are using.

In DT, select 'Script menu (icon) > Update Scripts Menu': you should now see your new script.

From the System Menu, open 'System Preferences...' then:  
'Keyboard > Keyboard Shortcuts > Application Shortcuts'

Create a new entry for DEVONthink Pro (or DEVONthink Pro Office); enter Menu
Title: _DTInMarkdown_ and enter a keyboard shortcut. I personally use
**Cmd+Shift+Return**.

Now, next time you are editing a plain text/MarkDown document in DT, that
keyboard shortcut should open the document in Marked.app for instant preview.
Note that the preview is updated every time you save your document.

