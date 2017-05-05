require "benchmark"

ARRAY = (1..100).to_a

def fast
  ARRAY.first
end

def slow
  ARRAY[0]
end

Benchmark.ips do |x|
  x.report("Array#first") { fast }
  x.report("Array#[0]") { slow }
end