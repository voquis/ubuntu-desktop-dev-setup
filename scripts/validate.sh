#!/bin/bash
set -euo pipefail

pip install ansible ansible-lint

ansible-galaxy collection install community.general

ansible-lint -p playbook.yaml -x no-changed-when
