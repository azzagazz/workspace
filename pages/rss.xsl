<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../utilities/date-time.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="yes" />

    <xsl:template match="data">
        <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
            <channel>
                <title><xsl:value-of select="$website-name"/></title>
                <link><xsl:value-of select="$root"/></link>
                <description><xsl:value-of select="$website-name"/> Feed</description>
                <language>en-us</language>
                <generator>Symphony (build <xsl:value-of select="$symphony-version"/>)</generator>
                <atom:link href="{$root}/rss/" rel="self" type="application/rss+xml" />
                <xsl:apply-templates select='rss-articles/entry' mode='rss' />
            </channel>
        </rss>
    </xsl:template>

</xsl:stylesheet>