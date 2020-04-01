module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    end

  def my_each_index
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
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
    if block_given?
      my_each do |x|
        false unless yield x
      elsif val.nil?
        my_each do |x|
          false unless x
        elsif val.class == Class
          my_each do |x|
            false unless x.is_a? val
          elsif val.class == Regexp
            my_each do |x|
              false unless val.match? element
            else
              my_each do |x|
                false unless element == val
              end
              true
            end


  def my_any?
    if block_given?
      my_each do |x|
        false unless yield x
      elsif val.nil?
        my_each do |x|
          false unless x
        elsif val.class == Class
          my_each do |x|
            false unless x.is_a? val
          elsif val.class == Regexp
            my_each do |x|
              false unless val.match? element
            else
              my_each do |x|
                false unless element == val
              end
              true
            end

  def my_none?
    if block_given?
      my_each do |x|
        false unless yield x
      elsif val.nil?
        my_each do |x|
          false unless x
        elsif val.class == Class
          my_each do |x|
            false unless x.is_a? val
          elsif val.class == Regexp
            my_each do |x|
              false unless val.match? element
            else
              my_each do |x|
                false unless element == val
              end
              true
            end

  def my_count(_val = nil)
    if count.zero?
      my_each do |x|
      count += 1 if yield x
      end
      count
    end
  

  def my_map(&block)
    return to_enum(:my_map) unless block_given? || proc
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
