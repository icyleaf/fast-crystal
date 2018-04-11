require "benchmark"

def slow
  nil.to_s.empty?
end

def fast
  "".nil?
end

Benchmark.ips do |x|
  x.report("String#nil?") { fast }
  x.report("Nil#to_s#empty?") { slow }
end
