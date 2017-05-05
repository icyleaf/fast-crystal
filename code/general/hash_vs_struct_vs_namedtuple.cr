require "benchmark"

struct SampleStruct
  property name, year

  def initialize(@name : String, @year : Int32)
  end
end

def slow
  { "name" => "Crystal", "year" => 2011 }
end

def fast
  SampleStruct.new("Crystal", 2011)
end

def fasttest
  {name: "Crystal", year: 2011}
end

def slow3
  SampleStruct2.new "Crystal", 2011
end

Benchmark.ips do |x|
  x.report("NamedTuple")  { fasttest }
  x.report("Struct")      { fast }
  x.report("Hash")        { slow }
end