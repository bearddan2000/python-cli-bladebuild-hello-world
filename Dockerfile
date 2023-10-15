FROM ubuntu

RUN apt update \
    && apt install -y git g++ wget python3

RUN ln -s /bin/python3 /bin/python

RUN wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip \
    && gunzip /usr/local/bin/ninja.gz \
    && chmod a+x /usr/local/bin/ninja

WORKDIR /workspace

RUN  git clone https://github.com/chen3feng/blade-build.git

WORKDIR /workspace/blade-build

RUN ./install \
    && . /root/.profile

RUN ln -s /workspace/blade-build/blade /bin/blade

WORKDIR /code

COPY bin .

ENTRYPOINT ["blade"]

CMD ["run", ":BladeApp"]