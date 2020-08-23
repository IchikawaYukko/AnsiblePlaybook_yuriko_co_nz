# 構築/運用ポリシー
* Docker Volume を使わなくする
    * バックアップ取りにくい
    * sftpしにくい
* バックアップ
    * Docker Volume は /root配下をマウント
    * オブジェクトストレージに投げる
    * フルバックアップはS3に投げる
    * S3はバックアップのみ置く
        * 長期保存が安いから
        * 長期保存分は Glacier Deep Archive で固める
    * Nginxの静的データと、Planet.osmは、引き続きSwiftに置く
        * S3に置くと破産するから
    * LVM スナップショット取得は継続
    * 差分バックアップの自動削除(ハノイの塔アルゴリズム)

* auditd でコマンド実行監査する
* ホストにPHP, Python3入れない
    * remiもsclも使わない
    * 極力ホストを汚さない
        * なんでもDocker化する
* 設定を全てAnsible化して、極力手動sshしないようにする。
