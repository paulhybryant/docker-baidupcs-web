ARG ARCH=docker.io
FROM ${ARCH}/alpine:3.9

LABEL maintainer="paulhybryant@gmail.com"
ENV PORT 8009
ENV BAIDUPCS_GO_CONFIG_DIR=/config

COPY qemu-aarch64-static /usr/bin/
ADD pcs_config.json ${BAIDUPCS_GO_CONFIG_DIR}/

RUN apk add curl &&\
  if [[ "${ARCH}" == "arm64v8" ]]; then binarch="arm64"; else binarch="amd64"; fi && \
  cd /tmp/ && \
  curl -L "https://github.com/liuzhuoling2011/baidupcs-web/releases/download/3.6.7/BaiduPCS-Go-3.6.7-linux-${binarch}.zip" -O && \
  unzip /tmp/BaiduPCS-Go-3.6.7-linux-${binarch}.zip && \
  mv /tmp/BaiduPCS-Go-3.6.7-linux-${binarch}/BaiduPCS-Go /usr/bin/baidupcs

EXPOSE ${PORT}
VOLUME /downloads ${BAIDUPCS_GO_CONFIG_DIR}
CMD /usr/bin/baidupcs web --port ${PORT} --access &> ${BAIDUPCS_GO_CONFIG_DIR}/server.log
