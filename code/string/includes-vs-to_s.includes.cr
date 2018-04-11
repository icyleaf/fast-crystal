require "benchmark"

def slow
  "foobar".includes?("crystal")
end

def fast
  nil.to_s.includes?("crystal")
end

Benchmark.ips do |x|
  x.report("String#includes?") { fast }
  x.report("Nil#to_s#includes?") { slow }
end
