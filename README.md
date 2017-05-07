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

#### `frist` vs `index[0]` [code](code/array/frist-vs-index[0].cr)

```
$ crystal build --release code/array/frist-vs-index[0].cr -o bin/array/frist-vs-index[0]
$ ./bin/array/frist-vs-index[0]

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#first 343.32M (  2.91ns) (±11.87%)  1.30× slower
  Array#[0]  448.0M (  2.23ns) (±12.20%)       fastest
```

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
$ crystal build --release code/array/insert-vs-unshift.cr -o bin/array/insert-vs-unshift
$ ./bin/array/insert-vs-unshift

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 Array#insert   1.28  (783.62ms) (± 4.83%)  1.01× slower
Array#unshift   1.29  (777.65ms) (± 1.12%)       fastest
```

#### `last` vs `index[-1]` [code](code/array/last-vs-index[-1].cr)

```
$ crystal build --release code/array/last-vs-index[-1].cr -o bin/array/last-vs-index[-1]
$ ./bin/array/last-vs-index[-1]

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#[-1] 364.57M (  2.74ns) (± 8.09%)  1.20× slower
Array#last 437.23M (  2.29ns) (±11.77%)       fastest
```

#### `range` vs `tims.map` [code](code/array/range-vs-tims.map.cr)

```
$ crystal build --release code/array/range-vs-tims.map.cr -o bin/array/range-vs-tims.map
$ ./bin/array/range-vs-tims.map

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Range#to_a 825.89k (  1.21µs) (± 1.02%)       fastest
Times#to_a 790.83k (  1.26µs) (± 1.35%)  1.04× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
$ crystal build --release code/enumerable/each-push-vs-map.cr -o bin/enumerable/each-push-vs-map
$ ./bin/enumerable/each-push-vs-map

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

             Array#map 175.43k (   5.7µs) (± 3.03%)       fastest
     Array#each + push 111.48k (  8.97µs) (± 1.03%)  1.57× slower
Array#each_with_object 110.21k (  9.07µs) (± 2.30%)  1.59× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
$ crystal build --release code/enumerable/each-vs-loop.cr -o bin/enumerable/each-vs-loop
$ ./bin/enumerable/each-vs-loop

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

For loop 414.33M (  2.41ns) (±14.98%)       fastest
   #each 383.34M (  2.61ns) (±10.83%)  1.08× slower
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
$ crystal build --release code/enumerable/each_with_index-vs-while-loop.cr -o bin/enumerable/each_with_index-vs-while-loop
$ ./bin/enumerable/each_with_index-vs-while-loop

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

     While Loop   8.69M (115.14ns) (± 8.51%) 54.24× slower
each_with_index 471.08M (  2.12ns) (±18.38%)       fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
$ crystal build --release code/enumerable/map-flatten-vs-flat_map.cr -o bin/enumerable/map-flatten-vs-flat_map
$ ./bin/enumerable/map-flatten-vs-flat_map

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

   Array#flat_map 105.91k (  9.44µs) (± 4.27%)       fastest
Array#map.flatten  85.84k ( 11.65µs) (± 2.35%)  1.23× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
$ crystal build --release code/enumerable/reverse.each-vs-reverse_each.cr -o bin/enumerable/reverse.each-vs-reverse_each
$ ./bin/enumerable/reverse.each-vs-reverse_each

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Array#reverse.each   1.43M (699.66ns) (± 2.33%) 354.66× slower
Array#reverse_each  506.9M (  1.97ns) (±13.50%)        fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
$ crystal build --release code/enumerable/sort-vs-sort_by.cr -o bin/enumerable/sort-vs-sort_by
$ ./bin/enumerable/sort-vs-sort_by

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Enumerable#sort_by (Symbol#to_proc) 101.64k (  9.84µs) (± 2.04%)  1.57× slower
                 Enumerable#sort_by 103.66k (  9.65µs) (± 2.35%)  1.54× slower
                    Enumerable#sort 159.84k (  6.26µs) (± 1.89%)       fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
$ crystal build --release code/general/assignment.cr -o bin/general/assignment
$ ./bin/general/assignment

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Sequential Assignment 438.51M (  2.28ns) (±19.31%)  1.02× slower
  Parallel Assignment 447.36M (  2.24ns) (±15.87%)       fastest
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
$ crystal build --release code/general/hash-vs-struct-vs-namedtuple.cr -o bin/general/hash-vs-struct-vs-namedtuple
$ ./bin/general/hash-vs-struct-vs-namedtuple

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

NamedTuple 487.59M (  2.05ns) (±13.71%)        fastest
    Struct 422.41M (  2.37ns) (±17.98%)   1.15× slower
      Hash   4.31M (232.25ns) (± 3.03%) 113.24× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
$ crystal build --release code/general/loop-vs-while_true.cr -o bin/general/loop-vs-while_true
$ ./bin/general/loop-vs-while_true

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 While loop  16.39  ( 61.03ms) (± 3.16%)  1.00× slower
Kernel loop  16.39  ( 61.02ms) (± 3.83%)       fastest
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
$ crystal build --release code/general/positional_argument-vs-named_argument.cr -o bin/general/positional_argument-vs-named_argument
$ ./bin/general/positional_argument-vs-named_argument

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

     Named arguments 459.67M (  2.18ns) (±15.20%)       fastest
Positional arguments 457.27M (  2.19ns) (±14.96%)  1.01× slower
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
$ crystal build --release code/general/property-vs-getter_and_setter.cr -o bin/general/property-vs-getter_and_setter
$ ./bin/general/property-vs-getter_and_setter

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

         property  18.11M ( 55.21ns) (± 2.65%)  1.04× slower
getter_and_setter  18.75M ( 53.33ns) (± 4.87%)       fastest
```

### Hash

#### `bracket` vs `fetch` [code](code/hash/bracket-vs-fetch.cr)

```
$ crystal build --release code/hash/bracket-vs-fetch.cr -o bin/hash/bracket-vs-fetch
$ ./bin/hash/bracket-vs-fetch

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

   NamedTuple#[] 472.64M (  2.12ns) (± 7.18%)       fastest
NamedTuple#fetch 471.64M (  2.12ns) (± 7.19%)  1.00× slower
         Hash#[] 157.79M (  6.34ns) (± 6.61%)  3.00× slower
      Hash#fetch 165.49M (  6.04ns) (± 7.00%)  2.86× slower
```

#### `clone` vs `dup` [code](code/hash/clone-vs-dup.cr)

```
$ crystal build --release code/hash/clone-vs-dup.cr -o bin/hash/clone-vs-dup
$ ./bin/hash/clone-vs-dup

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

  Hash#dup   1.98M (504.85ns) (± 1.46%)       fastest
Hash#clone 111.09k (   9.0µs) (± 0.94%) 17.83× slower
```

#### `keys each` vs `each_key` [code](code/hash/keys-each-vs-each_key.cr)

```
$ crystal build --release code/hash/keys-each-vs-each_key.cr -o bin/hash/keys-each-vs-each_key
$ ./bin/hash/keys-each-vs-each_key

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Hash#keys.each   2.07M (482.28ns) (± 2.86%)  1.68× slower
 Hash#each_key   3.49M (286.53ns) (± 1.11%)       fastest
```

#### `merge bang` vs `[]=` [code](code/hash/merge-bang-vs-[]=.cr)

```
$ crystal build --release code/hash/merge-bang-vs-[]=.cr -o bin/hash/merge-bang-vs-[]=
$ ./bin/hash/merge-bang-vs-[]=

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

Hash#merge!  25.55k ( 39.14µs) (± 1.43%)  5.22× slower
   Hash#[]= 133.42k (   7.5µs) (± 3.07%)       fastest
```

### NamedTuple

#### `bracket` vs `fetch` [code](code/namedtuple/bracket-vs-fetch.cr)

```
$ crystal build --release code/namedtuple/bracket-vs-fetch.cr -o bin/namedtuple/bracket-vs-fetch
$ ./bin/namedtuple/bracket-vs-fetch

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

   NamedTuple#[] 400.67M (   2.5ns) (± 7.58%)  1.01× slower
NamedTuple#fetch 402.86M (  2.48ns) (± 7.31%)       fastest
```

#### `fetch` vs `fetch_with_block` [code](code/namedtuple/fetch-vs-fetch_with_block.cr)

```
$ crystal build --release code/namedtuple/fetch-vs-fetch_with_block.cr -o bin/namedtuple/fetch-vs-fetch_with_block
$ ./bin/namedtuple/fetch-vs-fetch_with_block

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

NamedTuple#fetch + const 331.21M (  3.02ns) (± 6.73%)  1.42× slower
NamedTuple#fetch + block  471.0M (  2.12ns) (± 7.64%)       fastest
  NamedTuple#fetch + arg 368.42M (  2.71ns) (± 6.48%)  1.28× slower
```

### Proce & Block

#### `block` vs `to_proc` [code](code/proc-and-block/block-vs-to_proc.cr)

```
$ crystal build --release code/proc-and-block/block-vs-to_proc.cr -o bin/proc-and-block/block-vs-to_proc
$ ./bin/proc-and-block/block-vs-to_proc

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

         Block 174.01k (  5.75µs) (± 1.42%)  1.00× slower
Symbol#to_proc 174.29k (  5.74µs) (± 1.50%)       fastest
```

#### `proc call` vs `yield` [code](code/proc-and-block/proc-call-vs-yield.cr)

```
$ crystal build --release code/proc-and-block/proc-call-vs-yield.cr -o bin/proc-and-block/proc-call-vs-yield
$ ./bin/proc-and-block/proc-call-vs-yield

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

    block.call 543.77M (  1.84ns) (± 9.01%)       fastest
 block + yield 538.69M (  1.86ns) (±10.15%)  1.01× slower
block argument 535.58M (  1.87ns) (± 9.53%)  1.02× slower
         yield 525.38M (   1.9ns) (±12.59%)  1.04× slower
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
$ crystal build --release code/string/concatenation.cr -o bin/string/concatenation
$ ./bin/string/concatenation

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#+   17.4M ( 57.49ns) (± 3.83%)       fastest
String#{}   5.2M (192.28ns) (± 1.45%)  3.34× slower
String#%    3.3M (302.85ns) (± 1.18%)  5.27× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
$ crystal build --release code/string/ends-string-matching-match-vs-end_with.cr -o bin/string/ends-string-matching-match-vs-end_with
$ ./bin/string/ends-string-matching-match-vs-end_with

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#end_with? 472.43M (  2.12ns) (± 7.17%)       fastest
       String#=~    6.0M (166.53ns) (± 1.43%) 78.68× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
$ crystal build --release code/string/equal-vs-match.cr -o bin/string/equal-vs-match
$ ./bin/string/equal-vs-match

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#match  12.42M ( 80.52ns) (± 1.79%)  1.02× slower
  Regexp#===  12.69M (  78.8ns) (± 2.05%)       fastest
   String#=~  12.12M ( 82.48ns) (± 1.34%)  1.05× slower
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
$ crystal build --release code/string/gsub-vs-sub.cr -o bin/string/gsub-vs-sub
$ ./bin/string/gsub-vs-sub

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

 String#sub   1.54M (649.85ns) (± 1.21%)       fastest
String#gsub  647.7k (  1.54µs) (± 1.01%)  2.38× slower
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
$ crystal build --release code/string/sub-vs-chomp.cr -o bin/string/sub-vs-chomp
$ ./bin/string/sub-vs-chomp

Crystal 0.22.0 (2017-04-20) LLVM 4.0.0

String#chomp"string"  21.86M ( 45.75ns) (± 2.33%)       fastest
  String#sub/regexp/   2.32M (430.78ns) (± 0.81%)  9.42× slower
```