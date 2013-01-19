<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../utilities/master.xsl"/>
    <xsl:import href="../sections/messages.xsl"/>
    
    <xsl:template match="data">
        <h3>Biography</h3>
        <h2>
            <xsl:value-of select="website-owner/author/name"/>
            <xsl:text> is a professional space monkey extraordinaire</xsl:text>
        </h2>
        <p><em><xsl:value-of select="$website-name"/></em> is running off a freshly installed copy of <a href="http://symphony-cms.com">Symphony CMS</a>.</p>
        <p>Be sure to check back regularly as the site transforms from <em>fresh prince</em> to <em>whizz-bang candy steak</em>.</p>
        <hr/>
        <h3>Contact Me</h3>
        <div id="guideline">
            <h4>Notes</h4>
            <ul>
                <li>It's preferred to use the contact form rather than email. There is always a chance for emails to be picked up as spam.</li>
                <li>I will generally reply to messages within 24 hours unless I am horribly swamped.</li>
            </ul>
        </div>
        <xsl:call-template name='build-messages-form' />
    </xsl:template>

</xsl:stylesheet>