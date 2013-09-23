#できること
    rake channel:programs             # 番組リスト
    rake channel:reserve[program_id]  # 番組予約
    rake channel:scan                 # チャンネルスキャン毎朝実行
    rake channel:search[word]         # 番組検索


#cron設定
wheneverを使用。config/schedule.rbを編集。  


#環境
* Gemfile参照


#DB
* SQLite
* rake db:createを実行
