class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if num < 0 || num > @store.length-1
      raise("Out of bounds")
    else
      @store[num] = true
    end
  end

  def remove(num)
    raise("Out of bounds") if @store[num] == nil
    @store[num] = false
  end

  def include?(num)
    raise("Out of bounds") if @store[num] == nil
    return @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets - 1
      resize!
    end
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    new_num_buckets = num_buckets * 2
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_num_buckets].push(el)
      end
    end
    @store = new_store
  end
end
