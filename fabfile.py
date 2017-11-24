from fabric.api import cd, env, run, task


PROJECT_ROOT = '/srv/app/'
REPO = 'https://github.com/pyvec/cz.pycon.org-2017.git'
VENV_DIR = '/srv/venv/'
PYTHON = VENV_DIR + 'bin/python'
PIP = VENV_DIR + 'bin/pip'

env.hosts = []


@task
def production():
    env.hosts = ['app@alpha-node-5.rosti.cz:12768']
    env.environment = 'production'
    env.branch = 'master'


@task
def beta():
    env.hosts = ['app@alpha-node-6.rosti.cz:13128']
    env.environment = 'beta'
    env.branch = 'beta'


def restart():
    run('supervisorctl restart app')


def managepy(payload):
    run('%s manage.py %s' % (PYTHON, payload))


def pip(payload):
    run('%s %s' % (PIP, payload))


@task
def deploy():
    with cd(PROJECT_ROOT):
        run('git pull origin %s' % env.branch)
        pip('install -r requirements.txt')
        managepy('migrate')
        managepy('collectstatic --no-input --link')

    restart()
