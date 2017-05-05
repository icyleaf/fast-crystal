# 💎 Fast Crystal

It's Crystal version based on [ruby version](https://github.com/JuanitoFatas/fast-ruby).

Each idiom has a corresponding code example that resides in [code](code).


All results listed in README.md are running with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0 on OS X 10.12.4 in release mode.
Machine information: MacBook Pro (Retina, 15-inch, Mid 2015), 2.2 GHz Intel Core i7, 16 GB 1600 MHz DDR3.
Your results may vary, but you get the idea. : )

**Let's write faster code, together! <3**

## Measurement Tool

Use [benchmark](https://crystal-lang.org/api/0.22.0/Benchmark.html).

## Run the Benchmarks

```
$ crystal src/fast-crystal.cr
```

### Template

```crystal
require "benchmark"

def fast
end

def slow
end

Benchmark.ips do |x|
  x.report("fast code description") { fast }
  x.report("slow code description") { slow }
end
```

## Idioms

### Index

- [General](#general)
- [Array](#array)
- [Enumerable](#enumerable)
- [Hash](#hash)
- [Proc & Block](#proc--block)
- [String](#string)
- [Range](#range)

### General

### Array

### General

### Enumerable

### Hash

### Proc & Block

### String

#### String Concatenation [code](code/string/concatenation.cr)

```
RUN crystal build --release code/string/concatenation.cr -o bin/string/concatenation_test
RUN ./bin/string/concatenation_test with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#+  17.59M ( 56.84ns) (± 2.05%)       fastest
String#"   5.24M (190.89ns) (± 1.76%)  3.36× slower
String#%    3.3M (303.11ns) (± 1.10%)  5.33× slower
```

### Range
