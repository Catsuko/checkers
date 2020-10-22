module Checkers
  class OutOfBounds < StandardError
    def initialize(x:,y:)
      @x = x
      @y = y
    end

    def inspect
      "<Checkers::OutOfBounds: #{@x}, #{@y}>"
    end

    def to_s
      inspect
    end
  end
end