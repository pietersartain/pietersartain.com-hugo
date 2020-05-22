#!/bin/sh
# https://www.client9.com/using-font-awesome-icons-in-hugo/
set -ex
dest=fontawesome

icons="twitter github linkedin lastfm soundcloud instagram"
url=https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/brands
mkdir -p "${dest}"
for icon in $icons; do
  icon="${icon}.svg"
  wget -O "${dest}/${icon}" "${url}/${icon}"
done

icons=""
url=https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/regular
mkdir -p "${dest}"
for icon in $icons; do
  icon="${icon}.svg"
  wget -O "${dest}/${icon}" "${url}/${icon}"
done

icons="rss file-alt address-card"
url=https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid
mkdir -p "${dest}"
for icon in $icons; do
  icon="${icon}.svg"
  wget -O "${dest}/${icon}" "${url}/${icon}"
done
