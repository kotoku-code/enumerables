module Enumerable
  def my_each(arr)
    result = []
    for i in 0..length
      result.push(yield(arr[i]))
    end
    result
  end

  def my_each_with_index(arr)
    result = []
    for i in 0..length
      result.push(yield(arr[i], i))
    end
    result
  end

  def my_select
    result = []
    my_each do |x|
      output.push(x) if yield x
    end
    result
  end

  def my_all
    result = true
    my_each do |x|
      result = false unless yield x
    end
    result
  end

  def my_any?
    result = false
    my_each do |x|
      result = false if yield x
    end
    result
  end

  def my_none?
    result = true
    my_each do |x|
      result = false if yield x
    end
    result
  end

  def my_count
    count = 0
    my_each do |x|
      count += 1 if yield x
    end
    count
  end

  def my_map(arr)
    result = []
    my_each(arr) do |x|
      result.push(yield(x))
    end
    result
  end

  def my_map(&block)
    new_result = []
    self.my_each do |x|
      new_result.push(block.call(i))
    end
    new_result
  end

  def my_inject(initial = 0)
    i = 0
    total = initial
    while (i < self.length)
      total = yield(total, self[i])
      i = i + 1
    end
    total
  end

  def multiply_els
    self.my_inject(1) { |total, n| total * n }
  end
end
