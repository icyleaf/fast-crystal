require "benchmark"

ARRAY = (1..100)

def fast
  {% for number in ARRAY %}
    {{number.id}}
  {% end %}
end

def slow
  ARRAY.each do |number|
    number
  end
end

Benchmark.ips do |x|
  x.report("For loop") { fast }
  x.report("#each")    { slow }
end