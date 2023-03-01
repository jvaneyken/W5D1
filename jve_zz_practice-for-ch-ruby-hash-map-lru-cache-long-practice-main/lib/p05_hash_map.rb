require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  attr_reader :num_buckets
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.each do |bucket|
     res = bucket.include?(key)
     return res unless res == false
    end
    false
  end

  def set(key, val)
    found_key = false
    @store.each do |bucket|
      bucket.each do |node|
        if node.key == key
          node.val = val
          found_key = true
        end
      end
    end
    if found_key == false
      i = key.hash % num_buckets
      @store[i].append(key, val)
      @count += 1
    end
  end

  def get(key)
    
    @store.each do |bucket|
      res = bucket.get(key)
      return res unless res.nil?
    end
    nil
  end

  def delete(key)
    @store.each do |bucket|
      res = bucket.remove(key)
      unless res.nil?
        @count -= 1
        return res
      end
    end
    nil
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end
  
  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end