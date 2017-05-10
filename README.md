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

```bash
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
- [NamedTuple](#namedtuple)
- [Proc & Block](#proc--block)
- [String](#string)

### Array

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
$ crystal build --release code/array/insert-vs-unshift.cr -o bin/array/insert-vs-unshift
$ ./bin/array/insert-vs-unshift

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

 Array#insert   1.55  (646.14ms) (± 1.21%)  1.00× slower
Array#unshift   1.55  (645.84ms) (± 1.46%)       fastest
```

#### `last` vs `index[-1]` [code](code/array/last-vs-index[-1].cr)

```
$ crystal build --release code/array/last-vs-index[-1].cr -o bin/array/last-vs-index[-1]
$ ./bin/array/last-vs-index[-1]

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Array#[-1] 377.86M (  2.65ns) (± 3.80%)       fastest
Array#last 377.83M (  2.65ns) (± 2.86%)  1.00× slower
```

#### `first` vs `index[0]` [code](code/array/first-vs-index[0].cr)

```
$ crystal build --release code/array/first-vs-index[0].cr -o bin/array/first-vs-index[0]
$ ./bin/array/first-vs-index[0]

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Array#first 378.15M (  2.64ns) (± 2.88%)       fastest
  Array#[0] 377.87M (  2.65ns) (± 3.03%)  1.00× slower
```

#### `range` vs `times.map` [code](code/array/range-vs-times.map.cr)

```
$ crystal build --release code/array/range-vs-times.map.cr -o bin/array/range-vs-times.map
$ ./bin/array/range-vs-times.map

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Range#to_a   1.54M ( 647.9ns) (± 2.16%)       fastest
Times#to_a   1.46M (683.39ns) (± 7.64%)  1.05× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
$ crystal build --release code/enumerable/each-push-vs-map.cr -o bin/enumerable/each-push-vs-map
$ ./bin/enumerable/each-push-vs-map

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

             Array#map 504.43k (  1.98µs) (± 3.05%)       fastest
     Array#each + push 245.71k (  4.07µs) (± 5.12%)  2.05× slower
Array#each_with_object 244.42k (  4.09µs) (± 3.29%)  2.06× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
$ crystal build --release code/enumerable/each-vs-loop.cr -o bin/enumerable/each-vs-loop
$ ./bin/enumerable/each-vs-loop

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

While Loop   6.66M (150.05ns) (± 0.36%) 70.96× slower
     #each 472.92M (  2.11ns) (± 3.39%)       fastest
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
$ crystal build --release code/enumerable/each_with_index-vs-while-loop.cr -o bin/enumerable/each_with_index-vs-while-loop
$ ./bin/enumerable/each_with_index-vs-while-loop

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

     While Loop   8.11M (123.27ns) (± 3.99%) 58.27× slower
each_with_index 472.68M (  2.12ns) (± 4.05%)       fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
$ crystal build --release code/enumerable/map-flatten-vs-flat_map.cr -o bin/enumerable/map-flatten-vs-flat_map
$ ./bin/enumerable/map-flatten-vs-flat_map

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

   Array#flat_map (Tuple)   1.05M (948.81ns) (± 2.42%)       fastest
Array#map.flatten (Tuple) 694.26k (  1.44µs) (± 4.33%)  1.52× slower
   Array#flat_map (Array) 227.31k (   4.4µs) (±14.61%)  4.64× slower
Array#map.flatten (Array)  186.1k (  5.37µs) (± 5.24%)  5.66× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
$ crystal build --release code/enumerable/reverse.each-vs-reverse_each.cr -o bin/enumerable/reverse.each-vs-reverse_each
$ ./bin/enumerable/reverse.each-vs-reverse_each

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Array#reverse.each   3.87M (258.42ns) (± 3.92%) 121.62× slower
Array#reverse_each 470.62M (  2.12ns) (± 4.66%)        fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
$ crystal build --release code/enumerable/sort-vs-sort_by.cr -o bin/enumerable/sort-vs-sort_by
$ ./bin/enumerable/sort-vs-sort_by

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

   Enumerable#sort 154.12k (  6.49µs) (± 1.24%)  1.14× slower
Enumerable#sort_by 175.13k (  5.71µs) (± 0.50%)       fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
$ crystal build --release code/general/assignment.cr -o bin/general/assignment
$ ./bin/general/assignment

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Sequential Assignment 471.82M (  2.12ns) (± 3.91%)  1.00× slower
  Parallel Assignment 472.29M (  2.12ns) (± 3.58%)       fastest
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
$ crystal build --release code/general/hash-vs-struct-vs-namedtuple.cr -o bin/general/hash-vs-struct-vs-namedtuple
$ ./bin/general/hash-vs-struct-vs-namedtuple

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

NamedTuple 471.56M (  2.12ns) (± 3.98%)  1.00× slower
    Struct 472.26M (  2.12ns) (± 3.58%)       fastest
      Hash  10.06M ( 99.41ns) (± 3.34%) 46.95× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
$ crystal build --release code/general/loop-vs-while_true.cr -o bin/general/loop-vs-while_true
$ ./bin/general/loop-vs-while_true

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

 While Loop  19.01  ( 52.62ms) (± 0.67%)  1.00× slower
Kernel Loop  19.03  ( 52.54ms) (± 0.40%)       fastest
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
$ crystal build --release code/general/positional_argument-vs-named_argument.cr -o bin/general/positional_argument-vs-named_argument
$ ./bin/general/positional_argument-vs-named_argument

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

     Named arguments 475.11M (   2.1ns) (± 1.52%)       fastest
Positional arguments 474.94M (  2.11ns) (± 1.61%)  1.00× slower
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
$ crystal build --release code/general/property-vs-getter_and_setter.cr -o bin/general/property-vs-getter_and_setter
$ ./bin/general/property-vs-getter_and_setter

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

         property  43.53M ( 22.97ns) (± 8.82%)  1.18× slower
getter_and_setter   51.4M ( 19.46ns) (± 3.78%)       fastest
```

### Hash

#### `bracket` vs `fetch` [code](code/hash/bracket-vs-fetch.cr)

```
$ crystal build --release code/hash/bracket-vs-fetch.cr -o bin/hash/bracket-vs-fetch
$ ./bin/hash/bracket-vs-fetch

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

   NamedTuple#[]  377.1M (  2.65ns) (± 5.19%)  1.01× slower
NamedTuple#fetch 380.46M (  2.63ns) (± 2.09%)       fastest
         Hash#[] 189.26M (  5.28ns) (± 2.88%)  2.01× slower
      Hash#fetch 190.38M (  5.25ns) (± 2.09%)  2.00× slower
```

#### `clone` vs `dup` [code](code/hash/clone-vs-dup.cr)

```
$ crystal build --release code/hash/clone-vs-dup.cr -o bin/hash/clone-vs-dup
$ ./bin/hash/clone-vs-dup

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

  Hash#dup   6.06M (164.89ns) (±10.42%)       fastest
Hash#clone 217.41k (   4.6µs) (± 4.79%) 27.90× slower
```

#### `keys each` vs `each_key` [code](code/hash/keys-each-vs-each_key.cr)

```
$ crystal build --release code/hash/keys-each-vs-each_key.cr -o bin/hash/keys-each-vs-each_key
$ ./bin/hash/keys-each-vs-each_key

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Hash#keys.each   3.63M (275.47ns) (± 3.90%)  1.24× slower
 Hash#each_key   4.51M ( 221.5ns) (± 0.99%)       fastest
```

#### `merge bang` vs `[]=` [code](code/hash/merge-bang-vs-[]=.cr)

```
$ crystal build --release code/hash/merge-bang-vs-[]=.cr -o bin/hash/merge-bang-vs-[]=
$ ./bin/hash/merge-bang-vs-[]=

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

Hash#merge!   66.8k ( 14.97µs) (± 4.96%)  3.42× slower
   Hash#[]= 228.18k (  4.38µs) (± 1.98%)       fastest
```

### NamedTuple

#### `bracket` vs `fetch` [code](code/namedtuple/bracket-vs-fetch.cr)

```
$ crystal build --release code/namedtuple/bracket-vs-fetch.cr -o bin/namedtuple/bracket-vs-fetch
$ ./bin/namedtuple/bracket-vs-fetch

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

   NamedTuple#[] 378.21M (  2.64ns) (± 2.97%)  1.00× slower
NamedTuple#fetch 378.41M (  2.64ns) (± 2.72%)       fastest
```

#### `fetch` vs `fetch_with_block` [code](code/namedtuple/fetch-vs-fetch_with_block.cr)

```
$ crystal build --release code/namedtuple/fetch-vs-fetch_with_block.cr -o bin/namedtuple/fetch-vs-fetch_with_block
$ ./bin/namedtuple/fetch-vs-fetch_with_block

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

NamedTuple#fetch + const 290.74M (  3.44ns) (± 3.31%)  1.30× slower
NamedTuple#fetch + block 377.67M (  2.65ns) (± 3.65%)  1.00× slower
  NamedTuple#fetch + arg 378.19M (  2.64ns) (± 2.77%)       fastest
```

### Proc & Block

#### `block` vs `to_proc` [code](code/proc-and-block/block-vs-to_proc.cr)

```
$ crystal build --release code/proc-and-block/block-vs-to_proc.cr -o bin/proc-and-block/block-vs-to_proc
$ ./bin/proc-and-block/block-vs-to_proc

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

         Block 278.15k (   3.6µs) (± 3.79%)  1.00× slower
Symbol#to_proc  278.4k (  3.59µs) (± 4.91%)       fastest
```

#### `proc call` vs `yield` [code](code/proc-and-block/proc-call-vs-yield.cr)

```
$ crystal build --release code/proc-and-block/proc-call-vs-yield.cr -o bin/proc-and-block/proc-call-vs-yield
$ ./bin/proc-and-block/proc-call-vs-yield

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

    block.call 473.29M (  2.11ns) (± 3.11%)  1.00× slower
 block + yield 473.36M (  2.11ns) (± 3.10%)  1.00× slower
block argument 473.48M (  2.11ns) (± 3.10%)       fastest
         yield 473.11M (  2.11ns) (± 3.17%)  1.00× slower
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
$ crystal build --release code/string/concatenation.cr -o bin/string/concatenation
$ ./bin/string/concatenation

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

 String#+  32.98M ( 30.32ns) (±11.62%)       fastest
String#{}   9.51M (105.16ns) (± 6.12%)  3.47× slower
 String#%    5.0M (200.03ns) (± 4.81%)  6.60× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
$ crystal build --release code/string/ends-string-matching-match-vs-end_with.cr -o bin/string/ends-string-matching-match-vs-end_with
$ ./bin/string/ends-string-matching-match-vs-end_with

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

String#end_with? 376.84M (  2.65ns) (± 4.02%)       fastest
       String#=~   6.08M (164.37ns) (± 2.65%) 61.94× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
$ crystal build --release code/string/equal-vs-match.cr -o bin/string/equal-vs-match
$ ./bin/string/equal-vs-match

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

String#match  14.97M (  66.8ns) (± 1.47%)  1.02× slower
  Regexp#===  15.12M ( 66.12ns) (± 3.51%)  1.01× slower
   String#=~  15.32M ( 65.26ns) (± 4.18%)       fastest
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
$ crystal build --release code/string/gsub-vs-sub.cr -o bin/string/gsub-vs-sub
$ ./bin/string/gsub-vs-sub

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

 String#sub   3.68M ( 271.6ns) (± 3.01%)       fastest
String#gsub 644.56k (  1.55µs) (± 1.10%)  5.71× slower
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
$ crystal build --release code/string/sub-vs-chomp.cr -o bin/string/sub-vs-chomp
$ ./bin/string/sub-vs-chomp

Crystal 0.22.0 (2017-04-22) LLVM 4.0.0

String#chomp"string"  37.67M ( 26.55ns) (± 8.27%)       fastest
  String#sub/regexp/   3.51M ( 284.9ns) (± 5.46%) 10.73× slower
```
