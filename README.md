# How to use? (Only experimental)
- Edit the environment variable in `.env-sample` and rename it ias `.env`.
- Run `./build.sh` in the root directory.

# Docker-compose
- Run the bash script `build.sh` instead of `docker-compose up -d --build`.
- This would copy the files from `post_build` directory to `app` directory **AFTER** the Wordpress image is copied and mounted on the volume to `app` directory.

We edited the following files with these addtional code:
### .htaccess

```apacheconf
# Redirect HTTP to HTTPS (all requests)
RewriteCond %{HTTP:X-Forwarded-Proto} ^http$
RewriteRule ^ https://YOUR_URL%{REQUEST_URI} [R=302,L]
```

### wp-config
```php
 * ==================== SSL CONFIGURATION ====================
 * Websites behind load balancers or reverse proxies that support
 * HTTP_X_FORWARDED_PROTO can be fixed by adding the following code 
 * to the wp-config.php file, above the require_once call:
 */
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
	$_SERVER['HTTPS'] = 'on';

/**
 * ==================== AMAZON AWS S3 ====================
 */
define( 'DBI_AWS_ACCESS_KEY_ID', 'ENTER_YOUR_AWS_ACCESS_KEY_FOR_S3' );
define( 'DBI_AWS_SECRET_ACCESS_KEY', 'ENTER_YOUR_AWS_SECRET_KEY_FOR_S3' );

/** ==================== ENVIRONMENT SETTINGS FOR WORDPRESS ==================== */

/** HTTPS */
if(getenv('WP_ENV') == 'production')
	define('WP_HOME', 'https://' . $_SERVER['SERVER_NAME']);

/** HTTP */
if(getenv('WP_ENV') == 'development')
	define('WP_HOME', 'http://localhost');
	
define('WP_SITEURL', WP_HOME);
```