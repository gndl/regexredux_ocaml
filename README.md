 regexredux_ocaml

## Compilation :
$ make all

## Execution :
$ ./run.sh

## Results (in seconds) :

| Impl | sequential | parallel |
|------|------------|----------|
| Str | 12 | 7 |
| Pcre | 14 | 9 |
| Re.Str | 7 | 6 |
| Re | 3,4 | 2 |


## With variants counting parallelization (parallel count) :

| Impl | sequential | parallel | parallel count |
|------|------------|----------|----------------|
| Pcre | 15 | 10 | 7.3 |
| Pcre JIT | 6.1 | 4.4 | 4.3 |
| Re | 3.8 | 2.3 | 2.25 |
