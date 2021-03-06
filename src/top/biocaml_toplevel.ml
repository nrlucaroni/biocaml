#! /usr/bin/env ocaml

#use "topfind"
#thread
#require "core"
open Core.Std
open Printf

let biocaml_dir = "_build/lib"

let command fmt =
  let f x =
    printf "Running %S\n%!" x;
    ignore (Sys.command x)
  in
  ksprintf f fmt


let () =
  let lib = Filename.concat biocaml_dir "biocaml.cma" in
  if Sys.file_exists lib = `No then (
    printf "%S not found.  Please compile the library first.\n" lib;
    exit 1
  );
  let tmp = Filename.temp_file "ocamlinit" ".ml" in
  Out_channel.with_file tmp ~f:(fun o ->
    fprintf o "
#use \"topfind\";;
#thread;;
#require \"core, zip, sqlite3, unix, batteries, xmlm, pcre\"
#directory %S;;
#load \"biocaml.cma\";;
open Core.Std;;
" biocaml_dir;
  );
  command "ocaml -init %s" tmp;
  Sys.remove tmp
