# https://gist.github.com/dljerome/2108cfa623f1004c2ed783ec8f0f29d9#file-bridge_pattern-rb
# Мост — это структурный паттерн проектирования, который разделяет один или несколько классов на две отдельные иерархии — абстракцию и реализацию, позволяя изменять их независимо друг от друга.

class Shape
  def initialize(implementor)
    @implementor = implementor
  end
end

class RectangleShape < Shape
  def draw
    @implementor.draw_rectangle
  end
end

class CircleShape < Shape
  def draw
    @implementors.draw_circle
  end
end

class ShapeImplementor

  def draw_circle
    raise '#draw_circle must be defined.'
  end

  def draw_rectangle
    raise '#draw_rectangle must de defined.'
  end
end

class LinuxShapeImplementor < ShapeImplementor
  def draw_circle
    # ...
  end

  def draw_rectangle
    # ...
  end
end

class MacShapeImplementor < ShapeImplementor
  def draw_circle
    # ...
  end

  def draw_rectangle
    # ...
  end
end

rectangle = class RectangleShape.new(MacShapeImplementor.new)
rectangle.draw
