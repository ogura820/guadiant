require File.expand_path(File.dirname(__FILE__) + '/environment')
set :path_env, ENV['PATH']
job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"
rails_env = ENV['RAILS_ENV'] || :development
set :output, "#{Rails.root}/log/cron.log"
set :environment, rails_env

every 1.day, at: '6:20 am' do
  runner "Stockpile.notice_on_check"
end

# every 1.minute do
#   runner "Stockpile.notice_on_check"
# end


every '0 0 1 1 *' do
  runner 'Family.increace_age'
end