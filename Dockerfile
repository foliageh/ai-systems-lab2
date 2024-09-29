FROM debian
RUN apt-get -y update
RUN apt-get -y install swi-prolog
RUN apt-get -y install swi-prolog-java

WORKDIR /app
COPY ./target/ai-systems-lab2-1.0-jar-with-dependencies.jar .
COPY ./gta_sa_knowledge_base.pl .

USER 1001
EXPOSE 8080

CMD ["unset LD_PRELOAD"]
CMD ["export SWI_HOME_DIR=/usr/lib/swi-prolog/"]
CMD ["export LD_LIBRARY_PATH=/usr/lib/swi-prolog/lib/x86_64-linux/:$LD_LIBRARY_PATH"]
CMD ["export CLASSPATH=/usr/lib/swi-prolog/lib/jpl.jar:$CLASSPATH"]
CMD ["export LD_PRELOAD=/usr/local/lib/libswipl.so"]

CMD ["java", "-jar", "ai-systems-lab2-1.0-jar-with-dependencies.jar"]
