require 'rubygems'
require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'ffi-kdtree')

module TestHelpers
  def generate_tree(dim_size, num_entries, type = :object, &block)
    block ||= proc.new { |i| i }
    tree = KdTree::Tree.new(dim_size, type)
    1.upto(num_entries).each do |i|
      tree.add(1.upto(dim_size).collect { rand }, block.call(i))
    end
  end
end


