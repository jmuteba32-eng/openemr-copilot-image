# OpenEMR 7.0.3 with this project's Clinical Co-Pilot menu tab.
#
# Exists as a separate GitHub repo because Railway cannot connect to this
# project's self-hosted GitLab, and the OpenEMR service is image-sourced, so
# `railway up` cannot upload to it. Railway builds this repo directly -- no local
# Docker and no registry account needed.
FROM openemr/openemr:7.0.3

COPY standard.json \
     /var/www/localhost/htdocs/openemr/interface/main/tabs/menu/menus/standard.json

# Stash a pristine copy of sites/ outside the volume's mount path.
#
# sites/ holds everything setup generates -- sqlconf.php, encryption keys, OAuth2
# certificates -- and in the stock image it lives in the container filesystem,
# which is why replacing the container destroyed it (see W2_ARCHITECTURE.md 13).
# Mounting a volume there fixes durability but introduces the opposite problem:
# an empty volume SHADOWS the image's sites/ template rather than merging with
# it, so the container boots with no site scaffolding at all and cannot
# configure itself.
#
# This copy lets the start command seed the volume from the image on first boot,
# after which setup writes into durable storage and every later redeploy just
# picks it up.
RUN cp -r /var/www/localhost/htdocs/openemr/sites \
          /var/www/localhost/htdocs/openemr/sites-template
