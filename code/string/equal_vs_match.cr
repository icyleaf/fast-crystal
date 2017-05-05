require "benchmark"

def fastest
  "foo".match(/boo/)
end

def fast
  /boo/ === "foo"
end

def slow
  "foo" =~ /boo/
end

Benchmark.ips do |x|
  x.report("String#match") { fastest }
  x.report("Regexp#===") { fast }
  x.report("String#=~") { slow }
end