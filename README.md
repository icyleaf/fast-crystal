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

#### Parallel Assignment vs Sequential Assignment [code](code/general/assignment.cr)

```
RUN crystal build --release code/general/assignment.cr -o bin/general/assignment_benchmark
RUN ./bin/general/assignment_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Sequential Assignment  445.6M (  2.24ns) (±16.59%)       fastest
  Parallel Assignment 412.08M (  2.43ns) (±15.75%)  1.08× slower
```

#### Positional arguments vs Named arguments [code](code/general/positional_argument_vs_named_argument.cr)

```
RUN crystal build --release code/general/positional_argument_vs_named_argument.cr -o bin/general/positional_argument_vs_named_argument_benchmark
RUN ./bin/general/positional_argument_vs_named_argument_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

     Named arguments 472.76M (  2.12ns) (±17.01%)       fastest
Positional arguments 455.11M (   2.2ns) (±17.72%)  1.04× slower
```

#### `loop vs `while` true [code](code/general/loop_vs_while_true.cr)

```
RUN crystal build --release code/general/loop_vs_while_true.cr -o bin/general/loop_vs_while_true_benchmark
RUN ./bin/general/loop_vs_while_true_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 While loop   15.2  (  65.8ms) (± 4.39%)       fastest
Kernel loop  15.09  ( 66.29ms) (± 5.02%)  1.01× slower
```

#### `property` vs `getter and setter` [code](code/general/property_vs_getter_and_setter.cr)

```
RUN crystal build --release code/general/property_vs_getter_and_setter.cr -o bin/general/property_vs_getter_and_setter_benchmark
RUN ./bin/general/property_vs_getter_and_setter_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

         property  18.76M ( 53.31ns) (± 4.79%)       fastest
getter_and_setter  18.21M ( 54.92ns) (± 2.20%)  1.03× slower
```

### Array

### General

### Enumerable

### Hash

### Proc & Block

### String

#### String Concatenation [code](code/string/concatenation.cr)

```
RUN crystal build --release code/string/concatenation.cr -o bin/string/concatenation_benchmark
RUN ./bin/string/concatenation_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#+  23.35M ( 42.82ns) (± 3.19%)       fastest
String#"   5.21M ( 192.0ns) (± 2.57%)  4.48× slower
String#%   3.29M (304.04ns) (± 1.97%)  7.10× slower
```

#### `String#match` vs `String#ends_with?` [code](code/string/ends_string_checking_match_vs_end_with.cr)

```
RUN crystal build --release code/string/ends_string_checking_match_vs_end_with.cr -o bin/string/ends_string_checking_match_vs_end_with_benchmark
RUN ./bin/string/ends_string_checking_match_vs_end_with_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#end_with? 427.59M (  2.34ns) (±13.66%)       fastest
       String#=~    5.8M (172.48ns) (± 2.93%) 73.75× slower
```

#### `Regexp#===` vs `String#match` vs `String#=~` [code](code/string/equal_vs_match.c)

```
RUN crystal build --release code/string/equal_vs_match.cr -o bin/string/equal_vs_match_benchmark
RUN ./bin/string/equal_vs_match_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#match  12.63M ( 79.18ns) (± 3.49%)       fastest
   String#=~  12.36M ( 80.88ns) (± 4.46%)  1.02× slower
  Regexp#===  12.36M ( 80.89ns) (± 7.60%)  1.02× slower
```

#### `String#gsub` vs `String#sub` [code](code/string/gsub_vs_sub.cr)

```
RUN crystal build --release code/string/gsub_vs_sub.cr -o bin/string/gsub_vs_sub_benchmark
RUN ./bin/string/gsub_vs_sub_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 String#sub   1.49M (671.27ns) (± 4.01%)       fastest
String#gsub 604.42k (  1.65µs) (± 6.33%)  2.46× slower
```

#### `String#sub` vs `String#chomp` [code](code/string/sub_vs_chomp.cr)

```
RUN crystal build --release code/string/sub_vs_chomp.cr -o bin/string/sub_vs_chomp_benchmark
RUN ./bin/string/sub_vs_chomp_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#chomp"string"  20.96M (  47.7ns) (± 5.11%)       fastest
  String#sub/regexp/   2.18M (458.96ns) (± 7.01%)  9.62× slower
```

### Range
