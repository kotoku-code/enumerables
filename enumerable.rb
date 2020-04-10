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

  def my_any?(pattern = nil)
    if !block_given?
      my_any? { |item| pattern.nil? ? item : pattern == item }
    elsif is_a? Hash
      my_each do |x|
        return true if yield(x[0], x[1])
      end
      false
    else
      my_each do |x|
        return true if yield(x)
      end
      false
    end
  end

  def my_none?(*)
    !my_all?
  end

  def my_count(*)
    count = 0
    if count.zero?
      my_each do |x|
        count += 1 if x
      end
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

  def my_inject(initial = nil, sym = nil)
    arr = to_a

    if initial.nil?
      x = arr[0]
      arr[1..-1].my_each { |element| x = yield(x, element) }

    elsif block_given?
      x = initial
      arr.my_each { |element| x = yield(x, element) }

    elsif initial && sym
      x = initial
      arr.my_each { |element| x = x.send(sym, element) }
    end
    x
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, num| product * num }
end
# rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
