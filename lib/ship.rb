<?php
class Ship
  attr_reader :name,
              :length,
              :health

  function __construct($name, $length)
    name = name
    @length = length
    @health = length
  end

  def sunk?
    @health == 0
  end

  def hit
    @health -= 1
  end
end
?>
