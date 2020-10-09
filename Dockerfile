ARG ARCH=docker.io
FROM ${ARCH}/alpine:3.9
ARG ARCH

LABEL maintainer="paulhybryant@gmail.com"

COPY hooks/qemu-aarch64-static /usr/bin/

RUN apk add curl && \
  if [[ "${ARCH}" == "arm64v8" ]]; then binarch="arm64"; else binarch="amd64"; fi && \
  cd /tmp/ && \
  baidupcs_version="3.7.3" && \
  curl -L "https://github.com/zxlhhyccc/BaiduPCS-Go-1/releases/download/v${baidupcs_version}/BaiduPCS-Go-v${baidupcs_version}-linux-${binarch}.zip" -O && \
  unzip /tmp/BaiduPCS-Go-v${baidupcs_version}-linux-${binarch}.zip && \
  mv /tmp/BaiduPCS-Go-v${baidupcs_version}-linux-${binarch}/BaiduPCS-Go /usr/bin/baidupcs

EXPOSE 5299
VOLUME /downloads /config
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
