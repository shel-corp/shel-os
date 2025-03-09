#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

shellcheck $(find $SCRIPTDIR -name "*.sh")
