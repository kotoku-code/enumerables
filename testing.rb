require_relative "enumerable"

#p [1, 2, 3].my_map
#p [1, 2, 3].map
#
#p [1, 2, 6].my_all? { |num| num < 4}
#p [1, 2, 6].all? { |num| num < 4}


p %w[a a].all?(String)
p [1, 1].all? { |val| val.instance_of? Integer}
p %w[a a].my_all?(String)




