python-script-template
---

An easy to use template of Python script, include basic CI/CD settings.

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Imports: isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat&labelColor=ef8336)](https://pycqa.github.io/isort/)
[![Code style: flake8](https://img.shields.io/badge/code%20style-flake8-brightgreen)](https://github.com/PyCQA/flake8)
[![linting: pylint](https://img.shields.io/badge/linting-pylint-yellowgreen)](https://github.com/PyCQA/pylint)
[![Checked with mypy](https://img.shields.io/badge/mypy-checked-blue)](http://mypy-lang.org/)
[![security: bandit](https://img.shields.io/badge/security-bandit-yellow.svg)](https://github.com/PyCQA/bandit)
[![Ochrona](https://img.shields.io/badge/secured_by-ochrona-blue)](https://ochrona.dev)
<!-- Dynamic Badges -->
[![codecov](https://codecov.io/gh/ttw225-template/python-script/branch/main/graph/badge.svg?token=E1DMSXTI77)](https://codecov.io/gh/ttw225-template/python-script)
[![Build](https://github.com/ttw225-template/python-script/actions/workflows/build.yml/badge.svg)](https://github.com/ttw225-template/python-script/actions/workflows/build.yml)
[![CI](https://github.com/ttw225-template/python-script/actions/workflows/ci.yml/badge.svg)](https://github.com/ttw225-template/python-script/actions/workflows/ci.yml)
---

# Development
## Prerequisite

| Package Name | Version |
| :---: | :---: |
| Python | 3.10.8 |
| pipenv | 2022.9.24 |

## Environment setup

- Install dependencies
```sh
make dev
```

## Formatting
### Code formatter

This template uses the following automatic format tool:
- [black](https://github.com/psf/black)
- [isort](https://github.com/PyCQA/isort)

```sh
make reformat
```

### Linting

This template uses the following linting tool:
- [flake8](https://github.com/PyCQA/flake8)
- [pylint](https://github.com/PyCQA/pylint)
- [mypy](http://mypy-lang.org/)

```sh
make lint
```

## Analysis

This template uses the following security analysis tool:
- [bandit](https://github.com/PyCQA/bandit)
- [ochrona](https://ochrona.dev)

```sh
make analysis
```

## Test

This template uses the following testing tool:
- [pytest](https://github.com/pytest-dev/pytest)
- [pytest-cov](https://github.com/pytest-dev/pytest-cov)(pytest plugin: produces coverage report)
- [hypothesis](https://github.com/HypothesisWorks/hypothesis)(property-based testing tool)

```sh
make test
```

# Deploy
## Prerequisite

| Package Name | Version |
| :---: | :---: |
| Docker | 20.10.21 |
| docker-compose | v2.12.2 |

## Build image

```sh
docker-compose build
```

## Run container

```sh
docker-compose up
```

# Github workflows
## CI

[ci.yml](.github/workflows/ci.yml)

Trigger on: push and pull-request

Jobs:
1. Lint
    - Run linting tools: `flake8`, `pylint`, `mypy`
2. Analysis
    - Run security analysis tools: `bandit`, `ochrona`
3. tests
    - Run `pytest`
    - Upload testing coverage report to [Codecov](https://codecov.io/gh/ttw225-template/python-script)

## Build

[build.yml](.github/workflows/build.yml)

Trigger on: push and Bump version complete

Jobs:
1. build-and-push-image
    - Build a test image and check the container can start without errors
    - Build and push image with `test` tag
    - If branch `develop`: build and push image with `dev` tag
    - If branch `main`: build and push image with `latest` and latest git tag

## Bump and release version

[bumpversion.yml](.github/workflows/bumpversion.yml)

Trigger on: push to main branch

Tools: [python commitizen tool](https://github.com/commitizen-tools/commitizen)

Jobs:
1. bump-version
    - Create bump and changelog
    - Release latest version
