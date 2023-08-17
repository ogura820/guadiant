Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( application.css )
Rails.application.config.assets.precompile += %w( *.js *.css *.jpg *.jpeg *.png *.gif *.svg *.eot *.woff *.ttf )
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
