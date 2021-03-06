# Makefile for PYFlite Python Module.
#
# Source:: https://github.com/ampledata/pyflite
# Author:: Greg Albrecht <gba@orionlabs.io>
# Copyright:: Copyright 2017 Orion Labs, Inc.
# License:: Apache License, Version 2.0
#


.DEFAULT_GOAL := all


all: install_requirements develop

develop:
	python setup.py develop

install_requirements:
	pip install -r requirements.txt

install:
	python setup.py install

uninstall:
	pip uninstall -y pyflite

clean:
	@rm -rf *.egg* build dist *.py[oc] */*.py[co] cover doctest_pypi.cfg \
		nosetests.xml pylint.log output.xml flake8.log tests.log \
		test-result.xml htmlcov fab.log .coverage

publish:
	python setup.py register sdist upload

nosetests:
	python setup.py nosetests

pep8: install_requirements
	flake8 --max-complexity 12 --exit-zero pyflite/*.py tests/*.py

lint: install_requirements
	pylint --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" \
		-r n pyflite/*.py tests/*.py || exit 0

test: lint pep8 nosetests
