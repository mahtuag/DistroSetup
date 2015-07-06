## Heroku CLI Setup

I'm not too fond of installing stuff on root when it isn't managed by the
offical package management solution.

Heroku CLI by default expects to be installed as root so this is how you avoid
that:

* Check out the install  shell script https://toolbelt.heroku.com/install.sh
* It points to
  https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client.tgz
  which is the archive where the Heroku CLI is actually held.
* Download the above archive and extract to an appropriate directory
* Add ```$BASE_DIR_OF_EXTRACTION/heroku-client/bin``` to your $PATH
* Run ```heroku login```
* Ba dum tss!
