# NGINX Configuration Tips

NGINX, (the software's name is officially written in all-caps) is an amazing
piece of FOSS web infrastructure which makes a really good reverse proxy and a
HTTP(S) web server rolled into one.

Here I am sharing some ideas and configurations which have been helpful for me
personally.

## Setup Ideas

### Reverse Proxy Mode For Microservices

I use it for fronting a microservices architecture - I have a bunch of HTTP
services powered by different applications. What NGINX can do is that it lets
you forward HTTP paths (/app1/, /app2/, etc) on port 80 respectively to
localhost:8081/, localhost:8082 and localhost:8083.

This way you need not keep several ports open at the same time and/or expose
your internal architecture to the outside world.

Requesters only see one application running on port 80 (NGINX) which takes care
of forwarding different requests to different backend services.

Oh and by the way, HAProxy is another software really good at performing similar
tasks.

### Static Files Mode

NGINX is really efficient at serving static files, so you can benefit from using
NGINX to serve static assets like images and static web pages (like an Ember
application).

For the record, if you are on AWS I instead suggest using S3 to do the same. Set
up CloudFront CDN in front of it and experience blazing fast static hosting with
local edge servers across the world.

### External Services Proxy

In a more advanced setup, NGINX can be used as a pass-through when working with
external webservices like AWS. For example, I use it to proxy uploads to S3 by
using my internal API server for authentication and then directly forwarding the
payload to S3 PUT endpoint after setting the necessary additional headers.

If you have a really good webserver this might not give that much benefit but a
platform like Node.js which really sucks at handling large blobs of data can
avoid shaming itself by letting someone else handle the tasks it is weak at.

But an obvious benefit I can think of here is to abstract the upload files logic
to an external service, letting you use maybe the NGINX upload module to upload
files to a local directory during testing and then switch to S3 on release.

## My Configuration

I am including a few sample configurations here, including a really hard one to
get phpPgAdmin working which still does not direct the /phppgadmin path to PHP
and needs /phppgadmin/index.php to be accessed manually.

Edit: The file you should look at is `nginx-old.conf`. I haven't touched this
for a long time so it may have become a little outdated. I'll add a fresh sample
soon.