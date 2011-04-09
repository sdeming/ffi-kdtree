module KdTree
  module PointerHelpers
    class TreePointerHelper
      def self.release(pointer)
        LibKdTree::kd_free(pointer)
      end
    end

    class ResPointerHelper
      def self.release(pointer)
        LibKdTree::kd_res_free(pointer)
      end
    end
  end
end
