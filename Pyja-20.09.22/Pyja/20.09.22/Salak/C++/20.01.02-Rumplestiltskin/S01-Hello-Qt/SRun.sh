#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/SCommon.sh"

"$SC_ECU_PN/SToa" "$@"
