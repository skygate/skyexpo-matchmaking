# skyexpo-matchmaking

The matchmaking app for [skyexpo AI 2020](https://skyexpo.ai/).

## Prerequisites

You need:

- `docker` with [version at least](https://docs.docker.com/compose/compose-file/#compose-and-docker-compatibility-matrix) `18.02`
- `docker-compose` with a version at least `1.21` or higher

## Development

### Development with Docker
To start development server inside docker you will need to run:
```
docker-compose build
docker-compose run --rm web python manage.py migrate
docker-compose up
```

### Secret settings
We store secret settings in `config/.env` file.
Before running a project, you will need to copy file `config/.env.template` to `config/.env`:
```
cp ./backend/config/.env.template ./backend/config/.env
```
Then you can set up your secret variables there.

### Documentation
API documentation is available at [localhost:8000/redoc](http://localhost:8000/redoc).


### Staging
Staging is available at: [skyexpo.hal.skygate.io](http://skyexpo.hal.skygate.io/).


### pre-commit hooks
We use [pre-commit hooks](https://pre-commit.com/) to run all checks locally before pushing a commit to CI.
It prevents you from pushing broken code to the repository.

To install `pre-commit hooks` you will need to run:
```
docker-compose run --rm web poetry shell
pre-commit install
```

### Django shell

Thanks to `django-extensions`, `ipython` and `jupyter notebooks` we can easily leverage Python interactive interpreter to debug our code live.

To do so run `./manage.py shell_plus --notebook`. Then copy generated link and paste into browser.


### mypy


Running mypy is required before any commit:

This will eliminate a lot of possible TypeError and other issues. However, this will not make code 100% safe from errors. So, both the testing and review process are still required.


`mypy` is configured via `setup.cfg`. Read the [docs](https://mypy.readthedocs.io/en/latest/) for more information.

We also use django-stubs to type django internals.

There are three common ways to execute mypy:
1. in terminal using docker containers (slower way):

`docker-compose exec web bash -c ": "${PYTHONPATH:=''}"; PYTHONPATH="$PYTHONPATH:$PWD" mypy server"`

2. in terminal locally (much faster):
- `python3.7 -m pip install poetry`
- `poetry install`
- `poetry shell`
- `PYTHONPATH="$PWD" mypy server`

3. If you use PyCharm we highly recommend installing [mypy-PyCharm-plugin](https://github.com/dropbox/mypy-PyCharm-plugin).
You must go through steps in point 2. Then in mypy-PyCharm-plugin go to `Configure plugin` and set `Mypy command` to:

```cd /PycharmProjectsDir/v1-video/backend; PYTHONPATH="$PYTHONPATH:$PWD" /PoetryVirtualEnvsDir/virtualenvs/v1-video-py3.7/bin/mypy server```.

E.g:

```cd /Users/marcinjosinski/PycharmProjects/v1-video/backend; PYTHONPATH="$PYTHONPATH:$PWD" /Users/marcinjosinski/Library/Caches/pypoetry/virtualenvs/v1-video-py3.7/bin/mypy server```


### Testing

We use [mypy](http://mypy-lang.org/) for optional static typing. We run tests with [pytest](https://docs.pytest.org/en/latest/) framework.

We use a lot of `pytest` plugins that enchance our development experience. List of these plugins is available inside `pyproject.toml` file.

To run tests you can use `docker-compose run --rm web pytest .`.


### Linters

This project uses wemake-python-styleguide which is a flake8 based plugin. And it is also the strictest and most opinionated python linter ever.
See [wemake-python-styleguide](https://wemake-python-styleguide.readthedocs.io/en/latest/) docs.


## Production


To run production you will need to to execute:

```
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build
```

### Secret settings in production


We do not store our secret settings inside our source code. All sensible settings are stored in config/.env file, which is not tracked by the version control.

We store them as secret environment variables in our [Drone CI](https://drone.hal.skygate.io/skygate/skyexpo-matchmaking/)
Then we use dump-env to dump variables from both environment and .env file template. Then, this file is copied inside docker image and when this image is built - everything is ready for production.
[Check out dump-env project to read more](https://github.com/sobolevn/dump-env).


## Useful links


- [Sentry](https://sentry.hal.skygate.io/sentry/skyexpo/) - Our error tracking platform. [Read more about Sentry](http://sentry.io/).
- [Drone](https://drone.hal.skygate.io/skygate/skyexpo-matchmaking/) - Our CI/CD automation server.
- [API documentation](http://localhost:8000/redoc)
- [Staging app](http://skyexpo.hal.skygate.io/)
- [Read about our flake8 configuration](https://wemake-python-stylegui.de/en/latest/)
- [Wemake-django-template documentation](https://wemake-django-template.readthedocs.io/en/latest/index.html) - This project uses fork of wemake-django-template.
Here you can get more info about dev-packages and whole development process.


## Authors


* **Paweł Młynarczyk** - [Pawel-Mlynarczyk](https://github.com/Pawel-Mlynarczyk)
* **Marcin Josiński** - [Marcin-Josinski](https://github.com/Marcin-Josinski/)
