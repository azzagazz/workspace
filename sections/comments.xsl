<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
    Comments listing
    Used on /articles/{handle}
-->
    <xsl:template match="*[section/@handle = 'comments']" mode='article-comments'>
        <h3>
            <xsl:text>Comments</xsl:text>
            <xsl:if test="$is-logged-in">
                <xsl:text> &#8212; </xsl:text>
                <a href="{$root}/symphony/publish/comments/?filter=article:{/data/article/entry/@id}">Manage</a>
            </xsl:if>
        </h3>
        <div id="comments">
            <xsl:apply-templates select="entry" mode='listing' />
            <xsl:apply-templates select="error"/>
        </div>
    </xsl:template>

    <xsl:template match="*[section/@handle = 'comments']/entry" mode='listing'>
        <dl class="comment">
            <dt>
                <xsl:choose>
                    <xsl:when test="website">
                        <a href="{website}">
                            <xsl:value-of select="author"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="author"/>
                    </xsl:otherwise>
                </xsl:choose>
                <em>
                    <xsl:call-template name="format-date">
                        <xsl:with-param name="date" select="date"/>
                        <xsl:with-param name="format" select=" 'd m y, t' "/>
                    </xsl:call-template>
                </em>
            </dt>
            <dd>
                <xsl:copy-of select="comment/*"/>
            </dd>
        </dl>
    </xsl:template>

    <xsl:template match="*[section/@handle = 'comments']/error">
        <p>There are no comments made so far.</p>
    </xsl:template>

<!--
    Form to submit a new comment
    Used on /article/read/
-->
    <xsl:template name='build-comments-form'>
        <form action="" method="post">
            <xsl:apply-templates select='events/save-comment' mode='build-form-status' />
            <fieldset>
                <label>
                    <xsl:text>Name </xsl:text>
                    <input type="text" name="fields[author]" value="{events/save-comment/post-values/author}" />
                </label>
                <label>
                    <xsl:text>Email </xsl:text>
                    <input type="text" name="fields[email]" value="{events/save-comment/post-values/email}" />
                </label>
                <label>
                    <xsl:text>Website </xsl:text>
                    <input type="text" name="fields[website]" value="{events/save-comment/post-values/website}" />
                </label>
                <label>
                    <xsl:text>Comment </xsl:text>
                    <textarea name="fields[comment]" rows="5" cols="21"><xsl:value-of select="events/save-comment/post-values/comment" /></textarea>
                </label>

                <input name="fields[article]" value="{article/entry/@id}" type="hidden" />
                <input id="submit" type="submit" name="action[save-comment]" value="Post Comment" />
            </fieldset>
        </form>
    </xsl:template>

    <xsl:template match="*" mode='build-form-status'>
        <xsl:choose>
            <xsl:when test="@result = 'success'">
                <p class="{@result}">Your comment has been saved successfully.</p>
            </xsl:when>
            <xsl:otherwise>
                <div class="{@result}">
                <p>The system encountered errors when saving your comment.</p>
                    <ul>
                        <xsl:for-each select='//@message'>
                            <li><xsl:value-of select="."/></li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>