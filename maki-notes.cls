\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{maki-notes}[2026/04/09 Maki lecture notes class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

\LoadClass[fontset=none]{ctexbook}

\newcommand{\LectureNotesTitle}{讲义标题}
\newcommand{\AuthorInfo}{作者信息}
\newcommand{\CoverTitle}{\LectureNotesTitle}
\newcommand{\CoverAuthorBlock}{作者署名}
\newcommand{\CoverFooterBlock}{日期}

\RequirePackage{maki-notes}

\newcommand{\MakeTitlePage}{%
	\begin{titlepage}
		\centering
		\vspace*{5cm}
		
		{\fontsize{48pt}{60pt}\selectfont\heavykaishu \color{LogicColor} \CoverTitle\par}
		
		\vfill
		
		{\LARGE \kaishu
			\CoverAuthorBlock\par
		}
		
		\vspace{2.3cm}
		
		{\Large \kaishu
			\CoverFooterBlock\par
		}
		
		\vspace{2cm}
	\end{titlepage}%
}

\renewcommand{\maketitle}{\MakeTitlePage}
