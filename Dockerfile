FROM buildpack-deps:xenial

# ミラー変更・パッケージ導入
RUN set -xe && \
    sed -i.bak 's#http://archive.ubuntu.com/ubuntu#http://ftp.riken.go.jp/Linux/ubuntu#g' /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    	locales \
		vim \
		tmux \
		sudo \
		gosu \
		inetutils-ping \
		dnsutils \
		awscli \
		jq \
		groff \
		less \
		dialog && \
	rm -rf /var/lib/apt/lists

# JSTに変更・en_US.UTF-8に変更
RUN set -xe && \
	sed -i '/^# en_US.UTF-8 UTF-8/s/^# //' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo 'Asia/Tokyo' > /etc/timezone

ENV LC_ALL en_US.UTF-8

# ubuntuユーザのデフォルトGID,UID
ENV UBUNTU_GID 1000
ENV UBUNTU_UID 1000

ADD assets/ /
ENTRYPOINT ["/entrypoint.sh"]

