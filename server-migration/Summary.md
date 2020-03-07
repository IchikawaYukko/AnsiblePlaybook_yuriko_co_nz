# 目的
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

# 概要
* Docker Volume を使わなくする
    * バックアップ取りにくい
    * sftpしにくい
* バックアップ
    * Docker Volume は /root配下をマウント
    * S3に投げる
        * /root
        * /etc
    * S3はバックアップのみ置く
        * 長期保存が安いから
        * 長期保存分は Glacier Deep Archive で固める
    * Nginxの静的データと、Planet.osmは、引き続きSwiftに置く
        * S3に置くと破産するから
    * / のバックアップはやめる
    * LVM スナップショット取得は継続
    * 差分バックアップの自動削除

* auditd でコマンド実行監査する
* ログイン通知をGoで作ってPHPを置き換える
* ホストにPHP, Python3入れない
    * remiもsclも使わない
    * 極力ホストを汚さない
        * なんでもDocker化する
* 設定を全てAnsible化して、極力手動sshしないようにする。