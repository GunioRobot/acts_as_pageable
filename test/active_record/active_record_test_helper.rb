require File.join(File.dirname(__FILE__), '..', 'test_helper')

MODELS_ROOT = File.join(TEST_ROOT,"active_record","models") 

$LOAD_PATH.unshift(MODELS_ROOT)
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'logger'
require 'active_record'

require File.join(LIB_ROOT, 'acts_as_pageable')
require File.join(MODELS_ROOT,'author')
require File.join(MODELS_ROOT,'category')
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

  create_table :categories do |t|
    t.string :name
  end

  create_table :blogs do |t|
    t.integer :id, :null => false
    t.string :title
    t.references :category
  end

  create_table :authors do |t|
    t.integer :id, :null => false
    t.string :name
  end

  create_table :posts do |t|
    t.integer :id, :null => false
    t.references :author, :null => false
    t.references :blog, :null => false
    t.boolean :active, :null => false, :default => true
    t.string :title
    t.string :text
  end

 end

