require "benchmark"

SLUG = "root_url"

def fast
  SLUG.ends_with?("_url")
end

def slow
  SLUG =~ /_url$/
end

Benchmark.ips do |x|
  x.report("String#end_with?") { fast }
  x.report("String#=~") { slow }
end
