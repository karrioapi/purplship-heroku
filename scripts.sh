#!/usr/bin/env bash

# Python virtual environment helpers

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_DIR="${PWD##*/}"
ENV_DIR=".venv"


export DEBUG_MODE=False
export ALLOWED_HOSTS=*
export USE_HTTPS=True
export SECRET_KEY="n*s-ex6@ex_r1i%bk=3jd)p+lsick5bi*90!mbk7rc3iy_op1r"

export EMAIL_HOST="localhost"
export EMAIL_PORT=1025

export DATABASE_HOST="0.0.0.0"
export DATABASE_PORT=5432
export DATABASE_NAME=db
export DATABASE_ENGINE=postgresql_psycopg2
export DATABASE_USERNAME=postgres
export DATABASE_PASSWORD=postgres

export DJANGO_SETTINGS_MODULE=app.settings

deactivate_env() {
  if command -v deactivate &> /dev/null
  then
    deactivate
  fi
}

activate_env() {
  if [[ -d "${ROOT:?}/$ENV_DIR/$BASE_DIR/bin" ]]; then
    echo "Activate $BASE_DIR"
    # shellcheck source=src/script.sh
    source "${ROOT:?}/$ENV_DIR/$BASE_DIR/bin/activate"
  fi
}

create_env() {
    echo "create $BASE_DIR Python3 env"
    deactivate_env
    rm -rf "${ROOT:?}/$ENV_DIR" || true
    mkdir -p "${ROOT:?}/$ENV_DIR"
    python3 -m venv "${ROOT:?}/$ENV_DIR/$BASE_DIR" &&
    activate_env &&
    pip install --upgrade pip wheel
}

init() {
    create_env && pip install -r "${ROOT:?}/requirements.txt"
}


alias env:new=create_env
alias env:on=activate_env
alias env:off=deactivate_env
alias env:reset=init


# Try to activate the environment if existent
activate_env
