open Core_kernel.Std

module Std = struct
  type 'a printer = Format.formatter -> 'a -> unit
  include Bap_types.Std
  include Bap_image_std
  include Bap_disasm_std
  include Bap_sema.Std
  module Project = Bap_project
  module Self = Bap_self.Create
  type project = Project.t
  module Graphs = struct
    module Tid = Bap_tid_graph
    module Ir = Bap_ir_graph
    module Callgraph = Bap_ir_callgraph
    module Cfg = Cfg
  end
end
