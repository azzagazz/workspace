<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../utilities/typography.xsl"/>
    <xsl:import href="../sections/images.xsl"/>

<!--
    Index listing of Articles
    Used on /home/
-->
    <xsl:template match="*[section/@handle = 'articles']/entry" mode='index'>
        <div class="article">
            <xsl:apply-templates select='.' mode='header' />
            <xsl:apply-templates select='.' mode='meta' />
            <xsl:apply-templates select="body/*[position() &lt;= 2]" mode="html"/>
            <xsl:call-template name="get-images">
                <xsl:with-param name="entry-id" select="@id"/>
            </xsl:call-template>
            <xsl:apply-templates select="body/*[position() &gt; 2 and position() &lt;= 4]" mode="html"/>
        </div>
        <hr/>
    </xsl:template>

<!--
    Full Article display
    Used on /articles/read/{handle}
-->
    <xsl:template match="*[section/@handle = 'articles']/entry" mode='full'>
        <div class="article">
            <xsl:apply-templates select='.' mode='header' />
            <xsl:apply-templates select='.' mode='meta' />
            <xsl:apply-templates select="body/*[position() &lt;= 2]" mode="html"/>
            <xsl:call-template name="get-images">
                <xsl:with-param name="entry-id" select="@id"/>
            </xsl:call-template>
            <xsl:apply-templates select="body/*[position() &gt; 2]" mode="html"/>
        </div>
        <hr/>
    </xsl:template>

<!--
    Draft listing
    Used on /drafts/
-->
    <xsl:template match="*[section/@handle = 'articles']/entry" mode="list-draft">
        <ul class="list">
            <li class="date">
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="date"/>
                    <xsl:with-param name="format" select="'d m y'"/>
                </xsl:call-template>
            </li>
            <li class="title">
                <a href="{$root}/drafts/{title/@handle}/">
                    <xsl:value-of select="title"/>
                </a>
            </li>
            <li class="categories">
                <xsl:apply-templates select="categories/item"/>
            </li>
        </ul>
    </xsl:template>

<!--
    Draft full
    Used on /drafts/{id}
-->
    <xsl:template match="*[section/@handle = 'articles']/entry" mode='full-draft'>
        <xsl:apply-templates select='.' mode='full' />
        <form id="publish-article" action="" method="post">
            <fieldset>
                <input name="fields[publish]" value="yes" type="hidden" />
                <input name="redirect" value="{$root}/articles/{title/@handle}/" type="hidden" />
                <input name="id" value="{@id}" type="hidden" />
                <button id="submit" type="submit" name="action[publish-article]" value="Publish" />
            </fieldset>
        </form>
    </xsl:template>

<!--
    Archive listing
    Used on /archive/
-->
    <xsl:template match="*[section/@handle = 'articles']" mode='archive'>
        <xsl:apply-templates select="year/month"/>
    </xsl:template>

    <xsl:template match="month">
        <h4>
            <xsl:call-template name="format-date">
            <xsl:with-param name="date" select="concat(../@value, '-', @value, '-01')"/>
            <xsl:with-param name="format" select="'M y'"/>
            </xsl:call-template>
        </h4>
        <xsl:apply-templates select="entry" mode='list-archive' />
    </xsl:template>

    <xsl:template match="entry" mode='list-archive'>
        <ul class="list">
            <li class="date">
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="date"/>
                    <xsl:with-param name="format" select="'D'"/>
                </xsl:call-template>
            </li>
            <li class="title">
                <a href="{$root}/articles/{title/@handle}/">
                    <xsl:value-of select="title"/>
                </a>
            </li>
            <li class="comments">
                <a href="{$root}/articles/{title/@handle}/#comments">
                    <xsl:value-of select="concat('Comments (', @comments, ')')"/>
                </a>
            </li>
        </ul>
    </xsl:template>

<!--
    RSS Display
    Used on /rss/
-->
    <xsl:template match="*[section/@handle = 'articles']/entry" mode='rss'>
        <item>
            <title><xsl:value-of select="title"/></title>
            <link><xsl:value-of select="$root"/>/articles/<xsl:value-of select="title/@handle"/>/</link>
            <guid><xsl:value-of select="$root"/>/articles/<xsl:value-of select="title/@handle"/>/</guid>
            <pubDate>
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="date"/>
                    <xsl:with-param name="format" select="'w, d m Y T'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:value-of select="translate($timezone,':','')"/>
            </pubDate>
            <description><xsl:value-of select="body"/></description>
        </item>
    </xsl:template>

<!--
    Utilities
-->
    <xsl:template match='entry' mode='header'>
        <h3>
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="date"/>
                <xsl:with-param name="format" select="'D m Y'"/>
            </xsl:call-template>
            <xsl:if test="$is-logged-in">
                <xsl:text> &#8212; </xsl:text>
                <a class="edit" href="{$root}/symphony/publish/{../section/@handle}/edit/{@id}/">Edit</a>
            </xsl:if>
        </h3>
        <h2>
            <a href="{$root}/articles/{title/@handle}/">
                <xsl:value-of select="title"/>
            </a>
        </h2>
    </xsl:template>

    <xsl:template match='entry' mode='meta'>
        <ul class="meta">
            <li class="icon-filed-under">
                <xsl:apply-templates select="categories/item"/>
            </li>

            <xsl:if test='@comments'>
                <li class="icon-comments">
                    <a href="{$root}/articles/{title/@handle}/#comments">
                        <xsl:text>Comments (</xsl:text>
                        <xsl:value-of select="@comments"/>
                        <xsl:text>)</xsl:text>
                    </a>
                </li>
            </xsl:if>
        </ul>
    </xsl:template>

    <xsl:template match="categories/item">
        <xsl:value-of select="."/>
        <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>