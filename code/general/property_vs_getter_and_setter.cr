require "benchmark"

class User
  property :first_name

  def initialize
    @first_name = ""
    @last_name = ""
  end

  def last_name
    @last_name
  end

  def last_name=(value)
    @last_name = value
  end

end

def slow
  user = User.new
  user.last_name = "Wang"
  user.last_name
end

def fast
  user = User.new
  user.first_name = "Wang"
  user.first_name
end

Benchmark.ips do |x|
  x.report("property")     { fast }
  x.report("getter_and_setter") { slow }
end