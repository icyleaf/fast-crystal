require "benchmark"

NAMEDTUPLE = {fast: "ruby"}

def fast
  NAMEDTUPLE[:fast]
end

def slow
  NAMEDTUPLE.fetch(:fast, "")
end

Benchmark.ips do |x|
  x.report("NamedTuple#[]") { fast }
  x.report("NamedTuple#fetch") { slow }
end
