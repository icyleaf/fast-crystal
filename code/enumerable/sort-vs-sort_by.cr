require "benchmark"

struct User
  property name

  def initialize(@name : String)
  end
end

ARRAY = Array.new(100) do
  User.new(sprintf "%010d", rand(1_000_000_000))
end

def fastest
  ARRAY.sort_by(&.name)
end

def faster
  ARRAY.sort_by { |element| element.name }
end

def slow
  ARRAY.sort { |a, b| a.name <=> b.name }
end

Benchmark.ips do |x|
  x.report("Enumerable#sort_by (Symbol#to_proc)") { fastest }
  x.report("Enumerable#sort_by") { faster }
  x.report("Enumerable#sort")    { slow }
end