class Integer
  # Integer#hash already implemented for you
end

class Array #[1, 2, 3]  [12, 3]
  def hash 
    var = ""
    self.each_with_index do |ele, i|
      var += ele.to_s + i.to_s
    end
    var.to_i
  end
end

class String
  def hash
    char_arr = ('a'..'z').to_a
    var = ""
    self.each_char.with_index do |char, i|
      var += char_arr.index(char).to_s + i.to_s
    end
    var.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    var = ""
    char_arr = ('a'..'z').to_a
    array = self.keys
    sorted = array.sort
    sorted.each_with_index do |k, i|
      var += char_arr.index(k).to_s + i.to_s     
    end
    var.to_i   
  end
end