require "benchmark"

HASH = ("a".."z").map{ |v| { v => v.bytes } }

def fast
  HASH.dup
end

def slow
  HASH.clone
end

Benchmark.ips do |x|
  x.report("Hash#dup") { fast }
  x.report("Hash#clone")   { slow }
end