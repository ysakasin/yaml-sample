# sample.wasm

特定の状況で`YAML.load_file` を利用すると `unreachable` エラーにより停止することを再現したプロジェクトです。

## どういうコードか

`src/i18n.yaml` を `YAML.load_file` を使ってパースするコードです。`sample_pass.rb` は正常終了しますが、`sample_fail.rb`はエラーで停止してしまいます。

## 実行例

```console
$ make
[省略]
$ wasmtime run sample.wasm -- /src/sample_pass.rb
target: /src/sample_pass.rb
/src/i18n.yaml [ok]
$ wasmtime run sample.wasm -- /src/sample_fail.rb
target: /src/sample_fail.rb
/src/i18n.yamlError: failed to run main module `sample.wasm`

Caused by:
    0: failed to invoke command default
    1: wasm trap: wasm `unreachable` instruction executed
       wasm backtrace:
           0: 0x5bd7ab - <unknown>!<wasm function 6990>
           1: 0x603703 - <unknown>!<wasm function 7425>
           2: 0x4872 - <unknown>!<wasm function 38>
           3: 0x6177f8 - <unknown>!<wasm function 7567>
       note: using the `WASMTIME_BACKTRACE_DETAILS=1` environment variable to may show more debugging information

```

## 失敗例と成功例の差分

`sample_pass.rb`はトップレベルで`YAML.load_file`を呼び出していますが、`sample_fail.rb`は`Integer#times`のブロック内で`YAML.load_file`を呼び出しています。

## Author

酒田　シンジ（[@ysakasin](https://github.com/ysakasin)）

