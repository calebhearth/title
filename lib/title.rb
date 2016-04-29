app = File.expand_path('../../app', __FILE__)
$LOAD_PATH.unshift(app) unless $LOAD_PATH.include?(app)

require 'title/version'
require 'rails/engine'
require 'title/engine'
require 'helpers/title/title_helper'

module Title
  # Your code goes here...
end
