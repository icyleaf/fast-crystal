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

> Test in Crystal 0.25.0 (2018-06-15)  LLVM: 5.0.1 Default target: x86_64-apple-macosx

### Array

#### `first` vs `index[0]` [code](code/array/first-vs-index[0].cr)

```
$ crystal build --release --no-debug -o bin/array/first-vs-index[0] code/array/first-vs-index[0].cr
$ ./bin/array/first-vs-index[0]

Array#first 368.47M (  2.71ns) (±10.26%)  0 B/op   1.04× slower
  Array#[0] 383.65M (  2.61ns) (± 5.54%)  0 B/op        fastest
```

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
$ crystal build --release --no-debug -o bin/array/insert-vs-unshift code/array/insert-vs-unshift.cr
$ ./bin/array/insert-vs-unshift

 Array#insert   1.33  ( 752.4ms) (± 1.19%)  1573696 B/op   1.00× slower
Array#unshift   1.33  ( 750.3ms) (± 0.34%)  1574201 B/op        fastest
```

#### `last` vs `index[-1]` [code](code/array/last-vs-index[-1].cr)

```
$ crystal build --release --no-debug -o bin/array/last-vs-index[-1] code/array/last-vs-index[-1].cr
$ ./bin/array/last-vs-index[-1]

Array#[-1]  355.5M (  2.81ns) (±13.59%)  0 B/op   1.03× slower
Array#last 365.22M (  2.74ns) (± 8.70%)  0 B/op        fastest
```

#### `range` vs `times.map` [code](code/array/range-vs-times.map.cr)

```
$ crystal build --release --no-debug -o bin/array/range-vs-times.map code/array/range-vs-times.map.cr
$ ./bin/array/range-vs-times.map

Range#to_a 589.87k (   1.7µs) (± 4.76%)  1712 B/op        fastest
Times#to_a 568.61k (  1.76µs) (± 9.24%)  1728 B/op   1.04× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each-push-vs-map code/enumerable/each-push-vs-map.cr
$ ./bin/enumerable/each-push-vs-map

             Array#map 140.99k (  7.09µs) (±10.03%)   4048 B/op        fastest
     Array#each + push  87.84k ( 11.38µs) (± 7.25%)  13008 B/op   1.61× slower
Array#each_with_object  86.59k ( 11.55µs) (± 3.14%)  13008 B/op   1.63× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each-vs-loop code/enumerable/each-vs-loop.cr
$ ./bin/enumerable/each-vs-loop

While Loop   6.98M (143.28ns) (± 3.03%)  0 B/op  62.13× slower
     #each  433.6M (  2.31ns) (± 7.71%)  0 B/op        fastest
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/each_with_index-vs-while-loop code/enumerable/each_with_index-vs-while-loop.cr
$ ./bin/enumerable/each_with_index-vs-while-loop

     While Loop    8.1M (123.43ns) (± 5.02%)  0 B/op  44.60× slower
each_with_index 361.34M (  2.77ns) (± 6.85%)  0 B/op        fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/map-flatten-vs-flat_map code/enumerable/map-flatten-vs-flat_map.cr
$ ./bin/enumerable/map-flatten-vs-flat_map

   Array#flat_map (Tuple) 289.77k (  3.45µs) (± 5.90%)  3744 B/op        fastest
Array#map.flatten (Tuple) 183.04k (  5.46µs) (± 9.06%)  4800 B/op   1.58× slower
   Array#flat_map (Array)  88.58k ( 11.29µs) (± 3.29%)  7354 B/op   3.27× slower
Array#map.flatten (Array)  70.09k ( 14.27µs) (± 5.71%)  9616 B/op   4.13× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/reverse.each-vs-reverse_each code/enumerable/reverse.each-vs-reverse_each.cr
$ ./bin/enumerable/reverse.each-vs-reverse_each

Array#reverse.each   1.45M (688.84ns) (± 9.08%)  480 B/op  302.88× slower
Array#reverse_each  439.7M (  2.27ns) (± 5.99%)    0 B/op         fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
$ crystal build --release --no-debug -o bin/enumerable/sort-vs-sort_by code/enumerable/sort-vs-sort_by.cr
$ ./bin/enumerable/sort-vs-sort_by

   Enumerable#sort  98.98k (  10.1µs) (± 5.84%)  3136 B/op   1.36× slower
Enumerable#sort_by 134.82k (  7.42µs) (±10.55%)  1056 B/op        fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
$ crystal build --release --no-debug -o bin/general/assignment code/general/assignment.cr
$ ./bin/general/assignment

Sequential Assignment 487.77M (  2.05ns) (± 7.82%)  0 B/op        fastest
  Parallel Assignment 472.07M (  2.12ns) (±10.79%)  0 B/op   1.03× slower
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
$ crystal build --release --no-debug -o bin/general/hash-vs-struct-vs-namedtuple code/general/hash-vs-struct-vs-namedtuple.cr
$ ./bin/general/hash-vs-struct-vs-namedtuple

NamedTuple 479.95M (  2.08ns) (± 8.24%)    0 B/op         fastest
    Struct 476.01M (   2.1ns) (± 9.78%)    0 B/op    1.01× slower
      Hash    1.7M (588.98ns) (±10.68%)  290 B/op  282.68× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
$ crystal build --release --no-debug -o bin/general/loop-vs-while_true code/general/loop-vs-while_true.cr
$ ./bin/general/loop-vs-while_true

 While Loop 479.57M (  2.09ns) (±10.34%)  0 B/op        fastest
Kernel Loop 475.76M (   2.1ns) (± 9.50%)  0 B/op   1.01× slower
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
$ crystal build --release --no-debug -o bin/general/positional_argument-vs-named_argument code/general/positional_argument-vs-named_argument.cr
$ ./bin/general/positional_argument-vs-named_argument

     Named arguments 494.42M (  2.02ns) (± 8.04%)  0 B/op        fastest
Positional arguments 493.99M (  2.02ns) (± 7.70%)  0 B/op   1.00× slower
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
$ crystal build --release --no-debug -o bin/general/property-vs-getter_and_setter code/general/property-vs-getter_and_setter.cr
$ ./bin/general/property-vs-getter_and_setter

         property  14.92M ( 67.03ns) (±11.02%)  32 B/op        fastest
getter_and_setter  14.17M ( 70.58ns) (± 9.49%)  32 B/op   1.05× slower
```

### Hash

#### `bracket` vs `fetch` [code](code/hash/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/hash/bracket-vs-fetch code/hash/bracket-vs-fetch.cr
$ ./bin/hash/bracket-vs-fetch

   NamedTuple#[] 426.67M (  2.34ns) (± 7.66%)  0 B/op        fastest
NamedTuple#fetch 360.26M (  2.78ns) (± 7.07%)  0 B/op   1.18× slower
         Hash#[]   56.2M ( 17.79ns) (± 3.55%)  0 B/op   7.59× slower
      Hash#fetch  55.44M ( 18.04ns) (± 6.82%)  0 B/op   7.70× slower
```

#### `clone` vs `dup` [code](code/hash/clone-vs-dup.cr)

```
$ crystal build --release --no-debug -o bin/hash/clone-vs-dup code/hash/clone-vs-dup.cr
$ ./bin/hash/clone-vs-dup

  Hash#dup   1.48M (677.85ns) (± 4.39%)   480 B/op        fastest
Hash#clone  85.93k ( 11.64µs) (± 6.74%)  7381 B/op  17.17× slower
```

#### `keys each` vs `each_key` [code](code/hash/keys-each-vs-each_key.cr)

```
$ crystal build --release --no-debug -o bin/hash/keys-each-vs-each_key code/hash/keys-each-vs-each_key.cr
$ ./bin/hash/keys-each-vs-each_key

Hash#keys.each   1.99M (501.85ns) (± 5.25%)  241 B/op   1.48× slower
 Hash#each_key   2.95M (339.15ns) (± 5.14%)  161 B/op        fastest
```

#### `merge bang` vs `[]=` [code](code/hash/merge-bang-vs-[]=.cr)

```
$ crystal build --release --no-debug -o bin/hash/merge-bang-vs-[]= code/hash/merge-bang-vs-[]=.cr
$ ./bin/hash/merge-bang-vs-[]=

Hash#merge!  22.39k ( 44.66µs) (± 9.81%)  26364 B/op   4.01× slower
   Hash#[]=  89.73k ( 11.14µs) (± 3.62%)   5549 B/op        fastest
```

### Namedtuple

#### `bracket` vs `fetch` [code](code/namedtuple/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/namedtuple/bracket-vs-fetch code/namedtuple/bracket-vs-fetch.cr
$ ./bin/namedtuple/bracket-vs-fetch

   NamedTuple#[] 435.05M (   2.3ns) (± 7.49%)  0 B/op        fastest
NamedTuple#fetch 322.33M (   3.1ns) (±13.36%)  0 B/op   1.35× slower
```

#### `fetch` vs `fetch_with_block` [code](code/namedtuple/fetch-vs-fetch_with_block.cr)

```
$ crystal build --release --no-debug -o bin/namedtuple/fetch-vs-fetch_with_block code/namedtuple/fetch-vs-fetch_with_block.cr
$ ./bin/namedtuple/fetch-vs-fetch_with_block

NamedTuple#fetch + const 427.08M (  2.34ns) (± 8.51%)  0 B/op        fastest
NamedTuple#fetch + block 420.77M (  2.38ns) (± 8.93%)  0 B/op   1.01× slower
  NamedTuple#fetch + arg 334.62M (  2.99ns) (± 8.73%)  0 B/op   1.28× slower
```

### Proc & Block

#### `block` vs `to_proc` [code](code/proc-and-block/block-vs-to_proc.cr)

```
$ crystal build --release --no-debug -o bin/proc-and-block/block-vs-to_proc code/proc-and-block/block-vs-to_proc.cr
$ ./bin/proc-and-block/block-vs-to_proc

         Block 204.07k (   4.9µs) (± 6.94%)  2656 B/op        fastest
Symbol#to_proc 201.83k (  4.95µs) (± 6.60%)  2656 B/op   1.01× slower
```

#### `proc call` vs `yield` [code](code/proc-and-block/proc-call-vs-yield.cr)

```
$ crystal build --release --no-debug -o bin/proc-and-block/proc-call-vs-yield code/proc-and-block/proc-call-vs-yield.cr
$ ./bin/proc-and-block/proc-call-vs-yield

    block.call 488.06M (  2.05ns) (± 8.06%)  0 B/op   1.06× slower
 block + yield 488.88M (  2.05ns) (± 9.62%)  0 B/op   1.05× slower
block argument 505.16M (  1.98ns) (± 8.63%)  0 B/op   1.02× slower
         yield 515.03M (  1.94ns) (± 6.76%)  0 B/op        fastest
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
$ crystal build --release --no-debug -o bin/string/concatenation code/string/concatenation.cr
$ ./bin/string/concatenation

 String#+  19.77M ( 50.59ns) (±12.91%)   32 B/op        fastest
String#{}   4.12M (242.65ns) (±12.66%)  208 B/op   4.80× slower
 String#%    2.8M (357.52ns) (± 7.26%)  178 B/op   7.07× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
$ crystal build --release --no-debug -o bin/string/ends-string-matching-match-vs-end_with code/string/ends-string-matching-match-vs-end_with.cr
$ ./bin/string/ends-string-matching-match-vs-end_with

String#end_with? 424.08M (  2.36ns) (± 6.47%)   0 B/op        fastest
       String#=~   6.89M (145.21ns) (± 7.25%)  16 B/op  61.58× slower
```

#### Equal-substring-of-char [code](code/string/equal-substring-of-char.cr)

```
$ crystal build --release --no-debug -o bin/string/equal-substring-of-char code/string/equal-substring-of-char.cr
$ ./bin/string/equal-substring-of-char

         "==="[0] == '=' 219.04M (  4.57ns) (± 9.31%)   0 B/op        fastest
    "==="[0].to_s == "="  15.85M ( 63.11ns) (± 4.95%)  48 B/op  13.82× slower
"==="[0] == "=".chars[0]  10.79M ( 92.72ns) (±12.59%)  49 B/op  20.31× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
$ crystal build --release --no-debug -o bin/string/equal-vs-match code/string/equal-vs-match.cr
$ ./bin/string/equal-vs-match

String#match  11.87M ( 84.22ns) (± 6.21%)  16 B/op   1.01× slower
  Regexp#===  12.03M (  83.1ns) (± 4.86%)  16 B/op        fastest
   String#=~  11.49M (  87.0ns) (±11.96%)  16 B/op   1.05× slower
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
$ crystal build --release --no-debug -o bin/string/gsub-vs-sub code/string/gsub-vs-sub.cr
$ ./bin/string/gsub-vs-sub

 String#sub   1.45M (687.91ns) (±12.84%)  1249 B/op        fastest
String#gsub 832.46k (   1.2µs) (±11.36%)  1249 B/op   1.75× slower
```

#### `includes` vs `to_s.includes` [code](code/string/includes-vs-to_s.includes.cr)

```
$ crystal build --release --no-debug -o bin/string/includes-vs-to_s.includes code/string/includes-vs-to_s.includes.cr
$ ./bin/string/includes-vs-to_s.includes

  String#includes?  504.9M (  1.98ns) (± 6.53%)  0 B/op        fastest
Nil#to_s#includes? 474.74M (  2.11ns) (±10.20%)  0 B/op   1.06× slower
```

#### `nil` vs `to_s.empty` [code](code/string/nil-vs-to_s.empty.cr)

```
$ crystal build --release --no-debug -o bin/string/nil-vs-to_s.empty code/string/nil-vs-to_s.empty.cr
$ ./bin/string/nil-vs-to_s.empty

    String#nil? 479.32M (  2.09ns) (±10.85%)  0 B/op   1.01× slower
Nil#to_s#empty?  484.3M (  2.06ns) (± 9.86%)  0 B/op        fastest
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
$ crystal build --release --no-debug -o bin/string/sub-vs-chomp code/string/sub-vs-chomp.cr
$ ./bin/string/sub-vs-chomp

String#chomp"string"  17.99M ( 55.58ns) (± 5.03%)   32 B/op        fastest
  String#sub/regexp/   2.27M (441.31ns) (± 4.08%)  176 B/op   7.94× slower
```

## You may also like

- [halite](https://github.com/icyleaf/halite) - HTTP Requests Client with a chainable REST API, built-in sessions and loggers.
- [totem](https://github.com/icyleaf/totem) - Load and parse a configuration file or string in JSON, YAML, dotenv formats.
- [markd](https://github.com/icyleaf/markd) - Yet another markdown parser built for speed, Compliant to CommonMark specification.
- [poncho](https://github.com/icyleaf/poncho) - A .env parser/loader improved for performance.
- [popcorn](https://github.com/icyleaf/popcorn) - Easy and Safe casting from one type to another.
- [fast-crystal](https://github.com/icyleaf/fast-crystal) - 💨 Writing Fast Crystal 😍 -- Collect Common Crystal idioms.
