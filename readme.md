### 作成と実行
docker compose up

### 仕組み
srcディレクトリが/working/にバインドされます。
で、その下が実行される。

### 初期化は以下
shellspec --init

で初期プロジェクトができる。

### ファイルの構成
lib.sh 今回テスト対象のスクリプトファイル。関数をたくさん実行するやつ
execute.sh 実行する本体。テストではなく、lib.shを使って実行する
specディレクトリ　テストコードが入っている

### 実行
docker compose run --rm shellspec_container shellspec -s bash

### 試験
lib.shのテストをする

テストは以下
【その１】substrのテスト
　引数不足の異常系テスト
　正常系テスト

【その２】curl_getのテスト
　引数不足の異常系テスト
　mockを利用した正常系テスト


上記はlib_spec.shに記載してあります

### 大事なこと　コードの基本
これが、１テストのコードになります。

```
Describe '失敗テスト'
It '失敗 パラメータ不足 一個しかパラメータがないよ'
    When call substr "hogehoge" →　これがコマンドの指定
    The error should include "引数が足りません" →　これが、想定の値の記載
    The status should be failure　→　これが想定の終了コードの記載
    End
End
```

なので、上記は
substr "hogehoge" を実行した結果
標準エラーに「引数が足りません」と表示されている
終了コードは「正常以外のエラー」

というコードになります。


### 大事なこと　mock
モックです。モックは「上書きしてくれるやつ」です。
以下のコードだと、curlコマンドをmockにしています。
curlなので、本当は対象のサイトに実際にアクセスして結果を表示するのですが、mockを利用すると
「実際にcurlでアクセスするわけではない。アクセスしたことにした結果を戻す」ことができます。


```
It '成功パターン'
    Mock curl ## mock。curlコマンドをmockにする。
    echo -e '122.122.122.122' ## ここにmockのスクリプトを書く。ここでは、IPアドレスを戻すようにしている
    End
    When call curl_get "これは！"
    The output should include "これは！"
    The output should include "122.122.122.122"
    The status should be success
End
```