# 💎 Fast Crystal

It's Crystal version based on [ruby version](https://github.com/JuanitoFatas/fast-ruby).

Each idiom has a corresponding code example that resides in [code](code).

All results listed in README.md are running with Crystal 0.25.0 (2018-06-15) LLVM 5.0.1 on OS X 10.13.5.

Machine information: MacBook Pro (Retina, 15-inch, Mid 2015), 2.2 GHz Intel Core i7, 16 GB 1600 MHz DDR3.

Your results may vary, but you get the idea. : )

> Doubt the results? please discuss in [Crystal Issue#4383](https://github.com/crystal-lang/crystal/issues/4383).

**Let's write faster code, together! :trollface:**

## Measurement Tool

Use Crystal's built-in [benchmark](https://crystal-lang.org/api/0.22.0/Benchmark.html).

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

- [Array](#array)
- [Enumerable](#enumerable)
- [General](#general)
- [Hash](#hash)
- [NamedTuple](#namedtuple)
- [Proc & Block](#proc--block)
- [String](#string)

> Test in Crystal 0.27.0 [c9d1eef8f] (2018-11-01)  LLVM: 4.0.0 Default target: x86_64-unknown-linux-gnu 

### Array

#### `first` vs `index[0]` [code](code/array/first-vs-index[0].cr)

```
$ crystal build --release --no-debug -o bin/array/first-vs-index[0] code/array/first-vs-index[0].cr
$ ./bin/array/first-vs-index[0]

Array#first 315.86M (  3.17ns) (± 2.93%)  0 B/op        fastest
  Array#[0] 286.12M (   3.5ns) (± 3.81%)  0 B/op   1.10× slower
```

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
$ crystal build --release --no-debug -o bin/array/insert-vs-unshift code/array/insert-vs-unshift.cr
$ ./bin/array/insert-vs-unshift

 Array#insert   2.08  (481.08ms) (± 2.43%)  1573639 B/op   1.00× slower
Array#unshift   2.09  (479.47ms) (± 0.71%)  1573834 B/op        fastest
```

#### `last` vs `index[-1]` [code](code/array/last-vs-index[-1].cr)

```
$ crystal build --release --no-debug -o bin/array/last-vs-index[-1] code/array/last-vs-index[-1].cr
$ ./bin/array/last-vs-index[-1]

Array#[-1] 319.71M (  3.13ns) (± 3.28%)  0 B/op   1.12× slower
Array#last 359.54M (  2.78ns) (± 2.65%)  0 B/op        fastest
```

#### `range` vs `times.map` [code](code/array/range-vs-times.map.cr)

```
$ crystal build --release --no-debug -o bin/array/range-vs-times.map code/array/range-vs-times.map.cr
$ ./bin/array/range-vs-times.map

Range#to_a   1.43M (697.94ns) (± 4.72%)  1712 B/op        fastest
Times#to_a   1.34M (748.45ns) (± 1.79%)  1728 B/op   1.07× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each-push-vs-map code/enumerable/each-push-vs-map.cr
$ ./bin/enumerable/each-push-vs-map

             Array#map 591.74k (  1.69µs) (± 5.38%)   4048 B/op        fastest
     Array#each + push 181.92k (   5.5µs) (±13.94%)  13008 B/op   3.25× slower
Array#each_with_object 198.22k (  5.04µs) (± 3.97%)  13008 B/op   2.99× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each-vs-loop code/enumerable/each-vs-loop.cr
$ ./bin/enumerable/each-vs-loop

While Loop   6.16M (162.44ns) (± 1.73%)  0 B/op  67.16× slower
     #each 413.46M (  2.42ns) (± 3.14%)  0 B/op        fastest
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each_with_index-vs-while-loop code/enumerable/each_with_index-vs-while-loop.cr
$ ./bin/enumerable/each_with_index-vs-while-loop

     While Loop   7.63M (131.02ns) (± 1.73%)  0 B/op  54.60× slower
each_with_index 416.72M (   2.4ns) (± 2.66%)  0 B/op        fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/map-flatten-vs-flat_map code/enumerable/map-flatten-vs-flat_map.cr
$ ./bin/enumerable/map-flatten-vs-flat_map

   Array#flat_map (Tuple) 984.86k (  1.02µs) (± 2.75%)  3744 B/op        fastest
Array#map.flatten (Tuple) 642.58k (  1.56µs) (±19.91%)  4800 B/op   1.53× slower
   Array#flat_map (Array) 201.88k (  4.95µs) (±17.22%)  7357 B/op   4.88× slower
Array#map.flatten (Array) 185.32k (   5.4µs) (±15.46%)  9622 B/op   5.31× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/reverse.each-vs-reverse_each code/enumerable/reverse.each-vs-reverse_each.cr
$ ./bin/enumerable/reverse.each-vs-reverse_each

Array#reverse.each   3.69M (270.87ns) (±15.54%)  480 B/op  103.72× slower
Array#reverse_each  382.9M (  2.61ns) (± 8.07%)    0 B/op         fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/sort-vs-sort_by code/enumerable/sort-vs-sort_by.cr
$ ./bin/enumerable/sort-vs-sort_by

   Enumerable#sort 119.22k (  8.39µs) (±15.83%)  3136 B/op   1.45× slower
Enumerable#sort_by 172.67k (  5.79µs) (± 4.44%)  1056 B/op        fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
$ crystal build --release --no-debug -o bin/general/assignment code/general/assignment.cr
$ ./bin/general/assignment

Sequential Assignment 482.28M (  2.07ns) (± 4.79%)  0 B/op        fastest
  Parallel Assignment 472.65M (  2.12ns) (± 3.64%)  0 B/op   1.02× slower
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
$ crystal build --release --no-debug -o bin/general/hash-vs-struct-vs-namedtuple code/general/hash-vs-struct-vs-namedtuple.cr
$ ./bin/general/hash-vs-struct-vs-namedtuple

NamedTuple 419.03M (  2.39ns) (± 2.14%)    0 B/op   1.00× slower
    Struct 419.92M (  2.38ns) (± 1.93%)    0 B/op        fastest
      Hash   6.16M ( 162.4ns) (±14.52%)  288 B/op  68.19× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
$ crystal build --release --no-debug -o bin/general/loop-vs-while_true code/general/loop-vs-while_true.cr
$ ./bin/general/loop-vs-while_true

 While Loop 472.45M (  2.12ns) (± 4.31%)  0 B/op   1.00× slower
Kernel Loop 473.31M (  2.11ns) (± 3.74%)  0 B/op        fastest
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
$ crystal build --release --no-debug -o bin/general/positional_argument-vs-named_argument code/general/positional_argument-vs-named_argument.cr
$ ./bin/general/positional_argument-vs-named_argument

     Named arguments 479.43M (  2.09ns) (± 2.37%)  0 B/op        fastest
Positional arguments 474.47M (  2.11ns) (± 3.40%)  0 B/op   1.01× slower
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
$ crystal build --release --no-debug -o bin/general/property-vs-getter_and_setter code/general/property-vs-getter_and_setter.cr
$ ./bin/general/property-vs-getter_and_setter

         property   49.7M ( 20.12ns) (± 8.54%)  32 B/op   1.02× slower
getter_and_setter  50.92M ( 19.64ns) (± 3.84%)  32 B/op        fastest
```

### Hash

#### `[]?` vs `has_key?` [code](code/hash/[]?-vs-has_key?.cr)

```
$ crystal build --release --no-debug -o bin/hash/[]?-vs-has_key? code/hash/[]?-vs-has_key?.cr
$ ./bin/hash/[]?-vs-has_key?

     Hash#[]?  31.85M (  31.4ns) (± 4.91%)  0 B/op   1.03× slower
Hash#has_key?  32.81M ( 30.48ns) (± 2.46%)  0 B/op        fastest
```

#### `bracket` vs `fetch` [code](code/hash/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/hash/bracket-vs-fetch code/hash/bracket-vs-fetch.cr
$ ./bin/hash/bracket-vs-fetch

   NamedTuple#[] 405.21M (  2.47ns) (± 3.18%)  0 B/op        fastest
NamedTuple#fetch  332.9M (   3.0ns) (± 4.41%)  0 B/op   1.22× slower
         Hash#[]   61.9M ( 16.16ns) (± 1.45%)  0 B/op   6.55× slower
      Hash#fetch  63.61M ( 15.72ns) (± 1.99%)  0 B/op   6.37× slower
```

#### `clone` vs `dup` [code](code/hash/clone-vs-dup.cr)

```
$ crystal build --release --no-debug -o bin/hash/clone-vs-dup code/hash/clone-vs-dup.cr
$ ./bin/hash/clone-vs-dup

  Hash#dup   7.37M (135.63ns) (± 4.11%)   480 B/op        fastest
Hash#clone 275.43k (  3.63µs) (± 3.55%)  7334 B/op  26.77× slower
```

#### `keys each` vs `each_key` [code](code/hash/keys-each-vs-each_key.cr)

```
$ crystal build --release --no-debug -o bin/hash/keys-each-vs-each_key code/hash/keys-each-vs-each_key.cr
$ ./bin/hash/keys-each-vs-each_key

Hash#keys.each   5.03M (198.88ns) (± 6.79%)  240 B/op   1.23× slower
 Hash#each_key    6.2M (161.42ns) (± 3.15%)  160 B/op        fastest
```

#### `merge bang` vs `[]=` [code](code/hash/merge-bang-vs-[]=.cr)

```
$ crystal build --release --no-debug -o bin/hash/merge-bang-vs-[]= code/hash/merge-bang-vs-[]=.cr
$ ./bin/hash/merge-bang-vs-[]=

Hash#merge!  56.89k ( 17.58µs) (± 3.64%)  26370 B/op   3.55× slower
   Hash#[]= 202.09k (  4.95µs) (± 3.15%)   5536 B/op        fastest
```

### Namedtuple

#### `bracket` vs `fetch` [code](code/namedtuple/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/namedtuple/bracket-vs-fetch code/namedtuple/bracket-vs-fetch.cr
$ ./bin/namedtuple/bracket-vs-fetch

   NamedTuple#[] 402.06M (  2.49ns) (± 4.59%)  0 B/op        fastest
NamedTuple#fetch 282.35M (  3.54ns) (± 3.38%)  0 B/op   1.42× slower
```

#### `fetch` vs `fetch_with_block` [code](code/namedtuple/fetch-vs-fetch_with_block.cr)

```
$ crystal build --release --no-debug -o bin/namedtuple/fetch-vs-fetch_with_block code/namedtuple/fetch-vs-fetch_with_block.cr
$ ./bin/namedtuple/fetch-vs-fetch_with_block

NamedTuple#fetch + const 264.98M (  3.77ns) (± 3.42%)  0 B/op   1.53× slower
NamedTuple#fetch + block 404.11M (  2.47ns) (± 3.34%)  0 B/op        fastest
  NamedTuple#fetch + arg 335.23M (  2.98ns) (± 4.66%)  0 B/op   1.21× slower
```

### Proc & Block

#### `block` vs `to_proc` [code](code/proc-and-block/block-vs-to_proc.cr)

```
$ crystal build --release --no-debug -o bin/proc-and-block/block-vs-to_proc code/proc-and-block/block-vs-to_proc.cr
$ ./bin/proc-and-block/block-vs-to_proc

         Block 442.81k (  2.26µs) (± 6.76%)  2656 B/op   1.03× slower
Symbol#to_proc 456.94k (  2.19µs) (± 4.43%)  2656 B/op        fastest
```

#### `proc call` vs `yield` [code](code/proc-and-block/proc-call-vs-yield.cr)

```
$ crystal build --release --no-debug -o bin/proc-and-block/proc-call-vs-yield code/proc-and-block/proc-call-vs-yield.cr
$ ./bin/proc-and-block/proc-call-vs-yield

    block.call 483.37M (  2.07ns) (± 4.23%)  0 B/op   1.00× slower
 block + yield 480.75M (  2.08ns) (± 4.91%)  0 B/op   1.01× slower
block argument 415.62M (  2.41ns) (± 2.72%)  0 B/op   1.17× slower
         yield  484.6M (  2.06ns) (± 3.19%)  0 B/op        fastest
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
$ crystal build --release --no-debug -o bin/string/concatenation code/string/concatenation.cr
$ ./bin/string/concatenation

 String#+  51.85M ( 19.29ns) (± 5.05%)   32 B/op        fastest
String#{}  10.14M ( 98.65ns) (± 4.65%)  208 B/op   5.12× slower
 String#%   5.68M (175.97ns) (± 4.66%)  176 B/op   9.12× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
$ crystal build --release --no-debug -o bin/string/ends-string-matching-match-vs-end_with code/string/ends-string-matching-match-vs-end_with.cr
$ ./bin/string/ends-string-matching-match-vs-end_with

String#end_with? 275.03M (  3.64ns) (± 3.17%)   0 B/op        fastest
       String#=~   9.57M ( 104.5ns) (± 4.85%)  16 B/op  28.74× slower
```

#### Equal-substring-of-char [code](code/string/equal-substring-of-char.cr)

```
$ crystal build --release --no-debug -o bin/string/equal-substring-of-char code/string/equal-substring-of-char.cr
$ ./bin/string/equal-substring-of-char

         "==="[0] == '=' 211.24M (  4.73ns) (± 5.03%)   0 B/op        fastest
    "==="[0].to_s == "="  25.83M ( 38.72ns) (± 5.83%)  48 B/op   8.18× slower
"==="[0] == "=".chars[0]  29.16M ( 34.29ns) (± 7.24%)  48 B/op   7.24× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
$ crystal build --release --no-debug -o bin/string/equal-vs-match code/string/equal-vs-match.cr
$ ./bin/string/equal-vs-match

String#match  14.78M ( 67.64ns) (± 8.88%)  16 B/op   1.04× slower
  Regexp#===  15.34M ( 65.18ns) (± 5.81%)  16 B/op        fastest
   String#=~  14.31M ( 69.87ns) (± 6.54%)  16 B/op   1.07× slower
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
$ crystal build --release --no-debug -o bin/string/gsub-vs-sub code/string/gsub-vs-sub.cr
$ ./bin/string/gsub-vs-sub

 String#sub   3.65M (273.64ns) (±17.12%)  1248 B/op        fastest
String#gsub   1.36M ( 733.4ns) (± 8.04%)  1248 B/op   2.68× slower
```

#### `includes` vs `to_s.includes` [code](code/string/includes-vs-to_s.includes.cr)

```
$ crystal build --release --no-debug -o bin/string/includes-vs-to_s.includes code/string/includes-vs-to_s.includes.cr
$ ./bin/string/includes-vs-to_s.includes

  String#includes? 476.45M (   2.1ns) (± 4.69%)  0 B/op   1.01× slower
Nil#to_s#includes? 482.24M (  2.07ns) (± 3.85%)  0 B/op        fastest
```

#### `nil` vs `to_s.empty` [code](code/string/nil-vs-to_s.empty.cr)

```
$ crystal build --release --no-debug -o bin/string/nil-vs-to_s.empty code/string/nil-vs-to_s.empty.cr
$ ./bin/string/nil-vs-to_s.empty

    String#nil? 486.03M (  2.06ns) (± 2.80%)  0 B/op        fastest
Nil#to_s#empty? 485.69M (  2.06ns) (± 3.11%)  0 B/op   1.00× slower
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
$ crystal build --release --no-debug -o bin/string/sub-vs-chomp code/string/sub-vs-chomp.cr
$ ./bin/string/sub-vs-chomp

String#chomp"string"  46.49M ( 21.51ns) (±15.88%)   32 B/op        fastest
  String#sub/regexp/   4.08M (244.86ns) (±14.63%)  176 B/op  11.38× slower
```

## You may also like

- [halite](https://github.com/icyleaf/halite) - HTTP Requests Client with a chainable REST API, built-in sessions and middlewares.
- [totem](https://github.com/icyleaf/totem) - Load and parse a configuration file or string in JSON, YAML, dotenv formats.
- [markd](https://github.com/icyleaf/markd) - Yet another markdown parser built for speed, Compliant to CommonMark specification.
- [poncho](https://github.com/icyleaf/poncho) - A .env parser/loader improved for performance.
- [popcorn](https://github.com/icyleaf/popcorn) - Easy and Safe casting from one type to another.
