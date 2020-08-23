# サーバ移転2019
* 旧ConoHa 1台、新ConoHa 1台、AWS 1台借りてるサーバを統合して、サーバ費用を削減する。
    * (丁度、新ConoHaの格安料金プランが発表されたため)
* S3 Glacier を活用して、バックアップ保管コストを削減する
* 設定値をAnsible化して、保守性を高める
    * 設定が各サーババラバラで、カオスなのを何とかする

## 現環境
* 旧ConoHa 1GB / HDD 100GB VPS 1台
* 新ConoHa 512MB / 20GB VPS 1台
* AWS t2.micro 30GB EC2 1台(無料枠)

## 新環境
* 新ConoHa 1GB / 100GB VPS 1台
* AWS t2.micro 30GB EC2 1台(無料枠)

新旧ConoHa VPSを統合する。EC2は、そのまま。

# 手順概略
1. [x] 新環境にCentOS 7を入れる
    1. ファイルシステムはLVM + ext4にする
1. [x] 新環境の基本準備
    1. SELinux
    1. SSHポート変更
    1. ユーザ作成
    1. ファイアウォール基本ルール
1. [x] 新環境にDocker環境を作る
1. [x] 必要なdockerイメージをpull
1. [x] 旧環境から docker-compose.yml と、各種データ、DBダンプ一式をコピー
1. [x] Dockerコンテナ起動
1. [x] バックアップ設定を入れる
1. [x] DNSの向け先変更
    1. DNSはConoHaを引き続き使用。レジストラも移管しない。
1. [x] 動作確認
1. [x] ログイン通知をGoで作ってPHPを置き換える(ホストにPHPを入れないため)
1. [x] 旧環境シャットダウン&削除
