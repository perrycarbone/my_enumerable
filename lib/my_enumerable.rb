module MyEnumerable

  def map
    result = []
    if block_given?
      each { |element| result << yield(element) }
      result
    else
      @list.to_enum
    end
  end

  def select
    result = []
    if block_given?
      each { |element| result << element if yield(element) }
      result
    else
      @list.to_enum
    end
  end

  def include?(arg)
    each { |element| return true if arg == element }
  end

  def first(arg = nil)
    if arg
      result = []
      each do |element|
        result << element
        break if result.size == arg
      end
      result
    else
      first_element = nil
      each do |element|
        first_element = element
        break
      end
      first_element
    end
  end

  def count(arg = nil)
    if block_given?
      temp_array = []
      each { |element| temp_array << element if yield(element) }
      temp_array.size
    elsif arg == nil
      @list.size
    else
      temp_array = []
      each { |element| temp_array << element if element == arg }
      temp_array.size
    end
  end
end
