from setuptools import find_packages, setup

with open("README.md", "r", encoding="utf-8") as f:
    long_description = f.read()


with open("requirements.txt", "r", encoding="utf-8") as f:
    requirements = f.read().splitlines()

version = "0.0.6"

setup(
    name="vizchain",
    version=version,
    install_requires=requirements,
    packages=find_packages(),
    description="A tiny language interpreter",
    long_description=long_description,
    long_description_content_type="text/markdown",
)
