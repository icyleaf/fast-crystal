require "benchmark"

struct User
  property name

  def initialize(@name : String)
  end
end

ARRAY = Array.new(100) do
  User.new(sprintf "%010d", rand(1_000_000_000))
end

def fast
  ARRAY.sort_by(&.name)
end

def slow
  ARRAY.sort { |a, b| a.name <=> b.name }
end

Benchmark.ips do |x|
  x.report("Enumerable#sort") { fast }
  x.report("Enumerable#sort_by") { slow }
end
