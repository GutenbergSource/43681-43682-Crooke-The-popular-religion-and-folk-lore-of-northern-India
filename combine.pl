
use strict;

my $saxon = "java -jar ..\\..\\..\\..\\..\\Tools\\tei2html\\tools\\lib\\saxon9he.jar "; # (see http://saxon.sourceforge.net/)

print "Create combined XML version of The popular religion and folk-lore of northern India...\n";

# system ("mkdir images")
# system ('copy "Volume 1\\Gutenberg\\images\\*.*" images')
# system ('copy "Volume 2\\Gutenberg\\images\\*.*" images')

system ("$saxon PRFLNI.xsl PRFLNI.xsl > PRFLNI.xml");

system ("perl -S tei2html.pl -h PRFLNI.xml");
system ("perl -S tei2html.pl -e PRFLNI.xml");
