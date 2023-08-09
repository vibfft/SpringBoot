FROM azul/zulu-openjdk-alpine:17 as BUILDER
ARG VERSION=0.0.1
WORKDIR /build/
COPY . /build/
COPY gradle /build/gradle

RUN ./gradlew clean
RUN ./gradlew build

FROM azul/zulu-openjdk-alpine:17-jre
WORKDIR /app/

COPY --from=BUILDER /build/ /app/
# COPY --from=BUILDER /build/libs/SpringBoot-${VERSION}-SNAPSHOT.jar /app/application.jar
# The above command somehow doesn't work...

ENTRYPOINT java -jar build/libs/SpringBoot-0.0.1-SNAPSHOT.jar
# docker build -t springboot . // first tag as springboot
# docker run --rm -p 8000:8080 springboot //and then run it at outside port of 8000
