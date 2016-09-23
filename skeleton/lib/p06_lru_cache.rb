require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"
class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #print ">>>>>>>\n\n\n\n\n\n\n\n #{@map.include?(key)} \n\n\n\n\n\n"
    if @map.include?(key)
      update_link!(@map.get(key))
    else
      val = calc!(key)
      eject!
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    link = @store.insert(key, val)
    @map.set(key, link)
    val
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # prev_node = link.prev
    # next_node = link.next
    # prev_node.next = next_node
    # next_node.prev = prev_node
    #
    # second_to_last = @store.tail.prev
    # link.next = @store.tail
    # link.prev = second_to_last
    # second_to_last.next = link
    # @store.tail.prev = link
    @store.remove(link.key)
    @store.insert(link.key, link.val)
    @map.set(link.key, link)
    link.val
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    linked_list_length = 0
    @store.each do |node|
      linked_list_length += 1
    end
    if linked_list_length > @max
      @map.delete(@store.first.key)
      @store.remove(@store.first.key)
    end
  end
end
