FROM istepanov/syncthing
MAINTAINER Robin Grönberg <robingronberg@gmail.com>

ENV GOROOT=/usr/lib/go \
    GOPATH=/go \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin

RUN apk add --no-cache --virtual .build-dependencies git go && \
    mkdir -p src/github.com/syncthing && \
    git clone https://github.com/syncthing/syncthing-inotify.git /go/src/github.com/syncthing/syncthing-inotify  && \
    cd /go/src/github.com/syncthing/syncthing-inotify  && \
    go get  && \
    go build  && \
    mv syncthing-inotify /go/bin/syncthing-inotify && \

    # cleanup
    rm -rf /go/pkg && \
    rm -rf /go/src && \
    apk del .build-dependencies

#--------------------------------------
# run
#--------------------------------------

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]