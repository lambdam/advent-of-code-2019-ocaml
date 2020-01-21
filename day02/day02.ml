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

(* How to use this type in calculation? *)
type instruction =
  | Add of int * int * int
  | Mult of int * int * int
  | Halt

let eval_opcodes opcode =
  let module O = Option in
  let rec eval_opcodes' instruction_pointer opcode =
    match List.drop opcode instruction_pointer with
    | 1 :: pos1 :: pos2 :: at_i :: _ ->
      let x = O.value_exn (List.nth opcode pos1) in
      let y = O.value_exn (List.nth opcode pos2) in
      eval_opcodes' (instruction_pointer + 4) (update_at at_i (x + y) opcode)
    | 2 :: pos1 :: pos2 :: at_i :: _ ->
      let x = O.value_exn (List.nth opcode pos1) in
      let y = O.value_exn (List.nth opcode pos2) in
      eval_opcodes' (instruction_pointer + 4) (update_at at_i (x * y) opcode)
    | 99 :: _ -> opcode
    | _ -> raise No_matching_opcode
  in
  eval_opcodes' 0 opcode

let process_opcode () =
  In_channel.read_all input
  |> of_string
  |> update_at 1 12
  |> update_at 2 2
  |> eval_opcodes
  |> to_string
  |> print_string

(*
   process_opcode ()
*)

let input_program =
  In_channel.read_all input
  |> of_string

let target_result = 19690720

let search_inputs () =
  let rec search_inputs' v1 v2 =
    match (v1, v2) with
    | (_, 100) -> search_inputs' (v1 + 1) 0
    | (100, _) -> None
    | _ ->
      input_program
      |> update_at 1 v1
      |> update_at 2 v2
      |> eval_opcodes
      |> (fun output ->
          if Option.value_exn (List.nth output 0) = target_result
          then Some (v1, v2)
          else search_inputs' v1 (v2 + 1))
  in
  search_inputs' 0 0

(*
   search_inputs ()
*)

(* let () =
 *   match search_inputs () with
 *   | Some (v1, v2) -> print_string (Printf.sprintf "(%d, %d)" v1 v2)
 *   | None -> print_string "No result" *)
