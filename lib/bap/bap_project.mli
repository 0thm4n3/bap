open Core_kernel.Std
open Bap_types.Std
open Bap_image_std
open Bap_disasm_std
open Bap_sema.Std

type t

val from_file :
  ?on_warning:(Error.t -> unit Or_error.t) ->
  ?backend:string ->
  ?name:(addr -> string option) ->
  ?roots:addr list ->
  string -> t Or_error.t

val from_image :
  ?name:(addr -> string option) ->
  ?roots:addr list ->
  image -> t Or_error.t

val from_mem :
  ?name:(addr -> string option) ->
  ?roots:addr list ->
  arch -> mem -> t Or_error.t

val from_string :
  ?base:addr ->
  ?name:(addr -> string option) ->
  ?roots:addr list ->
  arch -> string -> t Or_error.t

val from_bigstring :
  ?base:addr ->
  ?name:(addr -> string option) ->
  ?roots:addr list ->
  arch -> Bigstring.t -> t Or_error.t

val arch : t -> arch
val program : t -> program term
val symbols : t -> symtab
val with_symbols : t -> symtab -> t
val memory : t -> value memmap
val disasm : t -> disasm
val with_memory : t -> value memmap -> t
val tag_memory : t -> mem -> 'a tag -> 'a -> t
val substitute : t -> mem -> string tag  -> string -> t
val set : t -> 'a tag -> 'a -> t
val get : t -> 'a tag -> 'a option
val has : t -> 'a tag -> bool

val register_pass : string -> (t -> t) -> unit
val register_pass': string -> (t -> unit) -> unit
val register_pass_with_args : string -> (string array -> t -> t) -> unit
val register_pass_with_args' : string -> (string array -> t -> unit) -> unit

val run_passes : ?argv:string array -> t -> t
val run_pass : ?argv:string array -> string -> t -> t option
val has_pass : string -> bool
