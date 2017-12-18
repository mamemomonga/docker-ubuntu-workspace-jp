# Ubuntu Xenial 汎用実行環境

* いくつかのツールを導入したUbuntu Xenial Dockerコンテナを構築します。
* 時計はJST, APTミラーは理化学研究所になっています。
* docker-compose up したときに.envで設定したUID, GIDのubuntuユーザを作成します。
* ubuntuフォルダを /home/ubuntu としてマウントします。
* 何もしないサーバとして sleep infinity を起動します。

# 必要なもの

* docker
* docker-compose

# 使い方

	$ git clone https://github.com/mamemomonga/docker-ubuntu-workspace-jp.git
	$ cd docker-ubuntu-workspace-jp

### Linux, macOS

* 現在のUID,GIDをubuntuユーザ・グループとして設定
* マウントポイントを./ubuntuとする

bash

	$ echo "UBUNTU_GID=$(id -g)" >  .env
	$ echo "UBUNTU_UID=$(id -u)" >> .env
	$ echo "UBUNTU_HOME=./ubuntu" >> .env

## ビルドと起動

	$ docker-compose up -d

## ubuntuユーザでログイン

	$ docker-compose exec work login -f ubuntu

## rootユーザでログイン

	$ docker-compose exec work login -f root

## sudoを使えばパスワードなしでubuntuユーザからrootになれます

## tmux起動

	$ docker-compose exec -u ubuntu work sh -c 'cd && exec tmux'

## 終了

	$ docker-compose down

