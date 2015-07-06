## Passwordless GitHub

While retaining the system of using HTTPS to access your repository, which is
both the default and recommended way, you can avoid entering your password each
time you need to push something. I am not referring to [Git Credential Cache](git-scm.com/docs/git-credential-cache) here
if you think that's what I mean.

First, go to https://github.com/settings/tokens/new and get a personal OAuth
token. Enable just the repo scope - this is all you need to push and pull code.

Now you can use this token string as a password with your existing username. But
we shall make this process hands-free next.

Edit your ~/.netrc (creating one if you don't have it - Heroku setup already
creates such a file incidentally) and add the following contents excluding the
angular braces <>:

```
machine github.com
	login <your_github_handle>
	password <personal_oauth_token>
```

You may now push and pull (for private repos) code without entering  username
and password.

You could have done this with your GitHub  password directly but for many
obvious reasons that is a really stupid idea.
