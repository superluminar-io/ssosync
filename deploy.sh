#!/bin/bash -eu

sam deploy --config-file ./samconfig.secret.toml --confirm-changeset
