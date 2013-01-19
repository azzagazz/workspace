<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../utilities/master.xsl"/>
    <xsl:import href="../sections/articles.xsl"/>
    <xsl:import href="../sections/comments.xsl"/>

    <xsl:template match="data">
        <xsl:apply-templates select="article/entry" mode='full' />
        <xsl:apply-templates select="comments" mode='article-comments' />
        <hr />
        <h3>Make a comment</h3>
        <div id="guideline">
            <h4>Rules</h4>
            <ul>
                <li>Please keep the language PG-13, my mum reads this blog. Hi mum!</li>
                <li>Text is formatted with <a href="http://daringfireball.net/projects/markdown/syntax">Markdown</a>.</li>
            </ul>
        </div>
        <xsl:call-template name='build-comments-form' />
    </xsl:template>

</xsl:stylesheet>