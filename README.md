# tenko

10分ごとに ping するくん

自宅の回線が不安定だったので、
いつ生きてていつ死んでるかトラッキングするために書いた

外形監視とかもできそう

## 使い方

./tenko.sh [url or ipaddr]

## これでもよくないか

```sh
ping -i 600 example.com | xargs -I\$ date '+%Y/%m/%d %H:%M:%S $'
```

……確かに？


## LICENSE

MIT

