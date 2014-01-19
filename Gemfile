source 'http://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.1'
gem "rails3-generators", "~> 1.0.0"
gem 'rake', '~> 10.1'
gem "rails_config"
gem 'rails_admin'

gem 'json',           '~> 1.8.0'
gem 'state_machine', '~> 1.2.0'

#db
gem 'pg'
gem 'unicorn'

#caching
gem 'actionpack-page_caching'

#payment
gem "activemerchant", '~> 1.29.3'#, :lib => 'active_merchant'

#date formating
gem "american_date"
gem 'chronic'

#auth
gem 'authlogic', github: 'binarylogic/authlogic', ref: 'e4b2990d6282f3f7b50249b4f639631aef68b939'
gem 'cancan',         '~> 1.6.8'

#print
gem 'awesome_nested_set', '~> 3.0.0.rc.1'
gem 'awesome_print'
gem 'prawn',        '~> 0.12.0'

#system
gem 'aws-sdk'

#decorate
gem "asset_sync"
gem 'bluecloth',      '~> 2.2.0'
gem 'dynamic_form'
gem 'breadcrumbs_on_rails'
gem 'draper'
gem "friendly_id"

#upload
gem 'paperclip',    '~> 3.0'

#image processing
gem 'rmagick',    :require => 'RMagick'

#workers
gem 'sinatra', require: false
gem 'slim'
gem 'sidekiq'

#scheduler
gem 'whenever', :require => false

#search
gem 'sunspot_solr', '~> 2.0.0'
gem 'sunspot_rails', '~> 2.0.0'
gem 'kaminari'
gem "ransack"
gem 'nokogiri'

#JS libraries
gem "jquery-rails"
gem 'jquery-ui-rails'
gem 'underscore-rails'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'backbone-on-rails'
gem 'jbuilder'

# UI components
gem 'simple_form'
gem 'simple-navigation'
gem 'simple-navigation-bootstrap'
gem 'compass'
gem 'compass-rails',  git: 'git://github.com/Compass/compass-rails.git', branch: 'rails4-hack'
gem 'haml-rails'
gem "font-awesome-rails"
gem 'compass-flexbox'
gem 'bootstrap-sass', '~> 3.0.3.0'
#gem 'bootstrap-editable-rails'
gem 'social-share-button'


group :assets do
  gem 'uglifier',     '>= 1.3.0'
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails'  
end

group :production do  
  gem 'rails_12factor'
end

group :development do
  gem 'letter_opener'
  #gem 'capistrano', '~> 3.0.1', require: false
  #gem 'capistrano-unicorn', require: false  
  gem 'better_errors'
  gem "binding_of_caller", '~> 0.7.2'
  gem 'byebug', :platforms => [:mingw_20, :mri_20, :ruby_20]
  gem 'pry-byebug', :platforms => [:mingw_20, :mri_20, :ruby_20]
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'yard'
  gem 'RedCloth'
  gem 'guard-livereload', require: false
end
group :test, :development do
  gem 'rspec-rails'  
  gem 'rspec'
  gem 'pry-rails'
  gem 'pry-nav'
  
  gem "faker"
  gem "forgery"
  gem 'launchy'
end

group :test do
  gem 'growl'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'

  gem 'database_cleaner'
  gem 'factory_girl', "~> 3.3.0"
  gem 'factory_girl_rails', "~> 3.3.0"
  gem 'mocha', '~> 0.13.3', :require => false
  
  gem 'shoulda-matchers'
  gem 'rspec-rails-mocha'
  gem 'rspec-mocks'
  gem 'rspec-sidekiq'
  gem 'timecop'
  
  gem 'email_spec'
  gem 'simplecov', :require => false

  gem 'capybara', "~> 1.1"#, :git => 'git://github.com/jnicklas/capybara.git'  
  gem 'capybara-screenshot'
end