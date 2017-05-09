require "benchmark"

ARRAY = (1..100).to_a

def fast
  i = 0
  while i < ARRAY.size
    ARRAY[i]
    i += 1
  end
end

def slow
  ARRAY.each do |number|
    number
  end
end

Benchmark.ips do |x|
  x.report("While Loop") { fast }
  x.report("#each") { slow }
end
