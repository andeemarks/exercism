#!/bin/sh

FOLDER=$1
git subtree split -P ${FOLDER} -b exercism-${FOLDER} 
cd ..
mkdir exercism-${FOLDER} 
cd exercism-${FOLDER}/
git init
git pull ../exercism exercism-${FOLDER} 
git remote add origin git@github.com:andeemarks/exercism-${FOLDER}.git
git branch -M main
git push -u origin main
cd ../exercism
git rm -rf ${FOLDER}/