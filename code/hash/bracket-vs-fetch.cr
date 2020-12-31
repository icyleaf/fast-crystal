require "benchmark"

HASH       = {"fast" => "ruby"}
NAMEDTUPLE = {fast: "ruby"}

Benchmark.ips do |x|
  x.report("Hash#[]") do
    HASH["fast"]
  end

  x.report("Hash#fetch") do
    HASH.fetch("fast") { }
  end
end
