\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{maki-beamer}[2026/04/13 Maki beamer class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=makiBeamer,
	prefix=makiBeamer@
}
\DeclareStringOption[common]{fontpreset}
\DeclareStringOption[default]{theme}
\DeclareStringOption[durham]{layout}
\DeclareBoolOption[false]{plain}
\DeclareBoolOption[false]{invert}
\DeclareBoolOption[false]{accessibility}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbeamer}}
\ProcessKeyvalOptions*

\LoadClass[fontset=none]{ctexbeamer}

\newcommand{\LectureNotesTitle}{讲义标题}
\newcommand{\AuthorInfo}{作者信息}
\newcommand{\CoverTitle}{\LectureNotesTitle}
\newcommand{\CoverAuthorBlock}{\AuthorInfo}
\newcommand{\CoverFooterBlock}{}
\newcommand{\MakiFontPreset}{common}
\newcommand{\MakiTheme}{default}
\newcommand{\MakiBeamerLayout}{durham}
\edef\MakiFontPreset{\makiBeamer@fontpreset}
\edef\MakiTheme{\makiBeamer@theme}
\edef\MakiBeamerLayout{\makiBeamer@layout}

\RequirePackage{maki-notes}

\makeatletter
\def\MakiBeamerThemeOptions{}
\newcommand{\MakiBeamerAddThemeOption}[1]{%
	\ifx\MakiBeamerThemeOptions\@empty
		\def\MakiBeamerThemeOptions{#1}%
	\else
		\edef\MakiBeamerThemeOptions{\MakiBeamerThemeOptions,#1}%
	\fi
}

\MakiBeamerAddThemeOption{layout=\MakiBeamerLayout}%
\ifmakiBeamer@plain
	\MakiBeamerAddThemeOption{plain}%
\fi
\ifmakiBeamer@invert
	\MakiBeamerAddThemeOption{invert}%
\fi
\ifmakiBeamer@accessibility
	\MakiBeamerAddThemeOption{accessibility}%
\fi

\ifx\MakiBeamerThemeOptions\@empty
	\usetheme{maki}%
\else
	\expandafter\usetheme\expandafter[\MakiBeamerThemeOptions]{maki}%
\fi

\providecommand{\MakeTitlePage}{\maketitle}
\providecommand{\makeoutline}{\MakiOutline}

\AtBeginDocument{%
	\ifx\@title\@empty
		\title{\LectureNotesTitle}%
	\fi
	\ifx\@author\@empty
		\author{\AuthorInfo}%
	\fi
}
\makeatother

\endinput
