default: run

dep:
	opam install -y re

fasta.ocaml-6.ocaml_run:
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 unix.cmxa -ccopt -march=ivybridge fasta.ocaml-6.ml -o $@

fasta_data.txt: fasta.ocaml-6.ocaml_run
	./fasta.ocaml-6.ocaml_run 5000000 > $@

regexredux.ocaml-3.ocaml_run: dep
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I $(OPAM_SWITCH_PREFIX)/lib/re unix.cmxa re.cmxa -ccopt -march=ivybridge regexredux.ocaml-3.ml -o $@

run: regexredux.ocaml-3.ocaml_run fasta_data.txt
	time ./regexredux.ocaml-3.ocaml_run 0 < fasta_data.txt

fasta: fasta.ocaml-6.ocaml_run

build: regexredux.ocaml-3.ocaml_run

dbg: regexredux.ocaml-3.ocaml_run fasta_data.txt
	ocamldebug ./regexredux.ocaml-3.ocaml_run 0 < fasta_data.txt

gdb: regexredux.ocaml-3.ocaml_run fasta_data.txt
	gdb -q -ex 'set args < fasta_data.txt' ./regexredux.ocaml-3.ocaml_run

clean:
	git clean -dfXq
