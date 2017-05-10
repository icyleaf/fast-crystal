require "benchmark"

HASH       = {"fast" => "ruby"}
NAMEDTUPLE = {fast: "ruby"}

def fastest
  NAMEDTUPLE[:fast]
end

def faster
  NAMEDTUPLE.fetch(:fast, "")
end

def fast
  HASH["fast"]
end

def slow
  HASH.fetch("fast")
end

Benchmark.ips do |x|
  x.report("NamedTuple#[]") { fastest }
  x.report("NamedTuple#fetch") { faster }
  x.report("Hash#[]") { fast }
  x.report("Hash#fetch") { slow }
end
