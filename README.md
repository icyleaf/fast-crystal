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

> Test in Crystal 0.35.1 (2020-06-19)  LLVM: 10.0.0 Default target: x86_64-apple-macosx

### Array

#### `first` vs `index[0]` [code](code/array/first-vs-index[0].cr)

```
$ crystal build --release --no-debug -o bin/code/array/first-vs-index[0] code/array/first-vs-index[0].cr
$ ./bin/code/array/first-vs-index[0]

Array#first 265.31M (  3.77ns) (±11.17%)  0.0B/op   1.01× slower
  Array#[0] 267.85M (  3.73ns) (± 6.86%)  0.0B/op        fastest
```

#### `insert` vs `unshift` [code](code/array/insert-vs-unshift.cr)

```
$ crystal build --release --no-debug -o bin/code/array/insert-vs-unshift code/array/insert-vs-unshift.cr
$ ./bin/code/array/insert-vs-unshift

 Array#insert   1.30  (768.66ms) (± 1.33%)  1.5MB/op        fastest
Array#unshift   1.29  (775.05ms) (± 1.81%)  1.5MB/op   1.01× slower
```

#### `last` vs `index[-1]` [code](code/array/last-vs-index[-1].cr)

```
$ crystal build --release --no-debug -o bin/code/array/last-vs-index[-1] code/array/last-vs-index[-1].cr
$ ./bin/code/array/last-vs-index[-1]

Array#[-1] 273.97M (  3.65ns) (± 4.16%)  0.0B/op        fastest
Array#last 273.61M (  3.65ns) (± 4.75%)  0.0B/op   1.00× slower
```

#### `range` vs `times.map` [code](code/array/range-vs-times.map.cr)

```
$ crystal build --release --no-debug -o bin/code/array/range-vs-times.map code/array/range-vs-times.map.cr
$ ./bin/code/array/range-vs-times.map

Range#to_a   1.11M (897.91ns) (±17.84%)  1.67kB/op        fastest
Times#to_a   1.02M (980.17ns) (±17.56%)  1.69kB/op   1.09× slower
```

### Enumerable

#### `each push` vs `map` [code](code/enumerable/each-push-vs-map.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/each-push-vs-map code/enumerable/each-push-vs-map.cr
$ ./bin/code/enumerable/each-push-vs-map

             Array#map 507.91k (  1.97µs) (±11.92%)  3.96kB/op        fastest
     Array#each + push 145.04k (  6.89µs) (±18.89%)  12.7kB/op   3.50× slower
Array#each_with_object 155.85k (  6.42µs) (±17.07%)  12.7kB/op   3.26× slower
```

#### `each` vs `loop` [code](code/enumerable/each-vs-loop.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/each-vs-loop code/enumerable/each-vs-loop.cr
$ ./bin/code/enumerable/each-vs-loop

While Loop   1.64M (609.64ns) (± 7.66%)  0.0B/op  159.20× slower
     #each 261.15M (  3.83ns) (±10.82%)  0.0B/op         fastest
```

#### `each_with_index` vs `while loop` [code](code/enumerable/each_with_index-vs-while-loop.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/each_with_index-vs-while-loop code/enumerable/each_with_index-vs-while-loop.cr
$ ./bin/code/enumerable/each_with_index-vs-while-loop

     While Loop   1.51M (661.13ns) (± 9.29%)  0.0B/op   6.94× slower
each_with_index  10.50M ( 95.23ns) (±17.95%)  0.0B/op        fastest
```

#### `map flatten` vs `flat_map` [code](code/enumerable/map-flatten-vs-flat_map.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/map-flatten-vs-flat_map code/enumerable/map-flatten-vs-flat_map.cr
$ ./bin/code/enumerable/map-flatten-vs-flat_map

   Array#flat_map (Tuple) 902.86k (  1.11µs) (± 6.63%)  3.65kB/op        fastest
Array#map.flatten (Tuple) 664.00k (  1.51µs) (± 6.00%)  4.69kB/op   1.36× slower
   Array#flat_map (Array) 238.37k (  4.20µs) (± 5.73%)  7.18kB/op   3.79× slower
Array#map.flatten (Array) 193.64k (  5.16µs) (± 3.78%)  9.39kB/op   4.66× slower
```

#### `reverse.each` vs `reverse_each` [code](code/enumerable/reverse.each-vs-reverse_each.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/reverse.each-vs-reverse_each code/enumerable/reverse.each-vs-reverse_each.cr
$ ./bin/code/enumerable/reverse.each-vs-reverse_each

Array#reverse.each   4.03M (248.39ns) (± 5.02%)  480B/op   4.94× slower
Array#reverse_each  19.88M ( 50.30ns) (± 2.49%)  0.0B/op        fastest
```

#### `sort` vs `sort_by` [code](code/enumerable/sort-vs-sort_by.cr)

```
$ crystal build --release --no-debug -o bin/code/enumerable/sort-vs-sort_by code/enumerable/sort-vs-sort_by.cr
$ ./bin/code/enumerable/sort-vs-sort_by

   Enumerable#sort 145.32k (  6.88µs) (± 2.89%)  3.07kB/op   1.17× slower
Enumerable#sort_by 170.71k (  5.86µs) (± 4.47%)  1.04kB/op        fastest
```

### General

#### Assignment [code](code/general/assignment.cr)

```
$ crystal build --release --no-debug -o bin/code/general/assignment code/general/assignment.cr
$ ./bin/code/general/assignment

Sequential Assignment 611.21M (  1.64ns) (± 4.98%)  0.0B/op   1.00× slower
  Parallel Assignment 613.61M (  1.63ns) (± 5.04%)  0.0B/op        fastest
```

#### `hash` vs `struct` vs `namedtuple` [code](code/general/hash-vs-struct-vs-namedtuple.cr)

```
$ crystal build --release --no-debug -o bin/code/general/hash-vs-struct-vs-namedtuple code/general/hash-vs-struct-vs-namedtuple.cr
$ ./bin/code/general/hash-vs-struct-vs-namedtuple

NamedTuple 515.36M (  1.94ns) (± 4.05%)  0.0B/op        fastest
    Struct 503.85M (  1.98ns) (± 6.54%)  0.0B/op   1.02× slower
      Hash   9.60M (104.18ns) (± 2.76%)  208B/op  53.69× slower
```

#### `loop` vs `while_true` [code](code/general/loop-vs-while_true.cr)

```
$ crystal build --release --no-debug -o bin/code/general/loop-vs-while_true code/general/loop-vs-while_true.cr
$ ./bin/code/general/loop-vs-while_true

 While Loop 512.11M (  1.95ns) (± 5.15%)  0.0B/op        fastest
Kernel Loop 482.98M (  2.07ns) (±16.94%)  0.0B/op   1.06× slower
```

#### `positional_argument` vs `named_argument` [code](code/general/positional_argument-vs-named_argument.cr)

```
$ crystal build --release --no-debug -o bin/code/general/positional_argument-vs-named_argument code/general/positional_argument-vs-named_argument.cr
$ ./bin/code/general/positional_argument-vs-named_argument

     Named arguments 564.18M (  1.77ns) (±16.11%)  0.0B/op   1.03× slower
Positional arguments 578.90M (  1.73ns) (±10.46%)  0.0B/op        fastest
```

#### `property` vs `getter_and_setter` [code](code/general/property-vs-getter_and_setter.cr)

```
$ crystal build --release --no-debug -o bin/code/general/property-vs-getter_and_setter code/general/property-vs-getter_and_setter.cr
$ ./bin/code/general/property-vs-getter_and_setter

         property  50.89M ( 19.65ns) (± 5.34%)  32.0B/op        fastest
getter_and_setter  49.68M ( 20.13ns) (± 7.27%)  32.0B/op   1.02× slower
```

### Hash

#### `[]?` vs `has_key?` [code](code/hash/[]?-vs-has_key?.cr)

```
$ crystal build --release --no-debug -o bin/code/hash/[]?-vs-has_key? code/hash/[]?-vs-has_key?.cr
$ ./bin/code/hash/[]?-vs-has_key?

     Hash#[]?  41.12M ( 24.32ns) (±12.09%)  0.0B/op   1.01× slower
Hash#has_key?  41.48M ( 24.11ns) (± 8.25%)  0.0B/op        fastest
```

#### `bracket` vs `fetch` [code](code/hash/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/code/hash/bracket-vs-fetch code/hash/bracket-vs-fetch.cr
$ ./bin/code/hash/bracket-vs-fetch

   Hash#[]  95.60M ( 10.46ns) (± 6.16%)  0.0B/op   1.02× slower
Hash#fetch  97.08M ( 10.30ns) (± 9.36%)  0.0B/op        fastest
```

#### `clone` vs `dup` [code](code/hash/clone-vs-dup.cr)

```
$ crystal build --release --no-debug -o bin/code/hash/clone-vs-dup code/hash/clone-vs-dup.cr
$ ./bin/code/hash/clone-vs-dup

  Hash#dup   5.39M (185.50ns) (±17.96%)    480B/op        fastest
Hash#clone 293.35k (  3.41µs) (±10.17%)  5.94kB/op  18.38× slower
```

#### `keys each` vs `each_key` [code](code/hash/keys-each-vs-each_key.cr)

```
$ crystal build --release --no-debug -o bin/code/hash/keys-each-vs-each_key code/hash/keys-each-vs-each_key.cr
$ ./bin/code/hash/keys-each-vs-each_key

Hash#keys.each   4.25M (235.11ns) (± 8.09%)  240B/op   1.11× slower
 Hash#each_key   4.71M (212.43ns) (±22.16%)  160B/op        fastest
```

#### `merge bang` vs `[]=` [code](code/hash/merge-bang-vs-[]=.cr)

```
$ crystal build --release --no-debug -o bin/code/hash/merge-bang-vs-[]= code/hash/merge-bang-vs-[]=.cr
$ ./bin/code/hash/merge-bang-vs-[]=

Hash#merge!  67.40k ( 14.84µs) (±23.77%)  16.6kB/op   4.19× slower
   Hash#[]= 282.73k (  3.54µs) (±21.37%)  4.14kB/op        fastest
```

### Namedtuple

#### `bracket` vs `fetch` [code](code/namedtuple/bracket-vs-fetch.cr)

```
$ crystal build --release --no-debug -o bin/code/namedtuple/bracket-vs-fetch code/namedtuple/bracket-vs-fetch.cr
$ ./bin/code/namedtuple/bracket-vs-fetch

   NamedTuple#[] 294.37M (  3.40ns) (±19.52%)  0.0B/op   1.00× slower
NamedTuple#fetch 295.49M (  3.38ns) (±19.80%)  0.0B/op        fastest
```

#### `fetch` vs `fetch_with_block` [code](code/namedtuple/fetch-vs-fetch_with_block.cr)

```
$ crystal build --release --no-debug -o bin/code/namedtuple/fetch-vs-fetch_with_block code/namedtuple/fetch-vs-fetch_with_block.cr
$ ./bin/code/namedtuple/fetch-vs-fetch_with_block

NamedTuple#fetch + const 168.24M (  5.94ns) (± 6.53%)  0.0B/op   1.81× slower
NamedTuple#fetch + block 304.53M (  3.28ns) (± 4.50%)  0.0B/op        fastest
  NamedTuple#fetch + arg 296.07M (  3.38ns) (± 6.99%)  0.0B/op   1.03× slower
```

### Proc & Block

#### `block` vs `to_proc` [code](code/proc-and-block/block-vs-to_proc.cr)

```
$ crystal build --release --no-debug -o bin/code/proc-and-block/block-vs-to_proc code/proc-and-block/block-vs-to_proc.cr
$ ./bin/code/proc-and-block/block-vs-to_proc

         Block 331.06k (  3.02µs) (±13.18%)  2.6kB/op   1.10× slower
Symbol#to_proc 362.78k (  2.76µs) (± 5.27%)  2.6kB/op        fastest
```

#### `proc call` vs `yield` [code](code/proc-and-block/proc-call-vs-yield.cr)

```
$ crystal build --release --no-debug -o bin/code/proc-and-block/proc-call-vs-yield code/proc-and-block/proc-call-vs-yield.cr
$ ./bin/code/proc-and-block/proc-call-vs-yield

    block.call 513.72M (  1.95ns) (± 4.51%)  0.0B/op        fastest
 block + yield 501.67M (  1.99ns) (± 7.25%)  0.0B/op   1.02× slower
block argument 512.94M (  1.95ns) (± 5.41%)  0.0B/op   1.00× slower
         yield 482.96M (  2.07ns) (±15.43%)  0.0B/op   1.06× slower
```

### String

#### Concatenation [code](code/string/concatenation.cr)

```
$ crystal build --release --no-debug -o bin/code/string/concatenation code/string/concatenation.cr
$ ./bin/code/string/concatenation

 String#+  44.62M ( 22.41ns) (± 8.00%)  32.0B/op        fastest
String#{}  23.68M ( 42.22ns) (±16.74%)  32.0B/op   1.88× slower
 String#%   4.28M (233.43ns) (±20.03%)   176B/op  10.41× slower
```

#### `ends string-matching-match` vs `end_with` [code](code/string/ends-string-matching-match-vs-end_with.cr)

```
$ crystal build --release --no-debug -o bin/code/string/ends-string-matching-match-vs-end_with code/string/ends-string-matching-match-vs-end_with.cr
$ ./bin/code/string/ends-string-matching-match-vs-end_with

String#end_with? 238.71M (  4.19ns) (±11.61%)   0.0B/op        fastest
       String#=~   7.93M (126.04ns) (± 4.61%)  16.0B/op  30.09× slower
```

#### Equal-substring-of-char [code](code/string/equal-substring-of-char.cr)

```
$ crystal build --release --no-debug -o bin/code/string/equal-substring-of-char code/string/equal-substring-of-char.cr
$ ./bin/code/string/equal-substring-of-char

         "==="[0] == '=' 298.29M (  3.35ns) (± 7.06%)   0.0B/op        fastest
    "==="[0].to_s == "="  23.29M ( 42.94ns) (± 6.52%)  48.0B/op  12.81× slower
"==="[0] == "=".chars[0]  27.62M ( 36.21ns) (± 4.66%)  48.0B/op  10.80× slower
```

#### `equal` vs `match` [code](code/string/equal-vs-match.cr)

```
$ crystal build --release --no-debug -o bin/code/string/equal-vs-match code/string/equal-vs-match.cr
$ ./bin/code/string/equal-vs-match

String#match  15.00M ( 66.65ns) (± 8.74%)  16.0B/op   1.02× slower
  Regexp#===  15.32M ( 65.27ns) (± 9.61%)  16.0B/op        fastest
   String#=~  14.67M ( 68.17ns) (± 8.60%)  16.0B/op   1.04× slower
```

#### `gsub` vs `sub` [code](code/string/gsub-vs-sub.cr)

```
$ crystal build --release --no-debug -o bin/code/string/gsub-vs-sub code/string/gsub-vs-sub.cr
$ ./bin/code/string/gsub-vs-sub

 String#sub   3.67M (272.77ns) (± 5.43%)  1.22kB/op        fastest
String#gsub   1.37M (728.87ns) (± 4.13%)  1.22kB/op   2.67× slower
```

#### `includes` vs `to_s.includes` [code](code/string/includes-vs-to_s.includes.cr)

```
$ crystal build --release --no-debug -o bin/code/string/includes-vs-to_s.includes code/string/includes-vs-to_s.includes.cr
$ ./bin/code/string/includes-vs-to_s.includes

  String#includes? 368.22M (  2.72ns) (± 8.30%)  0.0B/op   1.02× slower
Nil#to_s#includes? 376.21M (  2.66ns) (± 6.76%)  0.0B/op        fastest
```

#### `nil` vs `to_s.empty` [code](code/string/nil-vs-to_s.empty.cr)

```
$ crystal build --release --no-debug -o bin/code/string/nil-vs-to_s.empty code/string/nil-vs-to_s.empty.cr
$ ./bin/code/string/nil-vs-to_s.empty

    String#nil? 468.25M (  2.14ns) (±14.49%)  0.0B/op        fastest
Nil#to_s#empty? 450.24M (  2.22ns) (±14.74%)  0.0B/op   1.04× slower
```

#### `sub` vs `chomp` [code](code/string/sub-vs-chomp.cr)

```
$ crystal build --release --no-debug -o bin/code/string/sub-vs-chomp code/string/sub-vs-chomp.cr
$ ./bin/code/string/sub-vs-chomp

String#chomp"string"  43.85M ( 22.81ns) (±12.35%)  32.0B/op        fastest
  String#sub/regexp/   3.57M (280.13ns) (± 5.92%)   176B/op  12.28× slower
```

## You may also like

- [halite](https://github.com/icyleaf/halite) - HTTP Requests Client with a chainable REST API, built-in sessions and middlewares.
- [totem](https://github.com/icyleaf/totem) - Load and parse a configuration file or string in JSON, YAML, dotenv formats.
- [markd](https://github.com/icyleaf/markd) - Yet another markdown parser built for speed, Compliant to CommonMark specification.
- [poncho](https://github.com/icyleaf/poncho) - A .env parser/loader improved for performance.
- [popcorn](https://github.com/icyleaf/popcorn) - Easy and Safe casting from one type to another.
