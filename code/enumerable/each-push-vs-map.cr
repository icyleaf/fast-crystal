require "benchmark"

ARRAY = (1..1000).to_a

def fastest
  ARRAY.map { |i| i }
end

def fast
  array = [] of Int32
  ARRAY.each { |i| array.push i }
  array
end

def slow
  ARRAY.each_with_object([] of Int32) { |i, obj| obj << i }
end

Benchmark.ips do |x|
  x.report("Array#map")         { fastest }
  x.report("Array#each + push") { fast }
  x.report("Array#each_with_object")  { slow }
end