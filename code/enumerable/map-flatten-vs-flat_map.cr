require "benchmark"

ARRAY = (1..100).to_a

def fastest
  ARRAY.flat_map { |e| {e, e} }
end

def fast
  ARRAY.map { |e| {e, e} }.flatten
end

def slow
  ARRAY.flat_map { |e| [e, e] }
end

def slowest
  ARRAY.map { |e| [e, e] }.flatten
end

Benchmark.ips do |x|
  x.report("Array#flat_map (Tuple)") { fastest }
  x.report("Array#map.flatten (Tuple)") { fast }
  x.report("Array#flat_map (Array)") { slow }
  x.report("Array#map.flatten (Array)") { slowest }
end
