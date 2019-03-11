let mapper =
  let module Ast = Migrate_parsetree.Ast_405 in
  let id = Ast.Ast_mapper.default_mapper in
  let check_structure_item stri =
    match stri.Ast.Parsetree.pstr_desc with
    | Pstr_class _ -> Location.raise_errorf ~loc:stri.pstr_loc "class detected"
    | _ -> ()
  in
  let structure_item mapper stri =
    check_structure_item stri ;
    id.structure_item mapper stri
  in
  {id with structure_item}

let () =
  Migrate_parsetree.Driver.register ~name:"detect_classes"
    Migrate_parsetree.Versions.ocaml_405 (fun _ _ -> mapper )
