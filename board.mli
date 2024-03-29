(** The [Board] module representing a game board.*)
open Ship

(** [Missed s] is raised when a given coordinate has already been missed.*)
exception Missed of string

(** [Taken s] is raised when a given coordinate is already filled.*)
exception Taken of string


module type Board = sig
  (**AF: The array [| r1; r2; r3; r4;... |] is the array of the row arrays
     ri = [|ai1; ai2; ai3; ai4; ... |] which represents the elements in left to 
     right order of the elements in that row. aij is the element in the ith row
     and the jth column of a matrix of dimensions ixj.
     RI: All rows are the same size and all columns are the same size. Every
     element of the array must contain an element of type opt.*)

  (** type [tile] is the possible types of each space in the board. *)
  type tile

  (** type [t] is the type of [Board]*)
  type t 

  (** [create x y] makes a matrix with [x] rows and [y] columns with every 
      element in the matrix being [Water None]. *)
  val create : int -> int -> t

  (** [hit board coord] is true iff the [coord] in [board] contains a [Ship]
      that has not been hit at [coord] yet.
      Raises [Hitted] if the [coor] as already been hit.
      Raises [Missed] if the [coor] as already been missed
      Raises [Invalid_argument] is [coor] is out of bounds.**)
  val hit: t -> int * int -> bool

  (** [str_board board self] is [board] in string list form with each element
      representing a row, in player form iff self else enemy form.*)
  val str_board: t -> bool -> string list

  (** [to_list board self] is [board] represented as a 2d list of strings
      representing each element in the [board], in player form iff [self] else
      enemy form. *)
  val to_list: t -> bool -> string list list

  (** [columns b] gives the number of columns in the board [b]. This is equal to
      the size of each row in [b] *)
  val columns: t -> int

  (** [rows b] gives the number of rows in the board [b]. This is equal to the
      size of each column in [b]  *)
  val rows: t -> int

  (** [taken board list] is unit iff the [list] not in [board]. 
      Raises: [Taken] iff [list] in [board]*)
  val taken : t -> (int * int) list -> (int * int) list

  (** [place_ship board ship] puts [ship] into the [board].*)
  val place_ship : t -> ShipMaker.t ->  ShipMaker.t

  (** [get_coor board (r,c)] is the ship option of the coordinate [(r,c)] of
      the board. *)
  val get_coor: t -> int * int -> ShipMaker.t option

end

module BoardMaker : Board 
