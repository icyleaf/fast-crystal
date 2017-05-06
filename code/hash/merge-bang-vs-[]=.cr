require "benchmark"

ENUM = (1..100)

def slow
  ENUM.each_with_object({} of Int32 => Int32) do |e, h|
    h.merge!({ e => e })
  end
end

def fast
  ENUM.each_with_object({} of Int32 => Int32) do |e, h|
    h[e] = e
  end
end

Benchmark.ips do |x|
  x.report("Hash#merge!") { slow }
  x.report("Hash#[]=") { fast }
end