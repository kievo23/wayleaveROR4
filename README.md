# Rails4-Managing wayleave for my company

#Rails 4.2.4



#gems installed;
	gem 'bcrypt-ruby', '~> 3.1.5' 

	gem 'bootstrap-sass', '~> 3.3.5'

	gem 'pdf-reader', '~> 1.3.3'

	gem 'will_paginate', '~> 3.0.6'

	gem 'cancan', '~> 1.6.10'

	gem "font-awesome-rails"

	gem 'bootstrap-datepicker-rails', '~> 1.4.0'

#configuration
	default: &default
	  adapter: mysql2
	  encoding: utf8
	  pool: 5
	  username: root
	  password: mypassword
	  socket: /var/run/mysqld/mysqld.sock

	development:
	  <<: *default
	  database: wayleave_development

#Database just run DB migrate

	rake db:migrate
# wayleaveRails4
