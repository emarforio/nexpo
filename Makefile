# This file contains all commands needed to start your dev environment!

.PHONY: fresh-install-linux install-mac install-linux install-deps reset-db create-db-user

create-db-user:
	sudo -u postgres psql -c "CREATE USER nexpo PASSWORD 'nexpo' CREATEDB;"

reset-db:
	sudo -u postgres psql -c "DROP DATABASE IF EXISTS nexpo_dev;"
	sudo -u postgres psql -c "DROP DATABASE IF EXISTS nexpo_test;"
	sudo -u postgres psql -c "DROP USER IF EXISTS nexpo;"

install-deps:
	mix local.hex --force && \
	mix local.rebar --force && \
  wget https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez && \
	mix archive.install --force ./phoenix_new.ez && \
	rm ./phoenix_new.ez && \
	npm run install-deps && \
	mkdir -p $(HOME)/.s3bucket/nexpo-test && \
	mix ecto.create && \
	mix ecto.migrate

install-linux: create-db-user install-deps
	npm test

install-mac: install-deps
	npm test

fresh-install-linux: reset-db create-db-user install-deps
	npm test
