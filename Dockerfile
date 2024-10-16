FROM python:3.11-slim-bullseye
ARG NON_ROOT_USER=py4web
ARG APPS_DIR=/apps
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    telnet \
    ngrep \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*
RUN groupadd -r ${NON_ROOT_USER} && useradd -r -g ${NON_ROOT_USER} ${NON_ROOT_USER}
RUN mkdir ${APPS_DIR}
RUN python3 -m pip install --upgrade py4web==1.20220412.1

RUN py4web setup -Y apps
RUN py4web set_password --password admin

COPY . /apps/jasmin-gui/
RUN chown -R ${NON_ROOT_USER}:${NON_ROOT_USER} ${APPS_DIR}
USER ${NON_ROOT_USER}
EXPOSE 8000
CMD ["py4web", "run", "apps"]