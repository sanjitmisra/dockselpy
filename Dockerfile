FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    nano \
    python3 python3-pip \
    libgconf2-4 libnss3-1d libxss1 \
    fonts-liberation libappindicator1 xdg-utils \
    software-properties-common \
    curl unzip wget \
    xvfb


# install geckodriver and firefox

RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver

RUN add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
RUN apt-get update && apt-get install -y firefox


# install chromedriver and google-chrome

RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/bin
RUN chmod +x /usr/bin/chromedriver

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb
RUN apt-get install -y -f


# install phantomjs

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar -jxf phantomjs-2.1.1-linux-x86_64.tar.bz2 && cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs


RUN pip3 install selenium
RUN pip3 install pyvirtualdisplay


ENV APP_HOME /usr/src/app
WORKDIR /$APP_HOME

COPY . $APP_HOME/

CMD python3 BaseTest.py
#CMD tail -f /dev/null
