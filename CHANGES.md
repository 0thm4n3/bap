0.9.6
=====

1. New loader backed with LLVM
   BAP now have another loader (image reader), that
   supports MACH-O, ELF, COFF, PE. This loader is
   backed with LLVM library.

2. Online plugin system

   New extension point is added - "bap.project". Plugins marked with
   this plugin system will not be loaded automatically when
   `Plugins.load` is called, instead, they can be loaded dynamically
   (or online, hence the title), by using `-l` option to the `bap`
   utility. After being loaded the plugin is applied to a `project`
   data structure that contains all information about disassembled
   binary. Plugin can functionally update this data structure, to
   push information to other plugins or back to the `bap` utility.

   In addition to a common way of creating plugins with `oasis`, we
   extended `bapbuild` utility with a new rule the will product a
   `plugin` file. This is just a shared library underneath the hood,
   and you can load a plugin, created with this method directly,
   without installing it anywhere. `bap` utility will try to find the
   plugin, specified with `-l` option in a current folder, then in all
   folders specified in `BAP_PLUGIN_PATH` environment variable, and,
   finally in the system, using `ocamlfind`.

   In order to provide a typesafe way of interacting between plugins,
   we added extensible variants to BAP. But instead of using one from
   the 4.02, we're using universal types, based on that one, that Core
   library provides. First of all this is more portable, second it is
   more explicit and a little bit more safe.

3. New ABI and CPU interfaces

   Modules that implements `CPU` interface are used to describe
   particular CPU in BIL terminology, e.g., it tells which variable
   corresponds to which register, flag, etc. To obtain such module,
   one should use `target_of_cpu` function.

   ABI is used to capture the procedure abstraction, starting from
   calling convetions and stack frame structure and ending with special
   function handling and support for different data-types.

   See d5cab1a5e122719b4a3b1ece2b1bc44f3f93095a for more information
   and examples.

4. Bap-objdump renamed to bap

   bap-objdump has outgrown its name. Actually it was never really a
   bap-objdump at all. From now, it is just an entry point to the `bap` as
   platform. We will later unite `bap` with other utilities, to make them
   subcommands, e.g. `bap byteweight`.

5. Cleanup of BIL modules

   Now there is a separation between BIL fur uns, and BIL fur
   OCaml. For writing BIL programs (as EDSL in OCaml) one should use
   `Bil` module, e.g. `Bil.(x = y)` will evaluate to a BIL
   expression. For using BIL entities as OCaml values, one should use
   corresponding module, e.g. `Exp.(x = y)` will compare to expressions
   and evaluate to a value of type `bool`.

6. Enhanced IDA integration

   IDA intergation is now more robust. We switched to `IDA-32` by default,
   since 64-bit version doesn't support decompiler. Also `bap` utility
   can now output IDA python scripts. And `bap` plugins can annotate project
   with `python` commands, that later will be dumped into the script.

7. In ARM switched to ARMv7 by default
8. Introduce LNF algorithm and Sema library

   A new layer of BAP is started in this release. This would be a third pass
   of decompilation, where the semantic model of program will be built. Currently,
   there is nothing really interesting here, e.g., an implementation of the
   Loop nesting forest, that is not very usable right now. But the next release,
   will be dedicated to this layer. So, stay tuned.

9. Add support for OCamlGraph

   Now we provide a helper utilities for those who would like to use
   ocamlgraph library for analysis.

10. Extended bap-mc utility

   `bap-mc` utility now prints results in plethora of formats,
   including protocol buffers, from the piqi library, that was revived
   by Kenneth Miller.

11. Interval trees, aka memory maps

   For working with arbitrary overlapping memory regions we now have a
   memory map data structure, aka interval trees, segment trees, etc. It
   is based on AVL trees, and performs logarithmic searches.

12. Simplified CI

   We put Travis on a diet. Now only 4 machines with 20 ETA for all test
   suites to pass. (Instead of 8 * 40).


0.9.5
=====

1. removed tag warnings from the ocamlbuild
2. fixed #114
3. moved Bap_plugins out of Bap library
4. plugin library can now load arbitrary files
5. bap-objdump is now pluggable
6. added new extension point in the plugin system
7. updated BAP LICENSE, baptop is now QPLed
8. IDA can now work in a headless mode
9. enhanced symbol resolution algorithm
10. cleaned up image backend interface
11. constraint OPAM file


0.9.4
=====

1. x86 and x86_64 lifter #106
2. New byteweight implementation #99
3. Intra-procedure CFG reconstruction #102
4. IDA integration #103
5. Binary release #108
6. Man pages and documentation #107
7. Unconstraint opam file and extended it with system dependents #109

0.9.3
=====

1. Bitvector (aka Word, aka Addr) now provides all Integer
interface without any monads right at the toplevel of the module.
In other words, now you can write: Word.(x + y).

2. Bitvector.Int is renamed to Bitvector.Int_exn so that it don't
clobber the real Int module

3. All BIL is now consolidated in one module named Bil. This module
contains everything, including constructors for statements, expressions
casts, binary and unary operations. It also includes functional
constructors, that are now written by hand and, thus, don't suffer from
syntactic clashes with keywords. There're also a plenty of other
functions and new operators, available from the new Bap_helpers
module, see later. Old modules, like Expr, Stmt, etc are still
available, they implement Regular interface for corresponding types.

4. New feature: visitor classes to traverse and transform the AST.
Writing a pattern matching code every time you need to traverse or map
the BIL AST is error prone and time-consuming. This visitors, do all the
traversing for you, allowing you to override default behavior. Some
handy algorithms, that use visitors are provided in an internal
Bap_helpers module, that is included into resulting Bil
module. Several optimizations were added to bap-objdump utility, like
constant propogation, inlining, pruning unused variables and resolving
addresses to symbols.

5. Insn interface now provides predicates to query insn classes, this
predicates use BIL if available.

6. Disam interface now provides linear_sweep function.


0.9.2
=====

1. Recursive descent disassembler
2. High-level simple to use interface to BAP
3. New utility `bap-objdump`
4. Enhanced pretty-printing
5. Lots of small fixes and new handy functions
6. Automatically generated documentation.


0.9.1
=====

First release of a new BAP.
