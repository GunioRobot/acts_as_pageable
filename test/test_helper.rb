require 'rubygems'
require 'test/unit'
require 'shoulda'

TEST_ROOT       = File.expand_path(File.dirname(__FILE__))
LIB_ROOT        = File.join(File.dirname(__FILE__), '..', 'lib')
MODELS_ROOT     = File.join(TEST_ROOT,"models") 
FIXTURES_ROOT   = File.join(TEST_ROOT,"fixtures")

$LOAD_PATH.unshift(LIB_ROOT)
$LOAD_PATH.unshift(MODELS_ROOT)
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'logger'
require 'active_record'
require 'active_record/fixtures'
require 'active_record/test_case'

require File.join(LIB_ROOT, 'acts_as_pageable')
require File.join(MODELS_ROOT,'author')
require File.join(MODELS_ROOT,'blog')
require File.join(MODELS_ROOT,'post')

config = {
  'pageable_unit' => {
    :adapter  => 'sqlite3',
    :username => 'rails',
    :encoding => 'utf8',
    :database => ':memory:',
  }
}

ActiveRecord::Base.configurations = config['pageable_unit']
ActiveRecord::Base.establish_connection config['pageable_unit']
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::DEBUG

ActiveRecord::Schema.define(:version => 0) do

  create_table :blogs do |t|
    t.string :title
  end

  create_table :authors do |t|
    t.string :name
  end

  create_table :posts do |t|
    t.string :title
    t.string :text
    t.boolean :active
    t.references :author
    t.references :blog
  end

 end

