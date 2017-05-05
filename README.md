# 💎 Fast Crystal

It's Crystal version based on [ruby version](https://github.com/JuanitoFatas/fast-ruby).

Each idiom has a corresponding code example that resides in [code](code).

You will found the result of benchmarks is very amazing:exclamation: It is all fast or very close to the number most of them.

All results listed in README.md are running with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0 on OS X 10.12.4 in release mode.
Machine information: MacBook Pro (Retina, 15-inch, Mid 2015), 2.2 GHz Intel Core i7, 16 GB 1600 MHz DDR3.
Your results may vary, but you get the idea. : )

**Let's write faster code, together!  :trollface:**

## Measurement Tool

Use [benchmark](https://crystal-lang.org/api/0.22.0/Benchmark.html).

## Run the Benchmarks

```
$ make
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

#### `loop` vs `while` true [code](code/general/loop_vs_while_true.cr)

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

#### `Array#[0]` vs `Array#first` [code](code/array/array_frist_vs_index.cr)

```
RUN crystal build --release code/array/array_frist_vs_index.cr -o bin/array/array_frist_vs_index_benchmark
RUN ./bin/array/array_frist_vs_index_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

  Array#[0] 380.82M (  2.63ns) (±12.68%)       fastest
Array#first 372.56M (  2.68ns) (±12.96%)  1.02× slower
```

#### `Array#[-1]` vs `Array#last`[code](code/array/array_last_vs_index.cr)

```
RUN crystal build --release code/array/array_last_vs_index.cr -o bin/array/array_last_vs_index_benchmark
RUN ./bin/array/array_last_vs_index_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#[-1] 381.04M (  2.62ns) (±13.45%)       fastest
Array#last 375.41M (  2.66ns) (±12.90%)  1.02× slower
```

#### `Array#insert` vs `Array#unshift`[code](code/array/insert_vs_unshift.cr)

```
RUN crystal build --release code/array/insert_vs_unshift.cr -o bin/array/insert_vs_unshift_benchmark
RUN ./bin/array/insert_vs_unshift_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 Array#insert    1.3  ( 767.5ms) (± 4.56%)       fastest
Array#unshift    1.3  (771.72ms) (± 3.68%)  1.01× slower
```

#### `Range#to_a` vs `Times# [code](code/array/range_vs_time_map.cr)

```
RUN crystal build --release code/array/range_vs_time_map.cr -o bin/array/range_vs_time_map_benchmark
RUN ./bin/array/range_vs_time_map_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Range#to_a 825.21k (  1.21µs) (± 0.85%)       fastest
Times#to_a 793.87k (  1.26µs) (± 0.64%)  1.04× slower
```

### Enumerable

#### `map` vs `each + push` vs `each_with_object` [code](code/enumerable/each_push_vs_map.cr)

```
RUN crystal build --release code/enumerable/each_push_vs_map.cr -o bin/enumerable/each_push_vs_map_benchmark
RUN ./bin/enumerable/each_push_vs_map_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

             Array#map 175.57k (   5.7µs) (± 0.71%)       fastest
     Array#each + push 108.44k (  9.22µs) (± 3.68%)  1.62× slower
Array#each_with_object 109.23k (  9.16µs) (± 2.23%)  1.61× slower
```

#### `each` vs `For Loop` [code](code/enumerable/each_vs_loop.cr)

```
RUN crystal build --release code/enumerable/each_vs_loop.cr -o bin/enumerable/each_vs_loop_benchmark
RUN ./bin/enumerable/each_vs_loop_benchmark with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

For loop 453.52M (   2.2ns) (±17.21%)       fastest
   #each 373.48M (  2.68ns) (±12.22%)  1.21× slower
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_vs_loop.cr)

```

```


#### `map.flatten` vs `flat_map` [code](code/enumerable/each_vs_loop.cr)

```

```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/each_vs_loop.cr)

```

```

#### `sort` vs `sort_by` [code](code/enumerable/each_vs_loop.cr)

```

```

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