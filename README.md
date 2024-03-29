# BRIDESAP
## https://www.bridesap.com/

## サービス概要
花嫁たちが  
華奢に見える姿勢で前撮り・結婚式に臨むための  
姿勢練習サービスです  

## メインのターゲットユーザー
これから前撮り・結婚式を行う予定があるが、自分の姿勢に自信がない女性

## ユーザーが抱える課題
幸せな瞬間を華奢な自分で思い出に残したいが、写真うつりに自信がない。

## 解決方法
華奢に見える姿勢のポイントを提示  
（肩をできる限り落として首を長く見せた状態のまま、肩甲骨を寄せる）  
まず何も意識しない（ポイントを知らない）状態で撮影を行い、  
その後、華奢に見えるポイントを意識して再度撮影。  
ポイントを知る前の何も意識しなかった自分と、ポイント知った後の自分の肩幅を比較・判定する。

## 実装予定の機能
・登録ユーザー  
　・華奢に見えるポイントを知った後、自分がどれだけ華奢になれたかを判定できる  
　・写真を保存できる（練習の記録として自分の姿勢を確認できる）  
　・前撮り・結婚式の日程を保存、カウントダウン  
・管理ユーザー  
　・登録ユーザー一覧、詳細、作成、編集、削除
　・登録ユーザーが撮影した写真一覧、詳細、編集、削除

## なぜこのサービスを作りたいのか？
ふとした瞬間を写真に撮られると大体姿勢が悪く、写真うつりに自信がないので、  
前撮りをするにあたり、Instagramでフォローしているブライダルモデルが紹介していた綺麗に見える姿勢のコツを    
真似してみたら結構難しかった（しんどかった）ので練習できるアプリを作りたいと思った。  
人生の大切な瞬間に自信を持って臨める人を増やしたい。

## 使用技術
### フロントエンド
Vue.js 2.6.11  
　主要npmパッケージ  
　└vuetify  
　└vue-router  
　└axios  
　└vuex  
　└vee-validate  
Tensorflow.js  

### バックエンド
Ruby 3.1.2  
Rails 6.1.6  
　主要Gem  
　└sorcery  
　└meta-tags  
　└rails-admin  
　└cancancan

### インフラ
Heroku  
PostgreSQL  
Amazon S3  

## 画面遷移図
https://www.figma.com/file/46hEdO7OunFmHi1LziUFsf/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1

## ER図
https://drive.google.com/file/d/1bVWb4fDNwepOhQ-U5EdV8svQF7_XgwRd/view?usp=sharing
