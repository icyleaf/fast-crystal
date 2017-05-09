require "benchmark"

Benchmark.ips do |x|
  x.report("Range#to_a") do
    (1..100).to_a
  end

  x.report("Times#to_a") do
    100.times.map { |i| i + 1 }.to_a
  end
end
