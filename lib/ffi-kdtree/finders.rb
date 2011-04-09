module KdTree
  module Finders
    def find_nearest(position)
      position = build_position(position) unless FFI::Struct === position
      res_ptr = FFI::AutoPointer.new(
        LibKdTree.kd_nearest(self.tree, position),
        PointerHelpers::ResPointerHelper.method(:release))

      found_pos = new_position
      found_data = value_from_data(LibKdTree.kd_res_item(res_ptr, found_pos))
      [found_pos.to_a, found_data]
    end

    def find_nearest_range(position, radius)
      position = build_position(position) unless FFI::Struct === position
      res_ptr = FFI::AutoPointer.new(
        LibKdTree.kd_nearest_range(tree, position, radius),
        PointerHelpers::ResPointerHelper.method(:release))

      found_items = []
      found_pos = new_position
      while 0 == LibKdTree.kd_res_end(res_ptr)
        found_data = value_from_data(LibKdTree.kd_res_item(res_ptr, found_pos))
        found_items << [found_pos.to_a, found_data]
        LibKdTree.kd_res_next(res_ptr)
      end

      found_items
    end
  end
end
