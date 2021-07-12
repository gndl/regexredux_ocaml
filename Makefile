all: str pcre re_str re_pcre_core regexredux.ocaml

re_dep:
	opam install -y re

pcre_dep:
	opam install -y pcre

fasta.ocaml-6:
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 unix.cmxa -ccopt -march=ivybridge $@.ml -o $@

fasta_data.txt: fasta.ocaml-6
	./fasta.ocaml-6 5000000 > $@

fasta: fasta.ocaml-6


str: fasta_data.txt
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 unix.cmxa str.cmxa -ccopt -march=ivybridge regexredux_$@.ml -o $@

pcre: pcre_dep fasta_data.txt
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I $(OPAM_SWITCH_PREFIX)/lib/pcre unix.cmxa pcre.cmxa -ccopt -march=ivybridge regexredux_$@.ml -o $@

re_str: re_dep fasta_data.txt
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I $(OPAM_SWITCH_PREFIX)/lib/re unix.cmxa re.cmxa -ccopt -march=ivybridge regexredux_$@.ml -o $@

re_pcre_core: re_dep fasta_data.txt
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I $(OPAM_SWITCH_PREFIX)/lib/re unix.cmxa re.cmxa -ccopt -march=ivybridge regexredux_$@.ml -o $@

regexredux.ocaml: re_dep fasta_data.txt
	ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I $(OPAM_SWITCH_PREFIX)/lib/re unix.cmxa re.cmxa -ccopt -march=ivybridge $@-3.ml -o $@


clean:
	git clean -dfXq
