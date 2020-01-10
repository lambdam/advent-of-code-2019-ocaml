open Base
open Stdio

let input = "assets/day01.input.txt"

(* part 1 *)
let needed_fuel name =
  let ic = In_channel.create name in
  let lines = In_channel.fold_lines ic
      ~init:[]
      ~f:(fun acc line ->
          try
            line
            |> Int.of_string
            |> (fun x -> x :: acc)
          with
            _ -> acc)
  in
  In_channel.close ic;
  List.rev lines
  |> List.map ~f:(fun x -> (x / 3) - 2)
  |> List.reduce ~f:(+)
  |> (function
      | None -> 0
      | Some x -> x)

(*
   needed_fuel input
*)

(* part 2 *)
let really_needed_fuel name =
  let ic = In_channel.create name in
  let lines = In_channel.fold_lines ic
      ~init:[]
      ~f:(fun acc line ->
          try
            line
            |> Int.of_string
            |> (fun x -> x :: acc)
          with
            _ -> acc)
  in
  In_channel.close ic;
  let rec count_line acc rest =
    let fuel = (rest / 3) - 2 in
    if fuel <= 0
    then acc
    else count_line (acc + fuel) fuel
  in
  lines
  |> List.map ~f:(fun x -> count_line 0 x)
  |> List.reduce ~f:(+)
  |> (function
      | None -> 0
      | Some x -> x)

(*
   really_needed_fuel input
*)


