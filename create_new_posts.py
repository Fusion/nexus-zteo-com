# This is python3
# id,section,publish_date,format_type,short_url,title,description,content

import os
import csv
import uuid
import requests
import shutil
import html2text
from pprint import pprint

ROOT_URL = 'http://nexus.zteo.com/static/media'

h = html2text.HTML2Text()
s = requests.Session()

with open("exported_from_old_nexus.dump", "r") as f:
    for row in csv.reader(f):
        #pprint(row)
        id, section, publish_date, format_type, slug, image, title, description, content = row
        print("%s/%s" % (slug, title))
        with open("content/posts/%s.md" % slug, "w") as c:
            clean_title = title.replace("\n", " - ").replace("\"", "\\\"")
            clean_description = description.replace("\n", "\\n").replace("\"", "\\\"")
            c.write("---\n")
            c.write("title: \"%s\"\n" % clean_title)
            c.write("description: \"%s\"\n" % clean_title)
            c.write("slug: %s\n" % slug)
            c.write("date: %s\n" % publish_date)
            c.write("draft: false\n")
            if clean_description != '':
                c.write("summary: \"%s\"\n" % clean_description)
            if image != '':
                if image.startswith('http'):
                    image_path = image
                else:
                    image_path = "%s/%s" % (ROOT_URL, image)
                r = s.get(image_path, stream=True, verify=False)
                if r.status_code != 200:
                    print("ERROR: Unable to download %s" % image_path)
                else:
                    _, file_extension = os.path.splitext(image)
                    new_image_name = "%s%s" % (str(uuid.uuid4()), file_extension.lower())
                    new_image_path = "content/images/%s" % new_image_name
                    with open(new_image_path, "wb") as im:
                        for chunk in r.iter_content(chunk_size=1024):
                            im.write(chunk)
                    c.write("image: \"%s\"\n" % new_image_name)
            c.write("---\n")
            if format_type == 2:
                c.write(content)
            else:
                c.write(h.handle(content))
