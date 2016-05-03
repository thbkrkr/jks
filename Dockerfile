FROM jenkins

COPY plugins/plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d