require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets - 1
      resize!
    end
    self[key.hash].push(key)
    @count += 1
  end

  def include?(key)
    return self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)
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
        new_store[el.hash % new_num_buckets].push(el)
      end
    end
    @store = new_store
  end
end
