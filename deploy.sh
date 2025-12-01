#!/bin/bash

hugo -t bleak
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
cd public
git add .
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push origin HEAD:master

cd ..

echo -e "\033[0;32mDeploying updates to Mahogany...\033[0m"
tar zcvf shuttle.tgz public
scp shuttle.tgz mahogany.voilaweb.com:~/
ssh mahogany sudo tar zxvf shuttle.tgz -C /home/nexus/live
