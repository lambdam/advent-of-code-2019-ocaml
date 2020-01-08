open Base

let () =
  let foo = [1;2;3;4] in
  match List.reduce ~f:(+) foo with
  | Some x -> Caml.print_int x
  | _ -> Caml.print_string "Nothing"
