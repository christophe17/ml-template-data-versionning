FROM python:3.11-slim


ENV DEBIAN_FRONTEND=noninteractive

ENV HOME=/home/${USER_NAME}
ENV VIRTUAL_ENV=/home/${USER_NAME}/venv
ENV PATH="/usr/local/gcloud/google-cloud-sdk/bin:${HOME}/.local/bin:${VIRTUAL_ENV}/bin:${PATH}"


# --------------------------------- packages -------------------------------- #

RUN apt-get -qq update \
    && apt-get -qq -y install vim gcc curl git build-essential libb64-dev software-properties-common \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -qq -y clean


# ------------------------------ python checks ------------------------------ #

ENV PYTHONUNBUFFERED=1
RUN python3 --version
RUN pip3 --version


# --------------------------------- gcloud -------------------------------- #

RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-426.0.0-linux-x86_64.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh --usage-reporting false --command-completion true --bash-completion true --path-update true --quiet


# --------------------------------- user -------------------------------- #

ARG USER_ID
ARG USER_NAME
RUN addgroup --system --gid ${USER_ID} ${USER_NAME} \
    && useradd --system -m --no-log-init --home-dir ${HOME} --uid ${USER_ID} --gid ${USER_NAME} --groups ${USER_NAME} ${USER_NAME}

RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}
RUN mkdir -p /app && chown -R ${USER_NAME}:${USER_NAME} /app /tmp
ENV PYTHONPATH="/app"

USER ${USER_NAME}


# ------------------------------- requirements ------------------------------ #

WORKDIR /app

USER root
RUN mkdir /package
COPY . /package
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install \
        --no-cache-dir \
        --root-user-action ignore \
        -r /package/requirements.txt && \
    python3 -m pip install --no-cache-dir --root-user-action ignore /package


# --------------------------------- git -------------------------------- #

ARG GIT_USER_EMAIL
ARG GIT_USER_NAME
RUN git config --global user.email ${GIT_USER_EMAIL} \
    && git config --global user.name ${GIT_USER_NAME}

    
    
# --------------------------------- startup -------------------------------- #

USER ${USER_NAME}

CMD ["tail", "-f", "/dev/null"]
