require "benchmark"

module M
  def self.func(a, b, c)
  end
end

def fast
  M.func(a: 1, b: 2, c: 3)
end

def slow
  M.func(1, 2, 3)
end

Benchmark.ips do |x|
  x.report("Named arguments") { fast }
  x.report("Positional arguments") { slow }
end