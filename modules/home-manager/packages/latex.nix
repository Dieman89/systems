{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # LaTeX (for awesome-cv)
    (texlive.combine {
      inherit (texlive)
        scheme-small
        latexmk
        xetex
        chktex
        latexindent
        # awesome-cv dependencies
        enumitem
        ragged2e
        geometry
        fancyhdr
        xcolor
        iftex
        xifthen
        xstring
        etoolbox
        setspace
        fontspec
        unicode-math
        fontawesome6
        roboto
        sourcesanspro
        tcolorbox
        parskip
        hyperref
        bookmark
        texcount
        ifmtarg
        tikzfill
        texdef
        ;
    })
  ];
}
