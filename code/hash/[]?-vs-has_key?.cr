require "benchmark"

HASH = {"a" => "z"}

Benchmark.ips do |x|
  x.report("Hash#[]?") do
    HASH["a"]?
    HASH["b"]?
  end

  x.report("Hash#has_key?") do
    HASH.has_key? "a"
    HASH.has_key? "b"
  end
end
