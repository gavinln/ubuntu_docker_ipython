#!/bin/bash
#
# Usage: source env.sh

SOURCE="${BASH_SOURCE[0]:-$0}"
DIR="$( cd "$( dirname "$SOURCE" )" && pwd )"

function ipython-fig() {
    ( cd $DIR ; sudo fig -f fig.yml $* )
}

alias ipy-ps='ipython-fig ps'
alias ipy-up='ipython-fig up -d'

