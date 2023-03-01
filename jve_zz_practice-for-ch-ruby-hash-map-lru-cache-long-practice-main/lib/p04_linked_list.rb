require "byebug"
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
  end

end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    # p @head.next.to_s
    # p @tail.to_s
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      end
    end
    return false
  end

  def append(key, val)
    n = Node.new(key, val)
    n.prev = @tail.prev
    n.next = @tail
    n.prev.next = n 
    @tail.prev = n 
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        return
      end
    end
    nil
  end

  def each(&prc)
    i = @head.next
    until i == @tail
      #debugger
      prc.call(i)
      i = i.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
     inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end