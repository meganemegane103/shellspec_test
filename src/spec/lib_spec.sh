#!/bin/bash
# https://qiita.com/opengl-8080/items/71a4b0c0e6fa9aed771d
# 改行コードがLFでないとエラーが出ることがあるので注意
Describe 'lib.sh substrのテスト'
  Include lib.sh
  Describe '失敗テスト'
    ## これは、パラメータが足りずに「引数が足りません」と表示されて、失敗しているかテスト
    It '失敗 パラメータ不足'
      When call substr
      The error should include "引数が足りません"
      The status should be failure
    End
  End
  Describe '失敗テスト'
    It '失敗 パラメータ不足 一個しかパラメータがないよ'
      When call substr "hogehoge"
      The error should include "引数が足りません"
      The status should be failure
    End
  End
    ## これは、実行してハイフン付きで文字列を結合しているかテスト
    Describe '成功テスト'
    It '成功'
      When call substr "hogehoge" "mogemoge"
      The output should include "hogehoge-mogemoge"
      The status should be success
    End
  End
End

Describe 'lib.sh curl_getのテスト'
  Include lib.sh

  Describe '失敗テスト'
    ## これは、パラメータが足りずに「引数が足りません」と表示されて、失敗しているかテスト
    It '失敗 パラメータ不足'
      When call curl_get
      The error should include "引数が足りません"
      The status should be failure
    End
    ## mockを利用してます。
    It '成功パターン'
      Mock curl ## mock。curlコマンドをmockにする。
        echo -e '122.122.122.122' ## ここにmockのスクリプトを書く。ここでは、IPアドレスを戻すようにしている
      End
      When call curl_get "これは！"
      The output should include "これは！"
      The output should include "122.122.122.122"
      The status should be success
    End
  End
End