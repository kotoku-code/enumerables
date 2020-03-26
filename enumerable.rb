module_Enumerable
def my_each(block)
  result = []
  return to_enum unless block_given?

  (0..length).each do |i|
    result.push(yield(block[i]))
  end
  result
end

def my_each_with_index(block)
  result = []
  return to_enum unless block_given?

  (0..length).each do |i|
    result.push(yield(block[i], i))
  end
  result
end

def my_select
  result = []
  return to_enum unless block_given?

  my_each do |x|
    output.push(x) if yield x
  end
  result
end

def my_all?
  result = true
  my_each do |x|
    result = false unless yield x
  end
  result
end
if pattern.is_a? Class
  my_each do |x|
    return false unless x.is_a? pattern
  end
  true
end

def my_any?
  result = false
  my_each do |x|
    result = false if yield x
  end
  result
end
if pattern.is_a? Class
  my_each do |x|
    return false unless x.is_a? pattern
  end
  true
end

def my_none?
  result = true
  my_each do |x|
    result = false if yield x
  end
  result
end
if pattern.is_a? Class
  my_each do |x|
    return false unless x.is_a? pattern
  end
  true
end

def my_count
  count = 0
  my_each do |x|
    count += 1 if yield x
  end
  count
end
if pattern.is_a? Class
  my_each do |x|
    return false unless x.is_a? pattern
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

def my_inject(initial = 0, sym = :+)
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
