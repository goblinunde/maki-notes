\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{durhambeamerzh}[2026/03/16 v1.0.0 Durham Chinese Beamer Document Class]

%%---------- Theme mode flags ----------
\newif\ifDurhamCLS@accessibility \DurhamCLS@accessibilityfalse
\newif\ifDurhamCLS@plain         \DurhamCLS@plainfalse
\newif\ifDurhamCLS@invert        \DurhamCLS@invertfalse
\newif\ifDurhamCLS@systemfonts   \DurhamCLS@systemfontsfalse
\newif\ifDurhamCLS@biblatex      \DurhamCLS@biblatexfalse

\DeclareOption{accessibility}{\DurhamCLS@accessibilitytrue}
\DeclareOption{plain}{\DurhamCLS@plaintrue}
\DeclareOption{invert}{\DurhamCLS@inverttrue}
\DeclareOption{systemfonts}{\DurhamCLS@systemfontstrue}
\DeclareOption{biblatex}{\DurhamCLS@biblatextrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

%%---------- Load base class ----------
\LoadClass{beamer}

%%---------- Assemble theme option string ----------
\def\DurhamCLS@themeopts{}
\newcommand{\DurhamCLS@addopt}[1]{%
  \ifx\DurhamCLS@themeopts\@empty
    \def\DurhamCLS@themeopts{#1}%
  \else
    \edef\DurhamCLS@themeopts{\DurhamCLS@themeopts,#1}%
  \fi
}
\ifDurhamCLS@accessibility \DurhamCLS@addopt{accessibility}\fi
\ifDurhamCLS@plain         \DurhamCLS@addopt{plain}\fi
\ifDurhamCLS@invert        \DurhamCLS@addopt{invert}\fi

\ifx\DurhamCLS@themeopts\@empty
  \usetheme{durhamzh}%
\else
  \expandafter\usetheme\expandafter[\DurhamCLS@themeopts]{durhamzh}%
\fi

%%---------- Additional commonly used packages ----------
\RequirePackage{amssymb}

%%---------- CJK font selection ----------
\ifDurhamCLS@systemfonts
  \DurhamZHUseSystemFonts
\else
  \DurhamZHUseBundledFonts
\fi

%%---------- Default figure search path ----------
\graphicspath{{figure/}{./figure/}{../figure/}}

%%---------- Optional biblatex with academic defaults ----------
\ifDurhamCLS@biblatex
  \RequirePackage{csquotes}
  \RequirePackage[
    backend=biber,
    style=authoryear,
    sorting=nyt,
    maxcitenames=2,
    maxbibnames=99,
    doi=false,
    isbn=false,
    url=false
  ]{biblatex}
  \AtBeginBibliography{\small}
\fi

\endinput
