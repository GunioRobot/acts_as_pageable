ROOT_PAGEABLE_PATH = File.join(File.dirname(__FILE__), 'acts_as_pageable')
require File.join(ROOT_PAGEABLE_PATH, 'base')
require File.join(ROOT_PAGEABLE_PATH, 'page')

require 'active_record' unless defined? ActiveRecord
ActiveRecord::Base.extend(ActsAsPageable::Base)
