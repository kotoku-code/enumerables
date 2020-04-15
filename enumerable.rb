# rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
module Enumerable
  def all_check(pattern, exponent)
    if pattern.is_a? Regexp
      return false if exponent !~ pattern
    elsif pattern.is_a? Class
      return false unless exponent.is_a? pattern
    elsif exponent != pattern
      return false
    end
    true
  end

  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    return to_enum(:my_select) unless block_given?

    my_each do |x|
      result.push(x) if yield x
    end
    result
  end

  def my_all?(pattern = nil)
    my_each do |x|
      if block_given?
        return false unless yield x
      elsif !pattern.nil?
        return false if all_check(pattern, x) == false
      else
        return false unless x
      end
    end
    true
  end

  def my_any?(arg = nil, &block)
    if block_given?
      my_each do |item|
        return true if block.call(item)
      end
    elsif arg.nil?
      my_each do |item|
        return true if item
      end
    elsif arg.class == Class
      my_each do |item|
        return true if item.is_a?(arg)
      end
    elsif arg.class == Regexp
      my_each do |item|
        return true if item =~ arg
      end
    else
      my_each do |item|
        return true if item == arg
      end
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(items = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif items.nil?
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == items }
    end
    count
  end

  def my_map(proc = nil)
    return enum_for(:my_map) unless block_given?

    arr = []
    each do |x|
      arr << if block_given?
               (yield x)
             else
               proc.call(x)
             end
    end
    arr
  end

  def my_inject(initial = nil, arg = nil)
    arg = initial if arg.nil?

    if initial.nil? || initial.is_a?(Symbol)
      array = drop(1)
      initial = to_a[0]
    else
      array = to_a
    end

    if block_given?
      array.my_each do |i|
        initial = yield(initial, i)
      end
    else
      array.my_each do |i|
        initial = initial.send(arg, i)
      end
    end
    initial
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, num| product * num }
end
# rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
