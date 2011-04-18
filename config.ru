require 'sinatra'
require 'erb'
require 'json'
require 'csv'
require 'mongoid'

require File.expand_path('app')
require File.expand_path('config/init')
require File.expand_path('lib/route')
require File.expand_path('lib/stop')
require File.expand_path('lib/stop_time')
require File.expand_path('lib/trip')

run Sinatra::Application