#!/bin/bash
set -e
virtualenv venv
source venv/bin/activate
pip install --upgrade distribute
pip install --upgrade pip
pip install -r python_requirements.txt
deactivate
set +e
