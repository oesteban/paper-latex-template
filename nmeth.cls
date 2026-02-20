% A template for eLife submissions.
%
% Created by Overleaf (writeLaTeX).
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmeth}[2021/03/18, v1.9]

\RequirePackage[english]{babel}

\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{regexpatch}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{fontawesome5}

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\newif\if@reqslineno
\DeclareOption{lineno}{\@reqslinenotrue}

%% Linespacing.
\newif\if@onehalfspacing
\newif\if@doublespacing
\DeclareOption{onehalfspacing}{\@onehalfspacingtrue}
\DeclareOption{doublespacing}{\@doublespacingtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ExecuteOptions{}
\ProcessOptions\relax
\LoadClass{extarticle}

\RequirePackage{amsmath}
\RequirePackage{mdframed}

\RequirePackage{setspace}
\RequirePackage{lineno}
\if@reqslineno\linenumbers\fi

% Note v1.0 of elife.cls used Trueno font; this was 
% changed to use Open Sans in v1.1

\ifxetexorluatex
  \RequirePackage{fontspec}
  \RequirePackage{unicode-math}
  % Default to TeX Live bundled fonts so the template builds out of the box.
  \setmainfont{TeX Gyre Termes}
  \setsansfont{TeX Gyre Heros}
  \setmonofont{Latin Modern Mono}[Scale=MatchLowercase]
  \setmathfont{TeX Gyre Termes Math}
\else  
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{stix}
  \RequirePackage[default]{opensans}
  \RequirePackage{newunicodechar}
  % \renewcommand{\ttdefault}{lmtt}
\fi
\RequirePackage{microtype}

% Trueno/Open Sans requires a bigger "single" linespread.
\linespread{1.2}
\if@onehalfspacing\linespread{1.5}\fi
\if@doublespacing\linespread{2.0}\fi

\RequirePackage{graphicx,xcolor}
\definecolor{eLifeDarkBlue}{HTML}{273B81}
\definecolor{eLifeLightBlue}{HTML}{0A9DD9}
\definecolor{eLifeMediumGrey}{HTML}{6D6E70}
\definecolor{eLifeLightGrey}{HTML}{929497}

\RequirePackage{booktabs}
\RequirePackage{authblk2}

\RequirePackage[left=6cm,%
                marginparwidth=4cm,%
                marginparsep=1.00cm,%
                right=1.3cm,%
                top=2cm,%
                bottom=2.5cm,%
                headheight=21pt,%
                headsep=2\baselineskip,%
                columnsep=2em,%
                letterpaper]{geometry}%
\RequirePackage{changepage}

\RequirePackage{silence}
\WarningFilter{caption}{The option `hypcap=true' will be ignored}

\RequirePackage[labelfont={bf},%
                labelsep=period,%
                justification=raggedright,%
                singlelinecheck=false,%
                tableposition=top,%
                font={small,sf}]
                {caption}

% \captionsetup*[table]{skip=\medskipamount}

\RequirePackage{natbib}
\bibliographystyle{nmeth}
\renewcommand{\bibfont}{\small}
% modifed from https://github.com/gbhutani/vancouver_authoryear_bibstyle/
% Make author in citation italic
\renewcommand{\NAT@nmfmt}[1]{{\bfseries\itshape\color{eLifeMediumGrey} #1}}

% ...as well as the year
\xpatchcmd{\NAT@citex}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\else\unskip\NAT@spacechar\NAT@hyper@{\NAT@date}}
{\else\unskip\NAT@spacechar\NAT@hyper@{\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\hyper@natlinkbreak{\NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb}\NAT@date}
{\hyper@natlinkbreak{\NAT@nmfmt{\NAT@aysep\NAT@spacechar}}{\@citeb\@extra@b@citeb}\NAT@nmfmt{\NAT@date}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\@citea\NAT@hyper@{\NAT@date}}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{{\@citeb\@extra@b@citeb}\NAT@date}
{{\@citeb\@extra@b@citeb}\NAT@nmfmt{\NAT@date}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}
%% There, we're finally done with patching the year in citations.

%
% headers and footers
%
\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers
\addtolength{\headwidth}{\marginparsep}
\addtolength{\headwidth}{\marginparwidth}
\fancyhf{}
% Running title API:
% set in the manuscript with \runningtitle{...}
\def\@runningtitle{}
\newcommand{\runningtitle}[1]{\gdef\@runningtitle{#1}}
\newcommand{\runningtitlefont}{\sffamily\Large}
\rhead{\runningtitlefont\@runningtitle}
% Removing header in v1.9
% \chead{%
% \setlength{\fboxsep}{3pt}
% \colorbox{eLifeMediumGrey}{\begin{minipage}{\headwidth}\centering\color{white} Manuscript submitted to eLife\end{minipage}}%
% }

% Footers
\rfoot{\sffamily\small\color{eLifeMediumGrey}\thepage\space of\space\pageref{LastPage}}%
\preto{\footrule}{\color{eLifeMediumGrey}}
\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0.4pt}% % No footer rule

%
% section/subsection/paragraph set-up
%
\setcounter{secnumdepth}{0}
\RequirePackage[explicit]{titlesec}
\titleformat{\section}
  {\sffamily\color{eLifeMediumGrey}\Large\bfseries}
  {\thesection}{}{#1}[]
\titleformat{\subsection}
  {\sffamily\bfseries}
  {\thesubsection}{}{#1}[]
\titleformat{\subsubsection}
  {\sffamily}
  {\thesubsubsection}{}{#1}[]
\titleformat{\paragraph}[runin]
  {\sffamily\color{eLifeMediumGrey}\bfseries}
  {\theparagraph}{}{#1}[]

\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{0pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{0pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
% \titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{0pt}

\PassOptionsToPackage{inline}{enumitem}
\RequirePackage{enumitem}
\setlist{noitemsep}

\RequirePackage{alphalph}
\newalphalph{\fnsymbolmult}[mult]{\@fnsymbol}{5}

\newcounter{authorfn}
\setcounter{authorfn}{1}
\newcommand{\authfn}[1]{%
  \fnsymbolmult{\numexpr\value{authorfn}+#1}%
}

\def\@correspondence{}
\def\@contribution{}
\def\@presentaddress{}
\def\@deceased{}

\newcommand{\corr}[2]{%
  \ifx\empty\@correspondence\else\appto{\@correspondence}{; }{}{}\fi
  \appto{\@correspondence}{%
    {\ttfamily\color{eLifeLightBlue} #1}%
    \ifx\empty#2\else\sffamily\space(#2)\fi
  }{}{}%
}

\newcommand{\contrib}[2][]{
  \appto{\@contribution}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2\\
  }{}{}
}

\newcommand{\presentadd}[2][]{
  \ifx\empty\@presentaddress\else\appto{\@presentaddress}{; }{}{}\fi
  \appto{\@presentaddress}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2%
  }{}{}
}

\newcommand{\deceased}[1]{\def\@deceased{\textsuperscript{#1}Deceased}}

\reversemarginpar

%
% custom title page 
%
\renewcommand{\Authfont}{\sffamily\fontseries{mb}\selectfont\large\raggedright}
\renewcommand{\Affilfont}{\sffamily\fontseries{m}\fontsize{6}{2}\selectfont\raggedright}
\renewcommand{\Authands}{, }
\setlength{\affilsep}{2pt}

\newcommand{\themetadata}{%
    \sffamily\fontseries{mb}\selectfont%
    \faIcon{at}\space\space\space Correspondence:\\ %
    \fontseries{m}\selectfont\@correspondence\par
    \ifx\empty\@contribution\else
    \bigskip\@contribution\par\fi
    \ifx\empty\@presentaddress\else
    \bigskip\textbf{Present address: }\@presentaddress\par\fi
    \bigskip
    \ifx\empty\@deceased\else\@deceased\par\fi
}

\patchcmd{\@author}{\AB@authlist\\[\affilsep]\AB@affillist}{\AB@authlist\\[\affilsep] 
  \marginpar{\raggedright\footnotesize\themetadata\par}%
  \setstretch{0.5}
  \begin{figure}[b!]{\Affilfont Affiliations: \AB@affillist}\end{figure}%
  }{}{}

\renewcommand{\maketitle}{%
  \vskip36pt%
  {\sffamily\color{eLifeDarkBlue}\raggedright\bfseries\fontsize{18}{22}\selectfont \@title\par}%
  \vskip16pt
  {\@author\par}
  \vskip8pt
}

\renewenvironment{abstract}{%
   \setlength{\parindent}{0pt}\raggedright
   \vskip8pt
   \sffamily\fontseries{mb}\selectfont
}{%   
   \vskip16pt
}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{-4.5cm}{}
}{\end{adjustwidth}}

%% Insert a grey line to separate floats from main text
\newcommand{\topfigrule}{\vskip8pt\noindent{\rule{\linewidth}{1pt}}}
\newcommand{\botfigrule}{\noindent{\rule{\linewidth}{1pt}}\vskip8pt}

\RequirePackage{newfloat}
\RequirePackage{wrapfig}
\AtEndEnvironment{wrapfigure}{\vskip8pt\noindent{\rule{\hsize}{1pt}}}
% \RequirePackage[lflt]{floatflt}
% \AtEndEnvironment{floatingfigure}{\vskip8pt\noindent\textcolor{eLifeMediumGrey}{\rule{\hsize}{2pt}}}

\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}
\captionsetup[featurebox]{font={Large,bf,color=eLifeDarkBlue}}

\newcounter{featurefigure}
\newcounter{featuretable}
\AtBeginEnvironment{featurebox}{%
  \setcounter{featurefigure}{0}%
  \setcounter{featuretable}{0}%
  \newcommand{\featurefig}[1]{%
    \refstepcounter{featurefigure}%
    \vskip\smallskipamount%
    {\small\textbf{\color{eLifeDarkBlue}Box \arabic{featurebox} Figure \arabic{featurefigure}.}\space #1\par}\medskip}
  \newcommand{\featuretable}[1]{%
    \refstepcounter{featuretable}%
    \vskip\smallskipamount%
    {\small\textbf{\color{eLifeDarkBlue}Box \arabic{featurebox} Table \arabic{featuretable}.}\space #1\par}\medskip}

}
% \apptocmd{\featurebox}{%
%   \begin{mdframed}[linewidth=0pt,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue]
%   \if@reqslineno\addtolength{\linenumbersep}{1em}\internallinenumbers\fi%
% }{}{}
% \pretocmd{\endfeaturebox}{\end{mdframed}}{}{}

\RequirePackage[most]{tcolorbox}
\apptocmd{\featurebox}{%
  \begin{tcolorbox}[colback=eLifeLightBlue!10,colframe=eLifeLightBlue!10,grow to left by=4.5cm,coltext=eLifeDarkBlue]
  \begin{minipage}{\linewidth}
  \if@reqslineno\addtolength{\linenumbersep}{1em}\internallinenumbers\fi%
}{}{}
\pretocmd{\endfeaturebox}{\end{minipage}\end{tcolorbox}}{}{}


\appto{\appendix}{%
  \captionsetup*[figure]{name={Supp. Figure },font={small},skip=\smallskipamount}%
  \captionsetup*[table]{name={Supp. Table },font={small},skip=\smallskipamount}%
  % \captionsetup*[featurebox]{name={Supp. Box },font={small},skip=\smallskipamount}%
}

\newcounter{figsupp}
\setcounter{figsupp}{0}
\newcounter{data}
\setcounter{data}{0}
%% Added videos 2021/03/07
\newcounter{srccode}
\setcounter{srccode}{0}
%% Added videos 2018/06/03
\newcounter{video}
\setcounter{video}{0}
\newcounter{videosupp}
\setcounter{videosupp}{0}
\def\supplist{}

\RequirePackage{newfile}
\newoutputstream{suppinfo}
\openoutputfile{\jobname.suppinfo}{suppinfo}

\newcommand{\video}[1]{%
  \refstepcounter{video}%
  \bigskip%
  \noindent{\small\textbf{Video \arabic{video}.} #1\par}%
  \bigskip
}

% \AtBeginEnvironment{figure}{%
%   \setcounter{figsupp}{0}
%   \setcounter{data}{0}
%   \setcounter{videosupp}{0}
%   \setcounter{srccode}{0}
%   %% Updated 2017/06/30 to allow optional argument
%   \newcommand{\figsupp}[3][]{%
%     \refstepcounter{figsupp}%
%     {%
%     \ifstrequal{#1}{none}{}{%
%       \small\textbf{Figure~\thefigure--Figure supplement \arabic{figsupp}.} \ifstrempty{#1}{#2}{#1}}}\par
%     \addtostream{suppinfo}{%
%       \noindent\protect\begin{minipage}{\linewidth}
%       \protect #3\noexpand\par
%       \textbf{Figure \thefigure--Figure supplement \arabic{figsupp}.} #2\noexpand\par
%       \vskip8pt
%       \protect\end{minipage}
%       \vskip16pt
%     }
%   }
%   \newcommand{\figdata}[1]{%
%     \refstepcounter{data}
%     {\small\textbf{Figure~\thefigure--source data \arabic{data}.} #1}\par
%   }
%   %% Added 2021/03/07  
%   \newcommand{\figsrccode}[1]{%
%     \refstepcounter{srccode}
%     {\small\textbf{Figure~\thefigure--source code \arabic{srccode}.} #1}\par
%   }
%   %% Added 2018/06/03
%   \newcommand{\videosupp}[1]{%
%     \refstepcounter{videosupp}
%     {\small\textbf{Figure~\thefigure--video \arabic{videosupp}.} #1}\par
%   }
% }

% \AtBeginEnvironment{table}{%
%   \setcounter{data}{0}
%   \setcounter{srccode}{0}
%   \setcounter{videosupp}{0}
%   \newcommand{\tabledata}[1]{%
%     \refstepcounter{data}
%     {\small\textbf{Table~\thetable--source data \arabic{data}.} #1}\par
%   }
%   \newcommand{\tablesrccode}[1]{%
%     \refstepcounter{srccode}
%     {\small\textbf{Table~\thetable--source code \arabic{srccode}.} #1}\par
%   }
% }

\AtBeginEnvironment{tabular}{\sffamily}
\AtBeginEnvironment{table}{\sffamily} 

\AtEndDocument{%
  \closeoutputstream{suppinfo}
%   \pagestyle{empty}
%  \renewcommand{\footrule}{}
%  \rfoot{}
  \input{\jobname.suppinfo}
}

\newcounter{appendix}
\setcounter{appendix}{0}
\newenvironment{appendixbox}{%
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \refstepcounter{appendix}%
  \clearpage%
  \patchcmd{\ttlf@section}{eLifeMediumGrey}{eLifeDarkBlue}{}{}
  \noindent{\bfseries\Large\color{eLifeMediumGrey}Appendix \arabic{appendix}\par}
  \nolinenumbers%
  \begin{mdframed}[hidealllines=true,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue,leftline=true,linecolor=eLifeLightBlue,linewidth=1em]
  \if@reqslineno\addtolength{\linenumbersep}{2em}\internallinenumbers\fi
}{%
  \end{mdframed}
}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true,allcolors=black,citecolor=eLifeMediumGrey,linkcolor=eLifeMediumGrey,urlcolor=eLifeLightBlue,hypertexnames=false}
\renewcommand{\UrlFont}{\small\sffamily}
\urlstyle{sf}

%% To change the default prefix, redefine this command within your own code.
%% It takes no argument, which is different from the doipubmed package.
\newcommand{\doitext}{doi:}

%% To change the default DOI URL resoloution URL, redefine this command
%% within your own code.
%% Previous versions of this package always used http://dx.doi.org/ but
%% The preferred address is now as given here, https://doi.org/
\newcommand{\doiurl}{https://doi.org/}

%% The meat of the code.
%% The first command opens a group, and changes a few catcodes.
\newcommand*{\doi}{% 
  \begingroup
  \lccode`\~=`\#\relax
  \lowercase{\def~{\#}}%
  \lccode`\~=`\_\relax
  \lowercase{\def~{\_}}%
  \lccode`\~=`\<\relax
  \lowercase{\def~{\textless}}%
  \lccode`\~=`\>\relax
  \lowercase{\def~{\textgreater}}%
  \lccode`\~=0\relax
  \catcode`\#=\active
  \catcode`\_=\active
  \catcode`\<=\active
  \catcode`\>=\active
  \@doi
}

%% This is the actual command which processes the argument, with the catcodes 
%% set in the previous command
%% it closes the group, and spits out the url.
\def\@doi#1{% 
  \let\#\relax
  \let\_\relax
  \let\textless\relax
  \let\textgreater\relax
  \edef\x{\toks0={{\noexpand\sffamily#1}}}% 
  \x
  \edef\#{\@percentchar23}%
  \edef\_{_}%
  \edef\textless{\@percentchar3C}% instead of {\string<} for Apple
  \edef\textgreater{\@percentchar3E}% instead of {\sting>} for Apple
  \edef\x{\toks2={\noexpand\href{\doiurl#1}}}% 
  \x
  \edef\x{\endgroup\doitext\the\toks2 \the\toks0}%
  \x
}


% Other desired commands
\renewcommand{\equationautorefname}{Eq.}
%% Added autoref support for \figsupp, \figdata, \video, \videosupp, (2021-03-04) \figsrccode
% \newcommand{\figsuppautorefname}{Figure Supplement}
% \newcommand{\dataautorefname}{source data}
% \newcommand{\videoautorefname}{Video}
% \newcommand{\videosuppautorefname}{video}
% \newcommand{\srccodeautorefname}{source code}
% \newcommand{\FIGSUPP}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figsupp:#2}%
% }
% \newcommand{\FIGDATA}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figdata:#2}%
% }
% \newcommand{\TABLEDATA}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{tab:#1}--}\autoref{tabdata:#2}%
% }
% \newcommand{\FIGSRCCODE}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figsrccode:#2}%
% }
% \newcommand{\TABLESRCCODE}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{tab:#1}--}\autoref{tabsrccode:#2}%
% }
% \newcommand{\VIDEOSUPP}[2][]{%
%   \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{videosupp:#2}%
% }
% \newcommand{\FIG}[1]{\autoref{fig:#1}}
% \newcommand{\TABLE}[1]{\autoref{tab:#1}}
% \newcommand{\VIDEO}[1]{\autoref{video:#1}}
% \newcommand{\EQ}[1]{\autoref{eq:#1}}
% \newcommand{\BOX}[1]{\autoref{box:#1}}
% \let\oldautoref\autoref
% \renewcommand{\autoref}[1]{\emph{\textbf{\oldautoref{#1}}}}

\endinput
