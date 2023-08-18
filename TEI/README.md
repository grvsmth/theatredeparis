##TEI Versions

This directory contains TEI versions of the HTML texts available from
this repository in July 2023. These versions were created by first
converting the HTML versions to XHTML with Dave Ragget’s tidy utility:
these normalised versions are stored in the folder tmp, and then
converted by a sequence of of XSLT transformations, using saxon.  The
resulting XML output was then visually checked against the PDF sources
indicated in the spreadsheet napoleonicSample.xml.  The oXygen editor
was used to complete the manual part of the conversion. Bash and xslt
scripts used to do the transformations are in the directory Scripts.

The goal is to produce versions compatible with the DRACOR
(http://dracor.org) schema. The current versions conform to a version
of the DRACOR schema expanded to include elements byline, and
docImprint.  Work on enriching and making more uniform the encoding of
the texts is in progress.


