(* The Computer Language Benchmarks Game
 * https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
 *
 * regex-dna program contributed by Christophe TROESTLER
 * converted from regex-dna program
 *
 * updated by Roman Kashitsyn: use Bytes instead of String
 *)

open Printf

let variants = ["agggtaaa|tttaccct";          "[cgt]gggtaaa|tttaccc[acg]";
                "a[act]ggtaaa|tttacc[agt]t";  "ag[act]gtaaa|tttac[agt]ct";
                "agg[act]taaa|ttta[agt]cct";  "aggg[acg]aaa|ttt[cgt]ccct";
                "agggt[cgt]aa|tt[acg]accct";  "agggta[cgt]a|t[acg]taccct";
                "agggtaa[cgt]|[acg]ttaccct"]


let subst = ["tHa[Nt]", "<4>"; "aND|caN|Ha[DS]|WaS", "<3>";
             "a[NSt]|BY", "<2>"; "<[^>]*>", "|"; "\\|[^|][^|]*\\|", "-"] 

(* Read all of a redirected FASTA format file from stdin. *)
let file_data, file_length =
  let b = Buffer.create 0xFFFF in
  let s = Bytes.create 0xFFF in
  let r = ref 1 in
  while !r > 0 do
    r := input stdin s 0 0xFFF;
    Buffer.add_substring b (Bytes.unsafe_to_string s) 0 !r
  done;
  (Buffer.contents b, Buffer.length b)

(* Remove FASTA sequence descriptions and all linefeed characters.  *)
let dna = Pcre.qreplace ~pat:">.*\n|\n" ~templ:"" file_data
let code_length = String.length dna

(* Count matches of [pat]. *)
let count pat s = Array.length(Pcre.exec_all ~pat s)

(* Parallel count matches of [re]. *)
let rec p_count = function
  | [re] -> printf "%s %i\n" re (count re dna)
  | re::tl ->
    if Unix.fork() = 0 then (
      p_count tl
    ) else (
      let nb = count re dna in
      ignore(Unix.wait());
      printf "%s %i\n" re nb
    )
  | [] -> ()


let () =
  if Sys.argv.(1) = "p" || Sys.argv.(1) = "pc" then (
    if Unix.fork() = 0 then (
      if Sys.argv.(1) = "pc" then (
        p_count(List.rev variants);
      )
      else (
        List.iter (fun re -> printf "%s %i\n" re (count re dna)) variants;
      )
    )
    else (
      let b = ref dna in
      List.iter (fun (pat, templ) -> b := Pcre.qreplace ~pat ~templ !b) subst;

      ignore(Unix.wait());
      printf "\n%i\n%i\n%i\n" file_length code_length (String.length !b)
    )
  ) else (
    List.iter (fun re -> printf "%s %i\n" re (count re dna)) variants;
    let b = ref dna in
    List.iter (fun (pat, templ) -> b := Pcre.qreplace ~pat ~templ !b) subst;
    printf "\n%i\n%i\n%i\n" file_length code_length (String.length !b)
  )
