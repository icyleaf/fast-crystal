require "benchmark"

ARRAY = (1..100).to_a

def fast
  ARRAY.flat_map { |e| [e, e] }
end

def slow
  ARRAY.map { |e| [e, e] }.flatten
end

Benchmark.ips do |x|
  x.report("Array#flat_map") { fast }
  x.report("Array#map.flatten") { slow }
end
