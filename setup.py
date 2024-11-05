from setuptools import find_packages, setup

setup(
    name="src",
    version="0.1.0",
    description=(
        "Data Versionning template"
        "based on DVC and hydra"
    ),
    author="Your Name",
    author_email="Your Email",
    install_requires=["hydra-core"],
    packages=find_packages(exclude=["tests"]),
)
