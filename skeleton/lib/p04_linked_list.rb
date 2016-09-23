class Link

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    current = first
    until current.key == key || current == @tail
      current = current.next
    end
    return nil if current == @tail
    current.val
  end

  def include?(key)
    current = first
    until current.key == key || current == @tail
      current = current.next
    end
    return current != @tail
  end

  def insert(key, val)
    link = Link.new(key, val)
    @tail.prev.next = link
    link.prev = @tail.prev
    @tail.prev = link
    link.next = @tail
    link.val = val
    link.key = key
    link
  end

  def remove(key)
    current = first
    until current.key == key || current == @tail
      current = current.next
    end
    current.prev.next = current.next
    current.next.prev = current.prev
    current.next = nil
    current.prev = nil
    current
  end

  def each(&prc)
    current = first
    until current == @tail do
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
