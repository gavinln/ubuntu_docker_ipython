'''
TODO: May need to fix error in
http://askubuntu.com/questions/59458/
error-message-when-i-run-sudo-unable-to-resolve-host-none
'''
from __future__ import print_function

from fabric.api import run, env, task, roles, local, lcd
from fabric.api import open_shell, put, cd, sudo
from fabric.api import settings

from fabric.contrib.files import exists
from fabric.contrib.project import rsync_project

import os
import shutil
import yaml
import sys
import platform


script_dir = os.path.dirname(__file__)

env.use_ssh_config = True

env.hosts = ['aws']


def check_host_connection(task_name):
    ' not used '
    if any([env.user is None,
           env.host_string is None,
           env.key_filename is None]):
        msg = 'Use "host" task before the "{}" task to setup the ' \
            'host connection info'
        print(msg.format(task_name))
        sys.exit(1)


def get_project_name():
    ''' gets the project root directory name assuming the current
        directory is a child of the project root directory
    '''
    root_dir = os.path.normpath(os.path.join(script_dir, '..'))
    project_name = os.path.basename(root_dir)
    return project_name


def get_ssh_key(key_name):
    key_file = os.path.normpath(os.path.join(
        script_dir, '..', 'do_not_checkin', key_name + '.pem'))
    if os.path.exists(key_file):
        return key_file
    raise Exception('Key file {} does not exist'.format(key_file))


@task
def hostname():
    run('hostname')


@task
def upload():
    ''' upload project to a ec2 instance '''
    root_dir = os.path.normpath(os.path.join(script_dir, '..'))
    project_name = os.path.basename(root_dir)
    dest_name = '~/' + project_name

    run('mkdir -p {}'.format(dest_name))

    files = os.listdir(root_dir)
    ignore_files = ['.git', '.vagrant', 'do_not_checkin']
    for filename in files:
        if filename not in ignore_files:
            local_file = os.path.join(root_dir, filename)
            put(local_file, dest_name)


@task
def puppet_apply():
    ''' install puppet modules & runs manifests '''
    project_name = get_project_name()
    project_root = '~/' + project_name
    if not exists(project_root):
        print('Project {} does not exist of host {}'.format(
            project_root, project_name))
    else:
        with cd(project_root):
            run('chmod +x ./puppet/install_puppet_modules.sh')
            sudo('./puppet/install_puppet_modules.sh')
            cmd = 'puppet apply --certname={} puppet/manifests/default.pp'
            sudo(cmd.format('docker-ipy'))


@task
def rsync():
    project_name = get_project_name()
    project_root = '~/'

    root_dir = os.path.normpath(os.path.join(script_dir, '..'))
    exclude_items = ['.git', '.vagrant', 'do_not_checkin']
    rsync_project(
        remote_dir=project_root, local_dir=root_dir, exclude=exclude_items)
