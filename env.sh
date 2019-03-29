#!/usr/bin/env bash
export VOLTHA_SCALE_BASE=${PWD}

# load local python virtualenv if exists, otherwise create it
VENVDIR="venv-$(uname -s | tr '[:upper:]' '[:lower:]')"
if [ ! -e "$VENVDIR/.built" ]; then
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "Initializing OS-appropriate virtual env."
    echo "This will take a few minutes."
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    virtualenv ${VENVDIR}
    touch ${VENVDIR}/.built
fi
. ${VENVDIR}/bin/activate

# add top-level voltha dir to pythonpath
export PYTHONPATH=${VOLTHA_SCALE_BASE}/${VENVDIR}/lib/python2.7/site-packages:${PYTHONPATH}:${VOLTHA_SCALE_BASE}
