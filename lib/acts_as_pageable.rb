ROOT_PAGEABLE_PATH = File.join(File.dirname(__FILE__), 'acts_as_pageable')
require File.join(ROOT_PAGEABLE_PATH, 'settings')
require File.join(ROOT_PAGEABLE_PATH, 'page')
require File.join(ROOT_PAGEABLE_PATH, 'paginator')
require File.join(ROOT_PAGEABLE_PATH, 'presentation_model')
require File.join(ROOT_PAGEABLE_PATH, 'active_record') if defined? ActiveRecord
require File.join(ROOT_PAGEABLE_PATH, 'active_pack') if defined? ActionPack 
