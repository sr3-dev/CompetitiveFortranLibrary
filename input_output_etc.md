
TODO:全体的に殴り書きなのでちゃんと書く.

###使いそうな変数
* integer,integer(4)
* integer(8)
* real(8)
* complex

####文字列
TODO

###条件分岐
`  if (条件) 処理`

`  if (条件) then`  
`    処理`  
`  endif`  

`  if (条件) then`  
`    処理`  
`  else if`   
`    処理`  
`  else`   
`    処理`  
`  endif`  

###繰り返し...do一択
`  do 変数=初期値,終了値`  
`    処理`  
`  enddo`  

`  do 変数=初期値,終了値,増分`  
`    処理`  
`  enddo`  
  増分は2とか-1とか  

###loopを抜ける
* cycle...C言語でいうcontinue  
* exit...C言語でいうbreak  

###入出力
とりあえず標準入出力をまずは...
* 標準入力

   read *, 入力の変数をcomma区切り

   ex) read*, x, y, z
       '*'はあってもなくてもOK
* 標準出力

    ** print "(formatをcomma区切り)", 出力の変数をcomma区切り

    ex) `print '(i0)', x`  
        i0...整数用のフォーマット  
        `print '(f0.5)', x`  
        f0.m...浮動点小数で小数点m桁までを出力(切り上げ/捨てとかどうなってるんでしょう?)  

    ** write(*, '(formatをcomma区切り)') 出力の変数をcomma区切り  

    ex) `write(*, '(i0)') x`

###global変数(moduleを使う)
TODO:ちゃんと書く

###program, subroutine, functionいずれにおいても以下を守っておいた方が良さそう．
  * use module名...global変数使う場合必要
  * implicit none...宣言無しで変数等を使おうとすると怒られるように設定
  * 使用する変数, subroutine, functionを先頭に宣言しておく(順番守らないとコンパイルエラー)

###subroutine,functionに渡された変数,配列の値渡し/参照渡し(?正しい呼び方かどうか不明)設定
  * intent(in/out/inout)で設定
  * in:引数の値を変更する処理を書いてはいけない
    ex)引数にxを与えて，x = x + 1とかするとエラー．
  * out:参照渡しのようになる気がする
  * inout:intent(out)とintent(inout)の違いが分からず...(助けてsuda氏)
  * 配列について.
    ** 引数として，配列aとa[0]は同じ


**その他自由に追記，編集されていくことを期待.**
