
from setuptools import setup

setup(
    name="programmer",
    version="0.1",
    packages=[],
    install_requires=[
        "pyserial",
        "xmodem",
    ],
    scripts = [
        "programmer.py"
    ],
)

