#This shell script assumes availability of
#  tidy (https://github.com/htacg/tidy-html5/)
#  and saxon (https://saxonica.com/download/download_page.xml)
#It expects to run at the root of a local copy of a repo containing
# HTML sources in a folder called texts
# 
# Sample invocation from command line
#  ./makeTEI.sh 0012 12labsinthe.html
#
tidy -asxml -n  -o $1.tmp texts/$2 > tidyErrs
saxon $1.tmp TEI/Scripts/conv1.xsl  | saxon - TEI/Scripts/conv2.xsl > TEI/W$1.xml

