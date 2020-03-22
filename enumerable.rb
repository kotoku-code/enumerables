module Enumerable
    def my_each(arr)
result=[]
for i in 0..length
    result.push(yield(arr[i]))
end
result
    end
 
    def my_each_with_index(arr)
        result = []
        for i in 0..length
            result.push(yield(arr[i],i))
        end
        result
    end

    def my_select
        result=[]
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
            count +=1 if yield x
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









end