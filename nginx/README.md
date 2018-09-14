# NGINX Configuration

## External Tutorials

Here are some of the links I followed to pick up NGINX:

### How to Do Virtual Hosting

https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04

### How to Proxy Requests

https://www.ghostforbeginners.com/how-to-proxy-port-80-to-2368-for-ghost-with-nginx/


### How to serve static sites

https://medium.com/@jgefroh/a-guide-to-using-nginx-for-static-websites-d96a9d034940

## A tl;dr idea of NGINX

* `/etc/nginx` is where all configuration is stored. Usually you'd never need to
  mess with `nginx.conf` that is in this directory.
* The two directories we are interested in for configuring multiple sites are
  `sites-available` and `sites-enabled`.
* Config files of the format discussed in the sample configurations section are
  created (as root) and saved in the `sites-available` directory.
* The specific configurations we wish to enable are then symlinked to the
  `sites-enabled` directory by `cd`'ing into the `sites-enabled` directory and
  running a command like `ln -s ../sites-available/example.com example.com`.
* Only ONE of the several configuration files can have the `default_server` tag
  attached to the listen option. See `ubuntu1604.default.nginx.conf` to see how
  this looks.
* The server with the `default_server` tag is used like a fallback when none of
  the configuration files have a domain which matches the domain entered by the
  user.

## Setting up Let's Encrypt

See the [official docs](https://certbot.eff.org/) that lets you read
instructions for various platform combinations. It's really clear!
[Here](https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx) is the docs for
an Ubuntu 16.04 + NGINX combination.

## Sample Configurations

### Subdomain Examples

These examples all use NGINX to handle multiple virtual hosts via subdomains.
You could also have multiple domains point to NGINX via your DNS server and use
it to serve a different app depending on which domain was queried. The beauty is
that all these apps can listen on the same port.

Make sure you add a wildcard `A` record in your DNS server like this if you want
to redirect multiple subdomains (or sub-subdomains in my example) to the same
server.

```
*.subdomain 1800 IN A 8.8.8.8
```

#### Proxy to different App

File: `proxy.example.nginx.conf`

Here's an example where a sub-domain is used by NGINX to proxy requests to an
application running on a different port.


#### NGINX Serving an Angular App

File: `angular.example.nginx.conf`

Applicable for all client-side routed apps like those built with AngularJS,
Ember, Angular, React and Vue.

#### Serving A Simple Static Site and/or a File Browser

File: `static.example.nginx.conf`

Use if you have a bunch of HTML files you want to serve. There's also an example
here on how to have a simple file browser enabled for a sub-path of the URL.
This could also be enabled for the root path if you choose to do so.

### Other Examples

Here are a few other example files

#### Ubuntu 16.04 Default Configuration

File: `ubuntu1604.default.nginx.conf`

Here's an example file that's the same as the default NGINX configuration file
on Ubuntu 16.04. Useful for reference if something changes in 18.04.

### My Old Configuration

File: `old.nginx.conf`

I haven't touched this for a long time so it may have become a little outdated.
I'm keeping it around because I managed to get PHP working. It also has samples
of how to handle sub-directory based web-hosting.