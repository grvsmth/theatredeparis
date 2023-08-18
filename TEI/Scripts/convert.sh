#script should be run in local copy of theatredeparis repo
tidy -asxml -n texts/$2 > tmp/$2
saxon tmp/$2 TEI/conv1.xsl  | saxon - TEI/conv2.xsl > TEI/W$1.xml

