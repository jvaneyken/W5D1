class MaxIntSet

  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    @store[num] = true if validate!(num) && is_valid?(num) 
  end

  def remove(num)
    @store[num] = false if validate!(num) && is_valid?(num)
  end

  def include?(num)
    @store[num] == true if validate!(num) && is_valid?(num)
  end

  private

  def is_valid?(num)
    raise 'Out of bounds'if num < 0 || num > max - 1
    true
  end

  def validate!(num)
    raise 'input a number' unless num.is_a?(Integer)
    true
  end

end

class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new([]) }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    @store[i]
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
    unless include?(num)
      self[num] << num 
      @count += 1
      resize! if count == num_buckets
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets * 2) { Array.new }
    @store.each do |subarray|
      subarray.each do |ele|
        i = ele % (num_buckets * 2)
        new_array[i] << ele
      end
    end
    @store = new_array
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    @store[i]
  end
end