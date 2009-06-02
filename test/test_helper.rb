require 'rubygems'
require 'test/unit'
require 'shoulda'

TEST_ROOT = File.expand_path(File.dirname(__FILE__))
LIB_ROOT  = File.join(TEST_ROOT, '..', 'lib')
SHOULDA_MACROS_ROOT = File.join(TEST_ROOT, 'shoulda_macros')

$LOAD_PATH.unshift(LIB_ROOT)
$LOAD_PATH.unshift(TEST_ROOT)
$LOAD_PATH.unshift(SHOULDA_MACROS_ROOT)

require File.join(SHOULDA_MACROS_ROOT,'paginate_context')
require File.join(LIB_ROOT, 'acts_as_pageable')
