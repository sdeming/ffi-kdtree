require File.join(File.dirname(__FILE__), 'data_conversion')
require File.join(File.dirname(__FILE__), 'dimensions')
require File.join(File.dirname(__FILE__), 'finders')

module KdTree

  class Tree
    attr_reader :tree, :type

    include DataConversion
    include Dimensions
    include Finders

    def initialize(size, type = :object)
      tree_ptr = FFI::AutoPointer.new(
        LibKdTree::kd_create(size), 
        PointerHelpers::TreePointerHelper.method(:release))
      @tree = LibKdTree::Tree.new(tree_ptr)
      @type = type
    end

    def add(position, value)
      position = build_position(position) unless FFI::Struct === position
      0 == LibKdTree::kd_insert(self.tree, position, data_from_value(value))
    end
  end
end
