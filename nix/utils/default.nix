{ pkgs, ... }:
with builtins;
rec {
  makeScript =
    name: path:
    pkgs.writeScriptBin (replaceStrings [ ".sh" ] [ "" ] name) (readFile (path + "/${name}"));

  makeScriptsFromDir = path: attrValues (mapAttrs (name: _: makeScript name path) (readDir path));

  # makeScriptsFromDir =
  #   with builtins;
  #   path:
  #   mapAttrs (name: _: makeScript name path) (
  #     lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".sh" name) (readDir path)
  #   );

}
