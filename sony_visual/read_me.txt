install php
- brew update
- brew tap shivammathur/php
- brew install php@8.1
- brew link --overwrite --force php@8.1
- and comment path from ~/.bash_profile


waleedmalik@Bayts-MacBook-Pro opt % brew link --overwrite --force php@8.0
Unlinking /usr/local/Cellar/php@7.3/7.3.33_4... 25 symlinks removed.
Linking /usr/local/Cellar/php@8.0/8.0.27_1... 25 symlinks created.

If you need to have this software first in your PATH instead consider running:
  echo 'export PATH="/usr/local/opt/php@8.0/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/php@8.0/sbin:$PATH"' >> ~/.zshrc


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


to add new v-host
just go to
/usr/local/etc/httpd/extra

and add new entry in virtual host like this
also make sure in httpd.conf Documentroot and <Directory section is all commented out and this virtual hosts is enabled

Include /usr/local/etc/httpd/extra/httpd-vhosts.conf


<VirtualHost *:80>
    ServerAdmin zohaibumar6@gmail.com
    DocumentRoot /Users/waleedmalik/learning_projects/skate_server/frontend/web
    ServerName skate.test
    ErrorLog /usr/local/var/log/httpd/frontend.test-error_log
    CustomLog /usr/local/var/log/httpd/frontend.test-access_log common

           <Directory "/Users/waleedmalik/learning_projects/skate_server/frontend/web">
                        # use mod_rewrite for pretty URL support
                        RewriteEngine on
                        # If a directory or a file exists, use the request directly
                        RewriteCond %{REQUEST_FILENAME} !-f
                        RewriteCond %{REQUEST_FILENAME} !-d
                        # Otherwise forward the request to index.php
                        RewriteRule . index.php

                        # use index.php as index file
                        DirectoryIndex index.php

                        # ...other settings...
                        # Apache 2.4
                        Require all granted

                        ## Apache 2.2
                        # Order allow,deny
                        # Allow from all
            </Directory>

</VirtualHost>



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



php /Users/zohaib/Projects/CRM/crm_salamat_corp/init --env=Development --overwrite=All --delete=All
php /Users/zohaib/Projects/CRM/crm_salamat_corp/yii migrate


yii serve --docroot="frontend/web/"


- php yii migrate (in root path)
- for gii to open in non-pretty do ?r=gii || in pretty just append home url with /gii

- For giving name: make sure it is full name with namespace e.g. frontend/models/<name> || common/models/<name> || backend/controllers/name
- For showing proper messaging with color make sure you are using bootstrap active forms.

Note: to create controller, use CRUD gii service rather than creating individual controller
- Make sure to add access Controls in behaviors, so that user may only be able to access controllers if he is logged in.

- For textArea make sure to use Text type while creating table in database

public static array $builtInValidators = [
    'boolean' => 'yii\validators\BooleanValidator',
    'captcha' => 'yii\captcha\CaptchaValidator',
    'compare' => 'yii\validators\CompareValidator',
    'date' => 'yii\validators\DateValidator',
    'datetime' => [
        'class' => 'yii\validators\DateValidator',
        'type' => \yii\validators\DateValidator::TYPE_DATETIME,
    ],
    'time' => [
        'class' => 'yii\validators\DateValidator',
        'type' => \yii\validators\DateValidator::TYPE_TIME,
    ],
    'default' => 'yii\validators\DefaultValueValidator',
    'double' => 'yii\validators\NumberValidator',
    'each' => 'yii\validators\EachValidator',
    'email' => 'yii\validators\EmailValidator',
    'exist' => 'yii\validators\ExistValidator',
    'file' => 'yii\validators\FileValidator',
    'filter' => 'yii\validators\FilterValidator',
    'image' => 'yii\validators\ImageValidator',
    'in' => 'yii\validators\RangeValidator',
    'integer' => [
        'class' => 'yii\validators\NumberValidator',
        'integerOnly' => true,
    ],
    'match' => 'yii\validators\RegularExpressionValidator',
    'number' => 'yii\validators\NumberValidator',
    'required' => 'yii\validators\RequiredValidator',
    'safe' => 'yii\validators\SafeValidator',
    'string' => 'yii\validators\StringValidator',
    'trim' => [
        'class' => 'yii\validators\TrimValidator',
        'skipOnArray' => true,
    ],
    'unique' => 'yii\validators\UniqueValidator',
    'url' => 'yii\validators\UrlValidator',
    'ip' => 'yii\validators\IpValidator',
]


https://www.yiiframework.com/doc/guide/2.0/en/input-validation

- to create dropdown in Gii , make sure the data type of column is enum('on','off')
- modules gii:

connect with database:
psql postgres
\c salamat

Mysql:

mysql -u root -p
zohaib1212

use salamat

