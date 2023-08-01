# require File.expand_path(File.dirname(__FILE__) + "/environment")
# # cronを実行する環境変数
# rails_env = ENV['RAILS_ENV'] || :development
# # cronを実行する環境変数をセット
# set :environment, rails_env
# # cronのログの吐き出し場所
# set :output, "#{Rails.root}/log/cron.log"

# require File.expand_path(File.dirname(__FILE__) + '/environment')
# set :path_env, ENV['PATH']
# job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"
# rails_env = ENV['RAILS_ENV'] || :development
# set :output, "#{Rails.root}/log/cron.log"
# set :environment, rails_env

# every 1.minute do
#   runner "Stockpile.notice_on_check"
# end