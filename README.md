# 💎 Fast Crystal

It's Crystal version based on [ruby version](https://github.com/JuanitoFatas/fast-ruby).

Each idiom has a corresponding code example that resides in [code](code).

All results listed in README.md are running with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0 on OS X 10.12.4.

Machine information: MacBook Pro (Retina, 15-inch, Mid 2015), 2.2 GHz Intel Core i7, 16 GB 1600 MHz DDR3.

Your results may vary, but you get the idea. : )

> Doubt the results? please discuss in [Crystal Issue#4383](https://github.com/crystal-lang/crystal/issues/4383).

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

### Array

#### `frist` vs `index[0]` [code](code/array/frist-vs-index[0].cr)

```
RUN crystal build --release code/array/frist-vs-index[0].cr -o bin/array/frist-vs-index[0]
RUN ./bin/array/frist-vs-index[0] with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#first 365.12M (  2.74ns) (± 7.80%)  1.28× slower
  Array#[0] 468.28M (  2.14ns) (± 8.36%)       fastest
```

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
RUN crystal build --release code/array/insert-vs-unshift.cr -o bin/array/insert-vs-unshift
RUN ./bin/array/insert-vs-unshift with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 Array#insert    1.4  (716.56ms) (± 1.00%)  1.01× slower
Array#unshift   1.41  (711.33ms) (± 1.11%)       fastest
```

#### `last` vs `index[ 1]` [code](code/array/last-vs-index[-1].cr)

```
RUN crystal build --release code/array/last-vs-index[-1].cr -o bin/array/last-vs-index[-1]
RUN ./bin/array/last-vs-index[-1] with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#[-1]  365.4M (  2.74ns) (± 7.62%)  1.29× slower
Array#last 470.14M (  2.13ns) (± 7.68%)       fastest
```

#### `range` vs `tims.map` [code](code/array/range-vs-tims.map.cr)

```
RUN crystal build --release code/array/range-vs-tims.map.cr -o bin/array/range-vs-tims.map
RUN ./bin/array/range-vs-tims.map with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Range#to_a 828.89k (  1.21µs) (± 1.07%)       fastest
Times#to_a 802.16k (  1.25µs) (± 1.70%)  1.03× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
RUN crystal build --release code/enumerable/each-push-vs-map.cr -o bin/enumerable/each-push-vs-map
RUN ./bin/enumerable/each-push-vs-map with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

             Array#map 177.92k (  5.62µs) (± 0.92%)       fastest
     Array#each + push 111.26k (  8.99µs) (± 0.97%)  1.60× slower
Array#each_with_object 111.35k (  8.98µs) (± 1.19%)  1.60× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
RUN crystal build --release code/enumerable/each-vs-loop.cr -o bin/enumerable/each-vs-loop
RUN ./bin/enumerable/each-vs-loop with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

For loop 472.47M (  2.12ns) (±15.57%)       fastest
   #each 394.85M (  2.53ns) (± 8.42%)  1.20× slower
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
RUN crystal build --release code/enumerable/each_with_index-vs-while-loop.cr -o bin/enumerable/each_with_index-vs-while-loop
RUN ./bin/enumerable/each_with_index-vs-while-loop with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

     While Loop    8.7M (114.92ns) (± 8.99%) 57.56× slower
each_with_index 500.86M (   2.0ns) (±15.27%)       fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
RUN crystal build --release code/enumerable/map-flatten-vs-flat_map.cr -o bin/enumerable/map-flatten-vs-flat_map
RUN ./bin/enumerable/map-flatten-vs-flat_map with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

   Array#flat_map 106.23k (  9.41µs) (± 4.74%)       fastest
Array#map.flatten  88.25k ( 11.33µs) (± 1.58%)  1.20× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
RUN crystal build --release code/enumerable/reverse.each-vs-reverse_each.cr -o bin/enumerable/reverse.each-vs-reverse_each
RUN ./bin/enumerable/reverse.each-vs-reverse_each with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#reverse.each   1.84M (543.39ns) (± 6.61%) 293.09× slower
Array#reverse_each 539.38M (  1.85ns) (±10.23%)        fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
RUN crystal build --release code/enumerable/sort-vs-sort_by.cr -o bin/enumerable/sort-vs-sort_by
RUN ./bin/enumerable/sort-vs-sort_by with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Enumerable#sort_by (Symbol#to_proc) 104.52k (  9.57µs) (± 1.93%)  1.55× slower
                 Enumerable#sort_by 106.48k (  9.39µs) (± 3.34%)  1.52× slower
                    Enumerable#sort 162.29k (  6.16µs) (± 3.54%)       fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
RUN crystal build --release code/general/assignment.cr -o bin/general/assignment
RUN ./bin/general/assignment with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Sequential Assignment 442.29M (  2.26ns) (±18.39%)       fastest
  Parallel Assignment 418.69M (  2.39ns) (±18.95%)  1.06× slower
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
RUN crystal build --release code/general/hash-vs-struct-vs-namedtuple.cr -o bin/general/hash-vs-struct-vs-namedtuple
RUN ./bin/general/hash-vs-struct-vs-namedtuple with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

NamedTuple 485.96M (  2.06ns) (±15.42%)       fastest
    Struct 449.31M (  2.23ns) (±14.55%)  1.08× slower
      Hash   5.03M (198.81ns) (± 1.46%) 96.61× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
RUN crystal build --release code/general/loop-vs-while_true.cr -o bin/general/loop-vs-while_true
RUN ./bin/general/loop-vs-while_true with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 While loop  16.32  ( 61.26ms) (± 3.81%)  1.01× slower
Kernel loop  16.45  (  60.8ms) (± 4.08%)       fastest
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
RUN crystal build --release code/general/positional_argument-vs-named_argument.cr -o bin/general/positional_argument-vs-named_argument
RUN ./bin/general/positional_argument-vs-named_argument with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

     Named arguments 477.22M (   2.1ns) (±15.58%)       fastest
Positional arguments 457.83M (  2.18ns) (±14.68%)  1.04× slower
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
RUN crystal build --release code/general/property-vs-getter_and_setter.cr -o bin/general/property-vs-getter_and_setter
RUN ./bin/general/property-vs-getter_and_setter with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

         property  18.29M ( 54.69ns) (± 2.37%)  1.03× slower
getter_and_setter  18.86M ( 53.03ns) (± 4.85%)       fastest
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
RUN crystal build --release code/string/concatenation.cr -o bin/string/concatenation
RUN ./bin/string/concatenation with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#+  22.84M ( 43.78ns) (± 3.14%)       fastest
String#"   5.27M (189.69ns) (± 1.37%)  4.33× slower
String#%   3.32M (300.98ns) (± 0.99%)  6.88× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
RUN crystal build --release code/string/ends-string-matching-match-vs-end_with.cr -o bin/string/ends-string-matching-match-vs-end_with
RUN ./bin/string/ends-string-matching-match-vs-end_with with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#end_with? 471.93M (  2.12ns) (± 7.48%)       fastest
       String#=~   5.97M (167.52ns) (± 1.23%) 79.06× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
RUN crystal build --release code/string/equal-vs-match.cr -o bin/string/equal-vs-match
RUN ./bin/string/equal-vs-match with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#match  12.46M ( 80.26ns) (± 1.33%)  1.02× slower
  Regexp#===  12.72M ( 78.63ns) (± 1.43%)       fastest
   String#=~  12.61M ( 79.33ns) (± 1.37%)  1.01× slower
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
RUN crystal build --release code/string/gsub-vs-sub.cr -o bin/string/gsub-vs-sub
RUN ./bin/string/gsub-vs-sub with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 String#sub   1.54M (650.04ns) (± 1.19%)       fastest
String#gsub 648.42k (  1.54µs) (± 0.77%)  2.37× slower
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
RUN crystal build --release code/string/sub-vs-chomp.cr -o bin/string/sub-vs-chomp
RUN ./bin/string/sub-vs-chomp with Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#chomp"string"  21.75M ( 45.98ns) (± 2.36%)       fastest
  String#sub/regexp/   2.12M (471.85ns) (± 1.08%) 10.26× slower
```