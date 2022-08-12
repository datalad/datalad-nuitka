#!/bin/bash

export PS4='> '
set -eu
cd "$(mktemp -d ${TMPDIR:-/tmp}/ann-XXXXXXX)"

set -x

nuitka3 --version
head -n 1 `which nuitka3`
python3 --version

virtualenv --python=python3 --system-site-packages venv && source venv/bin/activate && pip3 install datalad

echo -e '#!/usr/bin/env python3\nimport datalad.api as dl\ndl.wtf()' > datalad_wtf.py

nuitka3 --standalone --follow-imports datalad_wtf.py

pwd

datalad_wtf.dist/datalad_wtf

