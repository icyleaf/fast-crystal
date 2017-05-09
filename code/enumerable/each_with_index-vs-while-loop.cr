require "benchmark"

ARRAY = (1..100).to_a

def fast
  index = 0
  while index < ARRAY.size
    ARRAY[index] + index
    index += 1
  end
  ARRAY
end

def slow
  ARRAY.each_with_index do |number, index|
    number + index
  end
end

Benchmark.ips do |x|
  x.report("While Loop") { fast }
  x.report("each_with_index") { slow }
end
