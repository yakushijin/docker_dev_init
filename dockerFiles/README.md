# 単体でビルド、実行する場合

環境変数

```sh
dockerFileName=
tagName=$dockerFileName`date "+%Y%m%d%H%M"`
containerName=${tagName}_run
```

ビルド/実行

```sh

docker build -t $tagName -f $dockerFileName .
imageId=`docker images | grep $tagName |awk '{print $3}'`
docker run -itd -t --name $containerName $imageId
```

削除

```sh
docker stop $containerName && docker rm $containerName
docker rmi $tagName
```
