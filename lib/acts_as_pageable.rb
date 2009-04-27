ROOT_PAGEABLE_PATH = File.join(File.dirname(__FILE__), 'acts_as_pageable')
require File.join(ROOT_PAGEABLE_PATH, 'page')
require File.join(ROOT_PAGEABLE_PATH, 'named_queries')
require File.join(ROOT_PAGEABLE_PATH, 'active_record') if defined? ActiveRecord::Base
