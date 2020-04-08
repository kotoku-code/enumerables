# rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
module Enumerable
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

  def my_all?(val = nil)
    if block_given?
      my_each do |x|
        false unless yield x
      end
    elsif val.nil?
      my_each do |x|
        false unless x
      end
    elsif val.class == Class
      my_each do |x|
        false unless x.is_a? val
      end
    elsif val.class == Regexp
      my_each do |_x|
        false unless val.match? element
      end
    else
      my_each do |_x|
        false unless element == val
      end
    end
    true
  end

  def my_any?(val = nil)
    if block_given?
      my_each do |x|
        false unless yield x
      end
    elsif val.nil?
      my_each do |x|
        false unless x
      end
    elsif val.class == Class
      my_each do |x|
        false unless x.is_a? val
      end
    elsif val.class == Regexp
      my_each do |_x|
        false unless val.match? element
      end
    else
      my_each do |_x|
        false unless element == val
      end
    end
    true
  end

  def my_none?(val = nil)
    if block_given?
      my_each do |x|
        false unless yield x
      end
    elsif val.nil?
      my_each do |x|
        false unless x
      end
    elsif val.class == Class
      my_each do |x|
        false unless x.is_a? val
      end
    elsif val.class == Regexp
      my_each do |_x|
        false unless val.match? element
      end
    else
      my_each do |_x|
        false unless element == val
      end
    end
    true
  end

  def my_count
    count = 0
    if count.zero?
      my_each do |x|
        count += 1 if yield x
      end
    end
    count
  end

  def my_map(proc=nil)
    return to_enum(:my_map) unless block_given? || proc

    new_result = []
    my_each do |_x|
      new_result.push(proc.call(i))
    end
    new_result
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

  def multiply_els
    my_inject(1) { |total, n| total * n }
  end
end
# rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
