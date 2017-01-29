#!/bin/bash
loopmax=0
. ../common.sh

[[ $silentMode == 0 ]] && set -x 

# =======  tikz tag  ========= 
# =======  tikz tag  =========
# =======  tikz tag  =========
latexindent.pl -s 74878.tex -o 74878-default.tex
latexindent.pl -s -l indentPreamble.yaml 350144.tex -o 350144-default.tex
latexindent.pl -s -l indentPreamble.yaml,nextGroupPlot.yaml 350144.tex -o 350144-default-ngp.tex 
latexindent.pl -s -l indentPreamble.yaml,nextGroupPlot-headings.yaml 350144.tex -o 350144-default-ngp-headings.tex 
latexindent.pl -s 5461.tex -o 5461-default.tex
# christmas tree
latexindent.pl -s 39149-alain.tex -outputfile 39149-alain-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-alain.tex -outputfile 39149-alain-draw.tex -l indentPreamble.yaml,draw.yaml
latexindent.pl -s 39149-loop-space.tex -outputfile 39149-loop-space-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-loop-space.tex -outputfile 39149-loop-space-no-add-named.tex -l indentPreamble.yaml,no-add-named-braces.yaml
latexindent.pl -s 39149-loop-space2.tex -outputfile 39149-loop-space2-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-ruler-compass.sty -outputfile 39149-ruler-compass-default.sty 
latexindent.pl -s 39149-jake.tex -outputfile 39149-jake-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-morbusg.tex -outputfile 39149-morbusg-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-mark-wibrow1.tex -outputfile 39149-mark-wibrow1-default.tex -l indentPreamble.yaml
latexindent.pl -s 39149-mark-wibrow2.tex -outputfile 39149-mark-wibrow2-default.tex -l indentPreamble.yaml
#latexindent.pl -s 39149-SztupY.tex -outputfile 39149-SztupY-default.tex -l indentPreamble.yaml

# =======  pgfplots tag  =========
# =======  pgfplots tag  =========
# =======  pgfplots tag  =========
latexindent.pl -s 36297-jake.tex -outputfile 36297-jake-default.tex -l indentPreamble.yaml 
latexindent.pl -s 36297-patrick-hacker.tex -outputfile 36297-patrick-hacker-default.tex -l indentPreamble.yaml 
latexindent.pl -s 52987-jake.tex -outputfile 52987-jake-default.tex -l indentPreamble.yaml 
latexindent.pl -s 52987-anton.tex -outputfile 52987-anton-default.tex -l indentPreamble.yaml 
latexindent.pl -s 46422-michi.tex -outputfile 46422-michi-default.tex -l indentPreamble.yaml 
latexindent.pl -s 29293-christian-feuersanger.tex -outputfile 29293-christian-feuersanger-default.tex -l indentPreamble.yaml 
latexindent.pl -s 29359-jake.tex -outputfile 29359-jake-default.tex -l indentPreamble.yaml
latexindent.pl -s 29359-marco-daniel.tex -outputfile 29359-marco-daniel-default.tex -l indentPreamble.yaml
latexindent.pl -s 29359-christian-feuersanger.tex -outputfile 29359-christian-feuersanger-default.tex -l indentPreamble.yaml
latexindent.pl -s 31276-peter-grill.tex -outputfile 31276-peter-grill-default.tex -l indentPreamble.yaml
latexindent.pl -s 11368-jake.tex -outputfile 11368-jake-default.tex -l indentPreamble.yaml
latexindent.pl -s 127375-jake.tex -outputfile 127375-jake-default.tex -l indentPreamble.yaml
latexindent.pl -s 127375-thomas.tex -outputfile 127375-thomas-default.tex -l indentPreamble.yaml 
latexindent.pl -s 12207-christian-feuersanger.tex -o 12207-christian-feuersanger-default.tex -l indentPreamble.yaml 
latexindent.pl -s 12207-christian-feuersanger.tex -o 12207-christian-feuersanger-pin-mlb1.tex -m -l mlb-pin.yaml,indentPreamble.yaml  
latexindent.pl -s 12207-jake.tex -o 12207-jake-default.tex -l indentPreamble.yaml 
latexindent.pl -s 155194-andrew-swan.tex -o 155194-andrew-swan-default.tex -l indentPreamble.yaml  -tt -g one.log

# =======  latex3 tag  =========
# =======  latex3 tag  =========
# =======  latex3 tag  =========
latexindent.pl -s 253693 -o 253693-default.tex
git status
