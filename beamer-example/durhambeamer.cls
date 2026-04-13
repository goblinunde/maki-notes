\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{durhambeamer}[2026/03/16 v1.0.0 Durham English Beamer Document Class]

%%---------- Theme mode flags ----------
\newif\ifDurhamCLS@accessibility \DurhamCLS@accessibilityfalse
\newif\ifDurhamCLS@plain         \DurhamCLS@plainfalse
\newif\ifDurhamCLS@invert        \DurhamCLS@invertfalse

\DeclareOption{accessibility}{\DurhamCLS@accessibilitytrue}
\DeclareOption{plain}{\DurhamCLS@plaintrue}
\DeclareOption{invert}{\DurhamCLS@inverttrue}
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
  \usetheme{durham}%
\else
  \expandafter\usetheme\expandafter[\DurhamCLS@themeopts]{durham}%
\fi

%%---------- Additional commonly used packages ----------
\RequirePackage{amssymb}

%%---------- Default figure search path ----------
\graphicspath{{figure/}{./figure/}{../figure/}}

\endinput
