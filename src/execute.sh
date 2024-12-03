#!/bin/bash
. lib.sh

## 実行
## hoge-hugaが戻る
substr "hoge" "huga"

## http://checkip.amazonaws.com/にアクセスした結果を表示する。一つ目の引数の文字列も表示する
curl_get "IPはねー"