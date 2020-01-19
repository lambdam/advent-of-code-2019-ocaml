open Base
open Stdio

let input = "./assets/day02.input.txt"

let of_string string =
  string
  |> String.split ~on:','
  |> List.map ~f:Caml.String.trim
  |> List.map ~f:Int.of_string

let to_string list =
  list
  |> List.map ~f:Int.to_string
  |> String.concat ~sep:","

let update_at index value list =
  let rec update_at' i left right =
    match right with
    | [] -> List.rev left
    | hd :: tl ->
      if i = index
      then List.rev_append left (value :: tl)
      else update_at' (i + 1) (hd :: left) tl
  in
  update_at' 0 [] list

(*
   update_at 2 42 [1;2;3;4;5;6;7]
   List.nth [1;2;3;4;5;6;7] 2
*)

exception No_matching_opcode

let eval_opcode opcode =
  let module O = Option in
  let rec eval_opcode' position opcode =
    match List.drop opcode position with
    | 1 :: pos1 :: pos2 :: at_i :: _ ->
      let x = O.value_exn (List.nth opcode pos1) in
      let y = O.value_exn (List.nth opcode pos2) in
      eval_opcode' (position + 4) (update_at at_i (x + y) opcode)
    | 2 :: pos1 :: pos2 :: at_i :: _ ->
      let x = O.value_exn (List.nth opcode pos1) in
      let y = O.value_exn (List.nth opcode pos2) in
      eval_opcode' (position + 4) (update_at at_i (x * y) opcode)
    | 99 :: _ -> opcode
    | _ -> raise No_matching_opcode
  in
  eval_opcode' 0 opcode

let process_opcode () =
  In_channel.read_all input
  |> of_string
  |> update_at 1 12
  |> update_at 2 2
  |> eval_opcode
  |> to_string
  |> print_string

(*
   process_opcode ()
*)
