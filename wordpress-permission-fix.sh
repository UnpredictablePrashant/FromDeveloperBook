#!/bin/bash
#
# This fixes all the permission issue of wordpress
# Run this code against the wordpress installation directory (here I am assuming that your installation folder is /var/www/html
# sudo chmod +x wordpress-permissions-fix.sh
# sudo ./wordpress-permission-fix.sh /var/www/html
#
###############################################################################################


WP_OWNER=www-data # wordpress owner
WP_GROUP=www-data # wordpress group
WP_ROOT=$1 # wordpress root directory
WS_GROUP=www-data # webserver group

# reset to safe defaults
find ${WP_ROOT} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
find ${WP_ROOT} -type d -exec chmod 755 {} \;
find ${WP_ROOT} -type f -exec chmod 644 {} \;

# allow wordpress to manage wp-config.php (but prevent world access)
chgrp ${WS_GROUP} ${WP_ROOT}/wp-config.php
chmod 660 ${WP_ROOT}/wp-config.php

# allow wordpress to manage wp-content
find ${WP_ROOT}/wp-content -exec chgrp ${WS_GROUP} {} \;
find ${WP_ROOT}/wp-content -type d -exec chmod 775 {} \;
find ${WP_ROOT}/wp-content -type f -exec chmod 664 {} \;
