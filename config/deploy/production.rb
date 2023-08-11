server '35.72.127.63', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/onomuku/.ssh/id_rsa'
set :rbenv_ruby, '3.0.1'