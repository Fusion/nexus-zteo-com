---
title: "SuggestEditText: Android auto-suggest component"
description: "SuggestEditText: Android auto-suggest component"
slug: suggestedittext-android-auto-suggest-component
date: 2010-09-21 06:52:06
draft: false
summary: "My first Android application, SplitAndTip, makes splitting a restaurant check with your friends very easy.One of its key features is that I wanted the user to be able to change any parameter without feeling like the program gets in their way. For instance, you can open the &lsquo;Tax &amp; Tip&rsquo; drawer and quickly change these values.However, like many, I live and work at the edge of a couple counties and the county tax goes from 8.25% to a whopping 9.75% (L.A. County of course!)It is a tedious proposition to re-enter the same two percentages every time I cross the &ldquo;border.&rdquo;On a desktop computer, this is usually addressed through the use of a drop-down list. However the Android UI does not have room for a full-size selection component, unless you add more steps by popping one up every time you wish to adjust a value. This is no friendly user interface.The solution I found is a text field that will provide suggestions based on past values, while remaining in the text field itself."
image: "dbd04734-a4b3-45d1-a7e4-beca8d44c7a2.png"
---


[![](/images/qrcode_splitandtip.png)](/admin/blog/blogpost/133/)My
first Android application, **SplitAndTip** , makes splitting a restaurant
check with your friends very easy.  
One of its key features is that I wanted the user to be able to change any
parameter without feeling like the program gets in their way. For instance,
you can open the 'Tax & Tip' drawer and quickly change these values.  
However, like many, I live and work at the edge of a couple counties and the
county tax goes from **8.25%** to a whopping **9.75%** (L.A. County of
course!)  
![](/images/splitntip-168x300.jpg) It is a tedious
proposition to re-enter the same two percentages every time I cross the
"border."  
On a desktop computer, this is usually addressed through the use of a **drop-
down list**. However the Android UI does not have **room** for a full-size
selection component, unless you add more steps by popping one up every time
you wish to adjust a value. This is no friendly user interface.  
The solution I found is a text field that will provide **suggestions** based
on past values, while remaining in the text field itself.

## Implementation

  
I have created a new visual component that can be used in my XML layout file.
This new component is unimaginatively called _SuggestEditText_

_EditText_ , the usual Android input component, is a thin layer on top of
_TextView_ , which contains everything we need to edit, clear and validate a
text field.  
All we need to do is subclass _EditText_ , which already has edit controls
enabled, and make it listen for update events.

Our component will also implement the _TextWatcher_ interface: we will write a
version of _afterTextChanged(Editable s)_ that performs the completion work
itself.

We need to **load** an existing completion set, if any, and **update it** when
necessary. I have decided to use a _HashSet_ as it will transparently accept
already existing strings and not **duplicate** them, and it provides an API
for future improvements.

You can see, in this file, many calls to _DataStore.instance()_. It's a piece
you will need to replace with **your own controller**. Of course, ideally,
said controller would be injected in our constructor.

In res/values/attrs.xml we define an extra attribute for our new component:
**_key_**  
This attribute will be used as a unique identified for our list of completion
strings:

  
We can then use this attribute every time we include a _SuggestEditText_
component in our XML layout:

```xml
xmlns:voilaweb="http://schemas.android.com/apk/res/com.voilaweb.mobile.splitandtiplite"
```

[...]

We also accept a dedicated **listener** type, _TextChangedListener_ , that
will be used when **notifying a controller** that its model needs to be
updated with the new version of our completion set.

Back to our _TextWatcher_ interface; let's have a look at _afterTextChanged's_
implementation:

```java
/**  
  * Note: This callback will temporarily unregister from the listeners list  
  * This is the cleanest way to make sure we do not go into an infinite loop;  
  * however this is not the most efficient one.  
  */  
public void afterTextChanged(Editable s) {  
    String curText = this.getText().toString();  
    if(this.hasFocus()){  
        if(prevText.length()  < curText.length()) {  
            int longestMatch = 0;  
            String matchedValue = null;  
            Iterator it = this.completions.iterator();  
            while(it.hasNext()) {  
                String value = it.next();  
                if(value.startsWith(curText)) {  
                    int valueLen = value.length();  
                    if(valueLen > longestMatch) {  
                        longestMatch = valueLen;  
                        matchedValue = value;  
                    }  
                }  
            }  
            if(null != matchedValue) {  
                int savedPos = this.getSelectionStart();  
                unRegisterListener();  
                this.setText(matchedValue);  
                registerListener();  
                if(-1 != savedPos) {  
                    if(savedPos > longestMatch) {  
                        savedPos = longestMatch;  
                    }  
                    this.setSelection(savedPos, longestMatch);  
                }					  
            }  
        }			  
    }  
    prevText = curText;  
}
```

We do **two things** in this method:

1\. We look for an existing completion string that would match the text we
just entered; if we find one, we do not consider our search complete as, for
this component to work correctly, we need to provide the completion string
that **matches** our current text **most closely**. We retain the completion
that provides a match on the greater number of characters.

2\. We **replace** our field's text with the matched completion string;
however, this behavior would amount to a nuisance more than anything else, if
we stopped here. After all, the user needs an easy way to tell our component
that it is mistaken. To achieve this, we simply **select** the section of text
that was added to what was already entered. A simple keystroke is enough to
get rid of this suggested completion.

Note that we only provide completion suggestions when "moving forward" i.e.
this method does not do anything if the user is in the process of **deleting**
characters. We do this by checking our new string length versus our previous
measured length.

Also, this field's text can be updated programmatically, for instance when the
field is instantiated with an existing value. To avoid our code messing with
these updates, we check that the field is currently **focused** before doing
anything.

If you are curious regarding how our completion strings are **persisted** ,
here is how we do this in the controller:

Our completion strings are, as seen before, stored as a _HashSet_  
We store and retrieve each such set as a string. The "Stringification" is done
through these two methods:

```java
static public String objectToString(Serializable object) {  
    String str = new String();  
    try {  
        str = Base64.encodeObject(object);  
    }  
    catch(IOException ex) {  
// here, I handle the exception  
    }  
    return str;  
}  
    
static public Serializable objectFromString(String str) {  
    Serializable ser = null;  
    try {  
        ser = (Serializable)Base64.decodeToObject(str);  
    }  
    catch(IOException ex) {  
// here, I handle the exception  
    }  
    catch(ClassNotFoundException ex) {  
// here, I handle the exception  
    }  
    return ser;  
}
```

The conversion to- and from **base 64** is performed using Robert Harder 's
class found at <http://iharder.net/base64>

These strings are stored in a simple **key-value pairs** database.

**Note** : If you are a new Android developer, then please do not get in the
habit of serializing everything this way. There are **better APIs** available,
for instance for storing your instance states when your activity is frozen or
restarted by the system:

```java
public void onSaveInstanceState(Bundle savedInstanceState) {  
    savedInstanceState.putSerializable("item_info_list", this.itemInfoList);  
    super.onSaveInstanceState(savedInstanceState);    	  
}	
```

Just make sure that your object _this.instanceObject_ implements
_Serializable_.

You can download the .java file below. Its license is CC Attribution Share-
Alike. This license does not contaminate the rest of your code.  
[download id="3"]

