#!/bin/bash
#
# Usage: source env.sh

SOURCE="${BASH_SOURCE[0]:-$0}"
DIR="$( cd "$( dirname "$SOURCE" )" && pwd )"

function jenkins-fig() {
    ( cd $DIR ; sudo fig -f fig.yml $* )
}

alias jk-ps='jenkins-fig ps'
alias jk-up='jenkins-fig up -d'

