module KdTree
  module DataConversion
    def data_from_value(value, type = nil)
      type ||= self.type
      case type
        when :integer
          ptr = FFI::MemoryPointer.new(FFI::type_size(:int))
          ptr.write_int(value)
          ptr
        when :double
          ptr = FFI::MemoryPointer.new(FFI::type_size(:double))
          ptr.write_double(value)
          ptr
        when :string
          ptr = FFI::MemoryPointer.new(value.bytesize + 1)
          ptr.write_string(value)
          ptr
        when :object
          data = Marshal.dump(value)
          ptr = FFI::MemoryPointer.new(data.bytesize + 1)
          ptr.write_string(data)
          ptr
      end
      ptr.autorelease = false
      ptr
    end

    def value_from_data(data, type = nil)
      type ||= self.type
      case type
        when :integer
          data.read_int
        when :double
          data.read_double
        when :string
          data.read_string
        when :object
          Marshal.restore(data.read_string)
      end
    end

    private :value_from_data, :data_from_value
  end

end
