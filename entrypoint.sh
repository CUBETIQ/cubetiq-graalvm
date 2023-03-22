#!/bin/bash

set -e

source $HOME/.sdkman/bin/sdkman-init.sh

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- java "$@"
fi

exec "$@"