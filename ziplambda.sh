#!/bin/bash

rm -rf dist
mkdir dist

cp -r src dist
pip3 install -t dist -r requirements.txt
echo "Installed requirements"
cd dist || exit

chmod 755 *
rm -rf ../terraform/profile-api.zip
echo "deleted existing zip from terraform"
zip -r ../terraform/profile-api.zip *
echo "copied zip to terraform"
rm -rf dist