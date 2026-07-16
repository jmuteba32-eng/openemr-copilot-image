# OpenEMR 7.0.3 with this project's Clinical Co-Pilot menu tab.
#
# Exists as a separate GitHub repo because Railway cannot connect to this
# project's self-hosted GitLab (labs.gauntletai.com), and the OpenEMR service is
# image-sourced, so `railway up` cannot upload to it. Two files in a repo Railway
# CAN reach is the whole solution -- Railway builds the image itself, so no local
# Docker and no registry account are needed.
#
# Layers exactly one file onto the published image. Deliberately not a rebuild
# from source: the stock image is known-good and does its own first-boot setup,
# and putting that at risk to change one JSON file is a bad trade.
FROM openemr/openemr:7.0.3

COPY standard.json \
     /var/www/localhost/htdocs/openemr/interface/main/tabs/menu/menus/standard.json
