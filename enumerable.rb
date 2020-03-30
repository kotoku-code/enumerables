module Enumerable
  def my_each(block)
    result = []
    return to_enum(:my_each) unless block_given?

    (0..length).each do |i|
      result.push(yield(block[i]))
    end
    result
  end

  def my_each_with_index(block)
    result = []
    return to_enum(:my_each_with_index) unless block_given?

    (0..length).each do |i|
      result.push(yield(block[i], i))
    end
    result
  end

  def my_select
    result = []
    return to_enum(:my_select) unless block_given?

    my_each do |x|
      output.push(x) if yield x
    end
    result
  end

  def my_all?
    if result == true
      my_each do |x|
        false unless yield x
      end
      result
    end
  rescue attr.is_a?
    my_each do |x|
      return false unless x.is_a? attr
    end
    true
  end

  def my_any?
    if result == false
      my_each do |x|
        false if yield x
      end
      result
    end
  rescue attr.is_a?
    my_each do |x|
      return false unless x.is_a? attr
    end
    true
  end

  def my_none?
    if result == true
      my_each do |x|
        false if yield x
      end
      result
    end
  rescue attr.is_a?
    my_each do |x|
      return false unless x.is_a? attr
    end
    true
  end

  def my_count(_val = nil)
    if count.zero?
      my_each do |x|
        + 1 if yield x
      end
      count
    end
  rescue attr.is_a?
    my_each do |x|
      return false unless x.is_a? attr
    end
    true
  end

  def my_map(&block)
    new_result = []
    my_each do |_x|
      new_result.push(block.call(i))
    end
    new_result
  end

  def my_inject(initial = nil, sym = nil)
    i = 0
    total = initial
    while i < length
      total = yield(total, self[i])
      i += 1

      my_each { |item| initial = initial.method(sym).call(item) } unless initial
      total
    end
  end

  def multiply_els
    my_inject(1) { |total, n| total * n }
  end
end
