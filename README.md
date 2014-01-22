##Project Overview

Market Street is a Ecommerce/marketplace platform.

Its features aim to provide 
    <ol>
    <li>Easy navigation between stores, categories, and tags</li>
    <li>OAuth login using Facebook and Google</li>
    <li>Listing Integration with major ecommerce channel, such as ebay, amazon, or google</li>
    <li>Payment Integration with Stripe and Paypal</li>
    <li>Shipping Integration with Fedex and UPS</li>
    <li>Social Features such as follow, comments, tagging, and news feed</li>
    <li>Search</li>
    </ol>

Its design principle are 
    <ol>
    <li>It is built firstly for developers to create ecommerce app by modifying or forking it, and secondly for non-technical people by installing. </li>
    <li>Follow Rails best practice</li>
    <li>Test driven with high coverage (90%) and continuous integration</li>
    <li>Entire servers side will be Service/Data APIs, consumed by for both internal and external clients</li>
    <li>Flexible data model around product/sku</li>
    </ol>

Its technology includes
    <ol>
    <li>Ruby on Rails</li>
    <li>Postgres</li>
    <li>Bootstrap/Compass</li>
    <li>Rspec/FactoryGirl</li>
    <li>Jquery/Backbone</li>
    </ol>

##Getting Started
Install RVM with Ruby 2.0.

Run `rake secret` and copy/paste the output as `encryption_key` in `config/config.yml`.

    gem install bundler
    bundle install
    rake db:create:all
    rake db:migrate db:seed
    RAILS_ENV=test rake db:test:prepare

Start the server with `rails server` and direct your web browser to [localhost:3000/admin/overviews]

Write down the username/password (these are only shown once) and follow the directions.

## Environmental Variables
Most users are using Amazon S3 or Heroku.
Thus we have decided to have a setup easy to get your site up and running as quickly as possible
in this production environment.  Hence you should add the following ENV variables:

    FOG_DIRECTORY     => your bucket on AWS
    AWS_ACCESS_KEY_ID => your access key on AWS
    AWS_ACCESS_KEY_ID => your secret key on AWS
    AUTHNET_LOGIN     => if you use authorize.net otherwise change config/settings.yml && config/environments/*.rb
    AUTHNET_PASSWORD  => if you use authorize.net otherwise change config/settings.yml && config/environments/*.rb

On linux:

    export FOG_DIRECTORY=xxxxxxxxxxxxxxx
    export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
    export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    export AUTHNET_LOGIN=xxxxxxxxxxx
    export AUTHNET_PASSWORD=xxxxxxxxxxxxxxx

On Heroku:

    heroku config:add FOG_DIRECTORY=xxxxxxxxxxxxxxx
    heroku config:add AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
    heroku config:add AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    heroku config:add AUTHNET_LOGIN=xxxxxxxxxxx
    heroku config:add AUTHNET_PASSWORD=xxxxxxxxxxxxxxx

    heroku labs:enable user-env-compile -a myapp

This is needed for using sendgrid on heroku(config/initializers/mail.rb):

    heroku config:add SENDGRID_USERNAME=xxxxxxxxxxx
    heroku config:add SENDGRID_PASSWORD=xxxxxxxxxxxxxxx


##ImageMagick and rMagick on OS X 10.8
------------------------------------

If installing rMagick on OS X 10.8 and using Homebrew to install ImageMagick, you will need to symlink across some files or rMagick will not be able to build.

Do the following in the case of a Homebrew installed ImageMagick(and homebrew had issues):

    * cd /usr/local/Cellar/imagemagick/6.8.0-10/lib
    * ln -s libMagick++-Q16.7.dylib   libMagick++.dylib
    * ln -s libMagickCore-Q16.7.dylib libMagickCore.dylib
    * ln -s libMagickWand-Q16.7.dylib libMagickWand.dylib

##YARDOCS

If you would like to read the docs, you can generate them with the following command:

    yardoc --no-private --protected app/models/*.rb

####Payment Gateways

First, create `config/settings.yml` and change the encryption key and paypal/auth.net information.
You can also change `config/settings.yml.example` to `config/settings.yml` until you get your real info.

## Paperclip

Paperclip will throw errors if not configured correctly.
You will need to find out where Imagemagick is installed.
Type: `which identify` in the terminal and set

```ruby
Paperclip.options[:command_path]
```

equal to that path in `config/paperclip.rb`.

Example:

Change:

```ruby
Paperclip.options[:command_path] = "/usr/local/bin"
```

Into:

```ruby
Paperclip.options[:command_path] = "/usr/bin"
```

##Adding Dalli For Cache and the Session Store

While optional, for a speedy site, using memcached is a good idea.

Install memcached.
If you're on a Mac, the easiest way to install Memcached is to use [homebrew](http://mxcl.github.com/homebrew/):

    brew install memcached

    memcached -vv

####To Turn On the Dalli Cookie Store

Remove the cookie store on line one of `config/initializers/session_store.rb`.
In your Gemfile add:

```ruby
gem 'dalli'
```

then:

    bundle install

Finally uncomment the next two lines in `config/initializers/session_store.rb`

```ruby
require 'action_dispatch/middleware/session/dalli_store'
MarketStreet::Application.config.session_store :dalli_store, :key => '_MarketStreet_session_ugrdr6765745ce4vy'
```

####To Turn On the Dalli Cache Store

It is also recommended to change the cache store in config/environments/*.rb

```ruby
config.cache_store = :dalli_store
```

## Adding Solr Search

    brew install solr

Uncomment the following in your gemfile:

```ruby
#gem 'sunspot_solr'
#gem 'sunspot_rails'
```

then:

    bundle install

Start Solr before starting your server:

    rake sunspot:solr:start

Go to the bottom of `product.rb` and uncomment:

```ruby
Product.class_eval
```

Remember to run `rake sunspot:reindex` before doing your search if you already have data in the DB

##TODO:

* more documentation


##SETUP assets on S3 with CORS

Putting assets on S3 can cause issues with FireFox/IE.  You can read about the issue if you search for "S3 & CORS".  Basically FF & IE are keeping things more secure but in the process you are required to do some setup.

I ran into the same thing with assets not being public for IE and FireFox but Chrome seemed to work fine. There is a work around for this though. There is something called a CORS Config that opens up your assets to whatever domains you specify.

Here's how to open up your assets to your website.  (Thanks @DTwigs)

* Click on your bucket.
* Click on the properties button to open the properties tab.
* Expand the "Permissions" accordion and click " Add CORS Configuration"

Now paste this code in there:

    <?xml version="1.0" encoding="UTF-8"?>
    <CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Content-*</AllowedHeader>
    <AllowedHeader>Host</AllowedHeader>
    </CORSRule>
    </CORSConfiguration>


##Author

Market Street was created by Alex C.