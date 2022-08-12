#!/bin/bash

export PS4='> '
set -eu
cd "$(mktemp -d ${TMPDIR:-/tmp}/ann-XXXXXXX)"

set -x

virtualenv --python=python3 venv && source venv/bin/activate && pip3 install datalad Nuitka

datalad --version
nuitka3 --version
head -n 1 `which nuitka3`
head -n 1 `which datalad`
python3 --version

echo -e '#!/usr/bin/env python3\nimport datalad.api as dl\ndl.wtf()' > datalad_wtf.py

nuitka3 --standalone --follow-imports --include-package=datalad datalad_wtf.py

pwd

datalad_wtf.dist/datalad_wtf

