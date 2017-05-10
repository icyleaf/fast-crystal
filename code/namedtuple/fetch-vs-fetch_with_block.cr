require "benchmark"

HASH    = {writing: :fast_ruby}
DEFAULT = "fast ruby"

Benchmark.ips do |x|
  x.report("NamedTuple#fetch + const") { HASH.fetch(:writing, DEFAULT) }
  x.report("NamedTuple#fetch + block") { HASH.fetch(:writing) { "fast ruby" } }
  x.report("NamedTuple#fetch + arg") { HASH.fetch(:writing, "fast ruby") }
end
