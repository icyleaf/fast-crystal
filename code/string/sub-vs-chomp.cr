require "benchmark"

SLUG = "YourSubclassType"

def fast
  SLUG.chomp("Type")
end

def slow
  SLUG.sub(/Type\z/, "")
end

Benchmark.ips do |x|
  x.report("String#chomp\"string\"") { fast }
  x.report("String#sub/regexp/") { slow }
end
