# docker 開発環境作成用リポジトリ

## 概要

よく使用する環境をまとめたもの。

主に以下サイトの手順で使用する。

> https://

## 使い方

### 前提環境

- git
- bash
- docker
- docker-compose

### clone しプロジェクトディレクトリへ移動

```sh
git clone https://github.com/yakushijin/docker.git && cd docker
```

### docker-compose.yml 準備

「設定文字列」引数に設定する文字列は以下参照

| 設定文字列 | 主な設定内容                                     |
| ---------- | ------------------------------------------------ |
| laravel    | nginx,php,laravel,mysql,redis などのセットアップ |
| django     | nginx,python,django,postgres などのセットアップ  |
| mysql      | 空の mysql を作成                                |
| postgres   | 空の postgres を作成                             |

```sh
sudo ./select.sh 「設定文字列」
```

### ビルド実行

```sh
docker-compose up -d --build
```

### クイックスタート

```sh
make quickSetup
```

### 接続

> http://localhost:8080/

## 汎用コマンド

コンテナ全停止

```sh
docker stop $(docker ps -aq)
```

コンテナ全削除

```sh
docker ps -aq | xargs docker rm
```

イメージ全削除

```sh
docker images -aq | xargs docker rmi
```
