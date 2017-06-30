require "benchmark"

def fastest
  "===="[0] == '='
end

def fast
  "===="[0].to_s == "="
end

def slow
  "===="[0] == "=".chars[0]
end

Benchmark.ips do |x|
  x.report("\"===\"[0] == '='") { fastest }
  x.report("\"===\"[0].to_s == \"=\"") { fast }
  x.report("\"===\"[0] == \"=\".chars[0]") { slow }
end
