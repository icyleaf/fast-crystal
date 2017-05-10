require "benchmark"

Benchmark.ips do |x|
  x.report("Array#insert") do
    array = [] of Int32
    100_000.times { |i| array.insert(0, i) }
  end

  x.report("Array#unshift") do
    array = [] of Int32
    100_000.times { |i| array.unshift(i) }
  end
end
