require 'bundler'

Bundler.require

require 'sinatra/flash'

require_relative 'App.rb'

Slim::Engine.set_options pretty: true, sort_attrs: false

run App
