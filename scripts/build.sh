#!/bin/bash
mkdir build

echo "Importing config..."
cp accelerator-web-ui-template/config.toml build/baseconfig.toml
cp config.toml build/config.toml
cp -R content build/

echo "Importing themes..."
mkdir build/themes
cp -R accelerator-web-ui-template/themes/hugo-theme-learn build/themes/
cp -R accelerator-web-ui-template/layouts build/
cp -R accelerator-web-ui-template/static build/
cd build
git submodule update --init --recursive

echo "Creating Hugo site..."
hugo --config baseconfig.toml,config.toml --gc --minify -d ../public
cd ..
rm -r build
