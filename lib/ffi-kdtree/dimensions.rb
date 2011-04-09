module KdTree
  module Dimensions
    DIMENSIONAL_ARRAY_CLASSES = {}

    def dimensions
      self.tree[:dim] 
    end

    def new_position
      KdTree::DimensionArray(dimensions).new
    end

    def build_position(ary)
      position = new_position
      ary.each_with_index do |value, index|
        position[:pos][index] = value
      end
      position
    end

    def distance_sq(from, to)
      raise "Dimensions must be the same size between positions" unless from.size == to.size
      sq = 0
      from.each_with_index do |value, index|
        diff = value - to[index]
        sq += diff * diff
      end
      sq
    end

    def distance(from, to)
      Math.sqrt(distance_sq(from, to))
    end
  end

  # Parameterized class factory for dimensional arrays that FFI can work with
  def self.DimensionArray(size)
    Tree::DIMENSIONAL_ARRAY_CLASSES[size] ||= begin
      clazz = Class.new(FFI::Struct)
      clazz.class_eval do
        layout(:pos, [:double, size])
        def to_a; self[:pos].to_a end
      end
      clazz
    end
  end
end
