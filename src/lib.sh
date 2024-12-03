#!/bin/bash
## 引数は２つ必要。引数をハイフン付きで結合をしてくれる関数
substr() {
    if [[ $# -ne 2 ]]; then
        echo "引数が足りません" >&2
        return 1
    fi

    str_1=${1}
    str_2=${2}

    echo "${str_1}-${str_2}"
}

## CURLで対象のサイトにアクセスして表示する。
curl_get() {
    if [[ $# -ne 1 ]]; then
        echo "引数が足りません" >&2
        return 1
    fi

    url="http://checkip.amazonaws.com/"

    echo ${1}
    curl -s -X GET ${url}
}