class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self[0].hash * self.length
  end
end

class String
  def hash
    (self.bytes.inject(&:+) * self.bytes.first).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    accumulator = 0
    self.each do |k, v|
      accumulator += (k.hash + v.hash).hash
    end
    accumulator
  end
end
