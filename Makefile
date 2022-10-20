PKG=project

.PHONY: all clean version init flake8 pylint lint test coverage

init: clean
	@echo Install Environment
	pipenv --python 3.10
	pipenv install

dev: init
	@echo Install Develop Environment
	pipenv install --dev

run:
	@echo Run Project
	pipenv run python3 -m $(PKG).app

reformat: isort black

isort:
	@echo [Reformat] Sort Imports
	pipenv run isort $(PKG)/

black:
	@echo [Reformat] Code Format
	pipenv run black $(PKG)

analysis: bandit ochrona

lint: flake8 pylint mypy

flake8:
	@echo [Linter] Style Check
	pipenv run flake8

pylint:
	@echo [Linter] Style Check
	pipenv run pylint $(PKG) --rcfile=setup.cfg

mypy:
	@echo [Linter] Type Check
	pipenv run mypy $(PKG)/

bandit:
	@echo [Analysis] Static Analysis
	pipenv run bandit -r ${PKG}/ -x ${PKG}/tests/

ochrona:
	@echo [Analysis] Software Composition Analysis
	pipenv run ochrona

test:
	pipenv run python3 -m pytest -vv --cov-report=term-missing --cov=${PKG} ${PKG}/tests/

ci-bundle: reformat lint analysis test

build:
	docker-compose build

clean-build:
	rm -rf build/
	rm -rf dist/
	rm -rf .eggs/
	find . -type d -name '*.egg-info' -delete
	find . -type f -name '*.egg' -delete

clean-pyc:
	find . -type f -name '*.pyc' -delete
	find . -type f -name '*.pyo' -delete
	find . -type f -name '*~' -delete
	find . -type d -name '__pycache__' -delete

clean-test:
	rm -rf .pytest_cache
	rm -f .coverage

clean-third-party:
	rm -rf .mypy_cache
	rm -rf db_cache.sqlite

clean: clean-build clean-pyc clean-test clean-third-party
