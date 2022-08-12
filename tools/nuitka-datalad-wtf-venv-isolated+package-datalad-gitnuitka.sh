#!/bin/bash

export PS4='> '
set -eu
cd "$(mktemp -d ${TMPDIR:-/tmp}/ann-XXXXXXX)"

set -x

virtualenv --python=python3 venv && source venv/bin/activate \
  && pip3 install datalad git+https://github.com/Nuitka/Nuitka@develop

datalad --version
nuitka3 --version
head -n 1 `which nuitka3`
head -n 1 `which datalad`
python3 --version

echo -e '#!/usr/bin/env python3\nimport datalad.api as dl\ndl.wtf()' > datalad_wtf.py

python3 -m nuitka --standalone --include-package=datalad '--nofollow-import-to=*.tests' --noinclude-default-mode=error  --noinclude-unittest-mode=nofollow --noinclude-pytest-mode=nofollow --python-flag=-m  datalad_wtf.py

pwd

datalad_wtf.dist/datalad_wtf

