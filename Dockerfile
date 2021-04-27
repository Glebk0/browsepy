
FROM python:3-alpine

ARG WORKINGDIR=/opt/browsepy

# Copy application source code
WORKDIR $WORKINGDIR
COPY . .
# Instal dependencies and add non-root user. It's important that nft user must have the same id as jmeter user.
# This is necessary because nft user will hide secrets ce=reated by jmeter user. Otherwise user won't have permssions to modify file.
RUN pip install --no-cache-dir . && \
    adduser --disabled-password --no-create-home --uid 1000 nft && \
    cd / && \
    rm -rf /opt/browsepy

USER nft
ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0 --workers=3"
