# Makefile to manage Python dependencies using pip-compile and pip
all: check

# The input requirements.in file
REQUIREMENTS_IN = requirements-dev.in

# The generated requirements.txt file
REQUIREMENTS_TXT = requirements-dev.txt

.PHONY: compile install push sort format type check fix-imports publish clean

sort:
	isort .

format:
	black .

type:
	mypy .


fix-imports:
	autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place . --exclude=__init__.py

check: sort format type fix-imports

compile: $(REQUIREMENTS_TXT)

install: compile
	pip install -r $(REQUIREMENTS_TXT)

$(REQUIREMENTS_TXT): $(REQUIREMENTS_IN)
	pip-compile $(REQUIREMENTS_IN) -o $(REQUIREMENTS_TXT)

push: check
	@if [ -z "$(message)" ]; then \
		echo "Please specify a commit message: make commit message='Your message here'"; \
		exit 1; \
	fi
	git add .
	git commit -m "$(message)"
	git push


clean:
	rm -rf build dist .egg requests.egg-info *.egg-info
