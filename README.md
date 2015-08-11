# Phoenix-Sekeleton

Master branch currently supports Phoenix v0.16.1

- for full changes list, see [CHANGES](./CHANGES.md)
- for roadmap, see [ROADMAP](./ROADMAP.md)

## What's new in v0.16.0?

- Upgrade project to support Phoenix v0.16.1
- Temporarily drop memcached-saved sessions, using default cookie-store until I get it to work with exrm
- Finally include a _working_ brunch config (no need for links from bower_components to web/static any more)
- move roadmap to ROADMAP.md
- BUG: live css reloader currently not working (not even in clean phoenix install, waiting for upstream fix)

## coming up next

- move Plug.Authorization.Roles into an external dependency, make it configurable from NavigationTree
- documentation for deployment scripts (systemd service files and nginx conf)

# Installation

1. Install Elixir dependencies with `mix deps.get`
2. Install npm dependencies for ranch with `npm install`
    - on Debuan/Ubuntu "deb.nodesource.com" works great
3. Install bower dependecies with `bower install`
4. Check system dependencies, run postgre dev script below
5. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

# System dependencies

- Erlang/Elixir, of course ;-)
- PostgreSQL (tests run on 9.4)
    - see config/dev.exs for host/user/port settings (CAUTION: dev host is set to 192.168.0.240, this will fail on your machine, set to locahost!)
- npm package manager
    - tested with 1.4.28
- bower package manager
    - tested with 1.4.1

## Create development database

This will create a database "skeleton_dev" owned by "skeleton_dev_user" with password "skeleton_dev_pass". Tune this to yout needs.

```
CREATE ROLE skeleton_dev_user LOGIN
  ENCRYPTED PASSWORD 'md5465fc2608ab7a4ebe4eaa198e63b85a7'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
CREATE DATABASE skeleton_dev
  WITH OWNER = skeleton_dev_user
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'de_DE.UTF-8'
       LC_CTYPE = 'de_DE.UTF-8'
       CONNECTION LIMIT = -1
       TEMPLATE = template0
      ;
```
_Hint_: You may need to adjust de_DE.UTF-8 to your needs and use this Gist:
(https://gist.github.com/ffmike/877447)

# Deployment

Hot code relaod is not covered here. Be sure to meet system dependencies.

## Known deployment issues

- For some reason, using this thingy with the memcached session plug does not work as a `mix release` production release. 
  Startup with `MIX_ENV=prod mix phoenix.server` is fine, though. A workaround is to either use this method or resort to Cookie-based session storage.

## simple (pack, copy, run)

- run `bash etc/compile_release.sh`
- copy `rel/skeleton/releases/<version>/skeleton.tar.gz` to your production machine
- extract, then run `bin/skeleton --start` or `bin/skeleton --console` (if you want and iex shell)

## my favourite (clone, pack, run-as-service)
This assumes a linux production machine with systemd as init system and a bash shell. Something like Debian 8 or Ubuntu 15.04 (these both are tested).

=======
### install
I am used to put these things into `/var/www-apps/<project-name>`. Scripts and configs in ./etc are tuned to this.
```
cd /var/www-apps
git clone https://github.com/gutschilla/phoenix-skeleton.git
cd phoenix-skeleton
bash etc/compile_release.sh
npm install
bower install
brunch build
mix ecto.migrate
systemctl enable /var/www-apps/phoenix-skeleton/etc/phoenix_skeleton_backend.service
systemctl start phoenix_skeleton_backend.service
cd /etc/nginx/sites-available
ln -s /var/www-apps/phoenix-skeleton/etc/skeleton.nginx skeleton
cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/skeleton
systemctl nginx reload
```

### upgrade to current master
```
cd /var/www-apps/phoenix-skeleton
git pull
bash etc/compile-release.sh
systemctl restart phoenix_skeleton_backend.service
```

# Feedback

Is more than welcome. I am still learing this whole Elixir and Erlang/OTP thing so be rude, be harsh but be helpful.
