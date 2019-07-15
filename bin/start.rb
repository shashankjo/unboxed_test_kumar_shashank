require './lib/unboxed_test'

parameter = ARGV[0].chomp
fav_language = UnboxedTest.new(parameter).find_favourite_language
puts fav_language
