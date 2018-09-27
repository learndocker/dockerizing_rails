#!/usr/bin/env bash
if [ "$WAIT_FOR_POSTGRES" == "true" ]; then
  echo -n Waiting for postgres to start...
  while ! pg_isready -h ${PG_HOST:-localhost} > /dev/null; do
    sleep 0.5; echo -n .; done
  echo done
fi
if [ "$PREPARE_DATABASE" == "true" ]; then
  bundle exec rake db:create db:migrate
fi

# Workaround to get webpacker working
# TODO remove after updating to the next release
ln -fs $NODE_PATH node_modules
exec "$@"
