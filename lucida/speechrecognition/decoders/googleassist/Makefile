.PHONY: all setup clean

all:
	sudo apt-get install python python-pip
	sudo -H pip install --upgrade pip setuptools
	sudo -H pip install --upgrade -r requirements.txt
	./setup.sh

setup:
	./setup.sh

clean:
	rm -rf configuration.py
	rm -rf configuration.pyc
