#!/bin/bash

# Exit on any errors.
set -e

PUPPET_INSTALL='puppet module install'

# install puppet modules
(puppet module list | grep acme-ohmyzsh) ||
    $PUPPET_INSTALL -v 0.1.2 acme-ohmyzsh

(puppet module list | grep thias-samba) ||
    $PUPPET_INSTALL -v 0.1.5 thias-samba

(puppet module list | grep garethr-docker) ||
    puppet module install -v 4.0.2 garethr-docker
