class HashSet
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
        i = ele.hash % (num_buckets * 2)
        new_array[i] << ele
      end
    end
    @store = new_array
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num.hash % num_buckets
    @store[i]
  end
end