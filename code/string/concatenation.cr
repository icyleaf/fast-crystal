require "benchmark"

WORLD = "world"

def fastest
  "hello " + WORLD
end

def fast
  "hello #{WORLD}"
end

def slow
  "hello %s" % WORLD
end

Benchmark.ips do |x|
  x.report("String#+") { fastest }
  x.report("String\#{}") { fast }
  x.report("String#%") { slow }
end
