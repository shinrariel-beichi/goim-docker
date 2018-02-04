FROM centos:latest
ENV kafka_ver=2.12
RUN cd /root && \
    mkdir src && \
    mkdir soft && \
	mkdir shell && \
    mkdir logs && \
	mkdir /root/soft/example
ADD shell /root/shell
ADD example /root/soft/example
RUN yum update -y && \
    yum install -y bash sudo psmisc git go wget java-1.8.0-openjdk && \
    yum clean all && \
    cd /root/src && \
    git clone -b test https://github.com/zhouweitong3/goim.git && \
    cd /root/soft && \
    wget http://www-us.apache.org/dist/kafka/1.0.0/kafka_$kafka_ver-1.0.0.tgz && \
    tar -xzf kafka_$kafka_ver-1.0.0.tgz && \
    rm -rf kafka_$kafka_ver-1.0.0.tgz && \
    cd /root/src && \
    go get -u github.com/thinkboy/log4go && \
    go get -u github.com/Terry-Mao/goconf && \
    go get -u github.com/gorilla/websocket && \
    go get -u github.com/Shopify/sarama && \
    go get -u github.com/wvanbergen/kazoo-go && \
    \cp -rf goim /root/go/src/ && \
    mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
    cd /root/go/src/github.com/wvanbergen && \
    git clone https://github.com/wvanbergen/kafka.git && \
    cd /root/go/src/goim/router && \
    go build && \
    mkdir /root/soft/router && \
    mkdir /root/config && \
    \cp -rf router /root/soft/router/ && \
    \cp -rf router-example.conf /root/config/router.conf && \
    ln -s /root/config/router.conf /root/soft/router/router.conf && \
    \cp -rf router-log.xml /root/soft/router/router-log.xml && \
    cd /root/go/src/goim/comet && \
    go build && \
    mkdir /root/soft/comet && \
    \cp -rf comet /root/soft/comet/ && \
    \cp -rf comet-example.conf /root/config/comet.conf && \
    ln -s /root/config/comet.conf /root/soft/comet/comet.conf && \
    \cp -rf comet-log.xml /root/soft/comet/comet-log.xml && \
    cd /root/go/src/goim/logic/job && \
    go build && \
    mkdir /root/soft/job && \
    \cp -rf job /root/soft/job/ && \
    \cp -rf job-example.conf /root/config/job.conf && \
    ln -s /root/config/job.conf /root/soft/job/job.conf && \
    \cp -rf job-log.xml /root/soft/job/job-log.xml && \
    cd /root/go/src/goim/logic && \
    go build && \
    mkdir /root/soft/logic && \
    \cp -rf logic /root/soft/logic/ && \
    \cp -rf logic-example.conf /root/config/logic.conf && \
    ln -s /root/config/logic.conf /root/soft/logic/logic.conf && \
    \cp -rf logic-log.xml /root/soft/logic/logic-log.xml && \
	cd /root/go/src/goim/comet/client && \
	go build && \
	mkdir /root/soft/client && \
	\cp -rf client /root/soft/client/ && \
	\cp -rf client-example.conf /root/config/client.conf && \
	\cp -rf log.xml /root/soft/logic/log.xml && \
	cd /root/go/src/goim && \
	\cp -rf examples /root/soft && \
	\cp -rf benchmark /root/soft && \
	cd /root/soft/examples/javascript && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/benchmark/client && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/benchmark/multi_push && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/benchmark/push && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/benchmark/push_room && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/benchmark/push_rooms && \
	go build main.go && \
	rm -rf main.go && \
	cd /root/soft/example && \
	go build main.go && \
	rm -rf main.go && \
    cd /root/src && \
    yum autoremove -y git go wget && \
    rm -rf /root/src && \
    rm -rf /root/go && \
    chmod -R 777 /root/shell && \
    ln -s /root/shell/start.sh /root/start.sh && \
    ln -s /root/shell/stop.sh /root/stop.sh
VOLUME ["/root/logs","/root/config","/root/soft/example"]
EXPOSE 1999
EXPOSE 2181
EXPOSE 6971
EXPOSE 6972
EXPOSE 7170
EXPOSE 7171
EXPOSE 7172
EXPOSE 7270
EXPOSE 7271
EXPOSE 7371
EXPOSE 7372
EXPOSE 7373
EXPOSE 7374
EXPOSE 8080
EXPOSE 8090
EXPOSE 8092
CMD /bin/bash -c /root/start.sh