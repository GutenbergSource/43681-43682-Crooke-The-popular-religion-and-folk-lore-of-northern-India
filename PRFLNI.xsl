<!DOCTYPE xsl:stylesheet [

    <!ENTITY aacute "&#x00E1;">
    <!ENTITY amacr "&#x0101;">
    <!ENTITY euml "&#x00EB;">
    <!ENTITY imacr "&#x012B;">
    <!ENTITY mdash "&#x2014;">
    <!ENTITY ndash "&#x2013;">
    <!ENTITY tdotb "&#x1E6D;">
    <!ENTITY umacr "&#x016B;">

]>
<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:stylesheet-functions"
    exclude-result-prefixes="f xs"
    version="2.0">

<xsl:include href="../../../../../Tools/tei2html/merge-documents.xsl"/>

<xsl:variable name="volume1" select="f:import-document('Volume 1/Processed/PRFLNI1.xml', /, 'v1', 'v2')"/>
<xsl:variable name="volume2" select="f:import-document('Volume 2/Processed/PRFLNI2.xml', /, 'v2', 'v1')"/>

<xsl:template match="/">
    <TEI.2 lang="en">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title nfc="4">The popular religion and folk-lore of northern India</title>
                <author key="Crooke, William" ref="http://viaf.org/viaf/64055494">William Crooke (1848&ndash;1923)</author>
                <respStmt><resp>Transcription</resp> <name>Jeroen Hellingman</name></respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>Project Gutenberg</publisher>
                <pubPlace>Urbana, Illinois, USA.</pubPlace>
                <idno type="LCCN">#####</idno>
                <idno type="OLW">#####</idno>
                <idno type="OCLC">#####</idno>
                <idno type="PGclearance">20090112070617crooke</idno>
                <idno type="PGSrc">43681-43682-Crooke-The-popular-religion-and-folk-lore-of-northern-India</idno>
                <idno type="epub-id">urn:uuid:7ea63e0f-471e-4ccd-9487-8d0c911a0db6</idno>
                <idno type="PGnum">#####</idno>
                <date>#####</date>

                <xsl:apply-templates select="$volume1//teiHeader/fileDesc/publicationStmt/availability"/>

            </publicationStmt>
            <sourceDesc>
                <bibl>
                <author>William Crooke</author>
                <title>The popular religion and folk-lore of northern India</title>
                <date>1896</date>
                </bibl>
            </sourceDesc>
        </fileDesc>

        <xsl:apply-templates select="$volume1//teiHeader/encodingDesc"/>
        <xsl:apply-templates select="$volume1//teiHeader/profileDesc"/>

        <revisionDesc>
            <list type="simple">
                <item>2013-09-03 started.</item>
            </list>
        </revisionDesc>
    </teiHeader>
    <text rend="stylesheet(style/classic.css)">
        <front id="frontmatter">
            <div1 id="cover" type="Cover">
                <p>
                    <figure id="cover-image" rend="image(images/new-cover.jpg)">
                        <figDesc>Newly Designed Front Cover.</figDesc>
                    </figure>
                </p>
            </div1>

            <xsl:apply-templates select="$volume1//front/div1[@id='v1titlepage']"/>
            <xsl:apply-templates select="$volume1//front/titlePage"/>
            <xsl:apply-templates select="$volume1//front/div1[@id='v1copyright' or @id='v1preface']"/>

            <div1 id="toc" type="Contents">
                <head>Contents</head>

                <div2 type="Contents">
                    <head>Volume I.</head>
                    <xsl:apply-templates select="$volume1//front/div1[@id='v1toc']/*[not(self::head)]"/>
                </div2>
                <div2 type="Contents">
                    <head>Volume II.</head>
                    <xsl:apply-templates select="$volume2//front/div1[@id='v2toc']/*[not(self::head)]"/>
                </div2>
            </div1>

        </front>
        <body>
            <xsl:apply-templates select="$volume1//body/*"/>
            <xsl:apply-templates select="$volume2//body/*"/>
        </body>
        <back id="backmatter">
            <xsl:apply-templates select="$volume1//back/div1"/>
            <xsl:apply-templates select="$volume2//back/div1"/>

            <div1 id="gentoc">
                <divGen id="genToc" type="toc"/>
            </div1>

            <divGen type="Colophon"/>
        </back>
    </text>
    </TEI.2>
</xsl:template>

<!-- Resolve cross-volume links encoded as external links to Project Gutenberg numbers -->
<xsl:template match="xref">
    <xsl:choose>
        <xsl:when test="starts-with(@url, 'pg:999991#')">
            <xsl:variable name="targetId" select="concat('v1', substring-after(@url, '#'))"/>
            <ref target="$targetId"><xsl:apply-templates/></ref>
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy-of select="."/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- Drop volume indication on title page -->
<xsl:template match="ab[@id='v1volumetitle']"/>

<xsl:template match="node()|@*">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>

</xsl:transform>
