{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc         # C++ compiler
    pkgs.clang       # LLVM-based compiler
    pkgs.ccls        # C/C++ language server
    pkgs.gdb         # Debugger
    pkgs.gnumake     # Make tool
    pkgs.curl.dev    # cURL dev files for linking with C++
    pkgs.pkg-config  # For library discovery
    pkgs.nlohmann_json  # JSON for Modern C++
  ];
}
