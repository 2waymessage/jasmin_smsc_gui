FROM python:3.11-slim-bullseye
RUN python3 -m pip install --upgrade py4web
RUN py4web setup -Y apps
RUN py4web set_password --password admin

COPY . /apps/jasmin-gui/
CMD ["py4web", "run", "apps"]