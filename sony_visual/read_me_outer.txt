https://phoenixnap.com/kb/install-homebrew-on-mac
https://www.geeksforgeeks.org/how-to-install-php-on-macos/



To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php_module /usr/local/opt/php@8.0/lib/httpd/modules/libphp.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

The php.ini and php-fpm.ini file can be found in:
    /usr/local/etc/php/8.0/

If you need to have php@8.0 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/php@8.0/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/php@8.0/sbin:$PATH"' >> ~/.zshrc

For compilers to find php@8.0 you may need to set:
  export LDFLAGS="-L/usr/local/opt/php@8.0/lib"
  export CPPFLAGS="-I/usr/local/opt/php@8.0/include"


// For Httpd
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php_module /usr/local/opt/php@8.0/lib/httpd/modules/libphp.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>


Install apache2
- brew update
- brew install apache2

DocumentRoot is /usr/local/var/www.

The default ports have been set in /usr/local/etc/httpd/httpd.conf to 8080 and in
/usr/local/etc/httpd/extra/httpd-ssl.conf to 8443 so that httpd can run without sudo.

To restart httpd after an upgrade:
  brew services restart httpd
Or, if you don't want/need a background service you can just run:
  /usr/local/opt/httpd/bin/httpd -D FOREGROUND

sudo apachectl start



Now, go to hosts file here /etc/hosts and add domains with local IPs


/Users/zohaib/Projects/CRM/crm_salamat_corp/

AH00557: httpd: apr_sockaddr_info_get() failed for Zohaibs-MacBook-Pro.local
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message
Zohaibs-MacBook-Pro:www zohaib$ sudo /usr/sbin/apachectl restart


Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To restart nginx after an upgrade:
  brew services restart nginx
Or, if you don't want/need a background service you can just run:
  /usr/local/opt/nginx/bin/nginx -g daemon off;
==> Summary
🍺  /usr/local/Cellar/nginx/1.23.0: 26 files, 2.2MB
==> Running `brew cleanup nginx`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

Nginx
nginx -s stop



Enable new php:

brew tap shivammathur/php


brew install shivammathur/php/php@7.0
brew install shivammathur/php/php@7.1
brew install shivammathur/php/php@7.2
brew install shivammathur/php/php@7.3
brew install shivammathur/php/php@7.4
brew install shivammathur/php/php@8.0

/opt/homebrew/etc/php/7.0/php.ini
/opt/homebrew/etc/php/7.1/php.ini
/opt/homebrew/etc/php/7.2/php.ini
/opt/homebrew/etc/php/7.3/php.ini
/opt/homebrew/etc/php/7.4/php.ini
/opt/homebrew/etc/php/8.0/php.ini


brew unlink php && brew link --overwrite --force php@7.3

https://getgrav.org/blog/macos-monterey-apache-multiple-php-versions


https://daily-dev-tips.com/posts/installing-postgresql-on-a-mac-with-homebrew/
psql postgres


brew services start postgresql
brew services start httpd


Brew install postgres

psql postgres

\du

CREATE ROLE zohaib WITH LOGIN PASSWORD ‘zohaib1212’;
ALTER ROLE zohaib CREATEDB;

\du get all roles and update in common/config file


\dt all tables



sudo -u postgres psql

\password postgre


mysql -u root -p
zohaib1212

use salamat


