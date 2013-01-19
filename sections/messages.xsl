<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name='build-messages-form'>
        <form action="" method="post">
            <xsl:apply-templates select='events/save-message' mode='build-form-status' />
            <fieldset>
                <label class="required">
                    <xsl:text>Name </xsl:text>
                    <input type="text" name="fields[name]" value="{events/save-message/post-values/name}" />
                </label>
                <label class="required">
                    <xsl:text>Email </xsl:text>
                    <input type="text" name="fields[email]" value="{events/save-message/post-values/email}" />
                </label>
                <label class="required">
                    <xsl:text>Subject </xsl:text>
                    <xsl:choose>
                        <xsl:when test="events/save-message/post-values/subject">
                            <input type="text" name="fields[subject]" value="{events/save-message/post-values/subject}" />
                        </xsl:when>
                        <xsl:otherwise>
                            <input type="text" name="fields[subject]" value="General Enquiry" />
                        </xsl:otherwise>
                    </xsl:choose>
                </label>
                <label>
                    <xsl:text>Message </xsl:text>
                    <textarea name="fields[message]" rows="5" cols="21"><xsl:value-of select="events/save-message/post-values/message" /></textarea>
                </label>

                <input name="send-email[recipient]" value="{website-owner/author/username}" type="hidden" />
                <input name="send-email[reply-to-email]" value="fields[email]" type="hidden" />
                <input name="send-email[reply-to-name]" value="fields[name]" type="hidden" />
                <input name="send-email[subject]" value="fields[subject]" type="hidden" />
                <input name="send-email[body]" value="fields[message],fields[subject],fields[email],fields[name]" type="hidden" />
                <input id="submit" type="submit" name="action[save-message]" value="Send" />
            </fieldset>
        </form>
    </xsl:template>

    <xsl:template match="save-message" mode='build-form-status'>
        <p class="{@result}">
            <xsl:choose>
                <xsl:when test="@result = 'error'">The system encountered errors while sending your email. Please check if all the required fields have been filled.</xsl:when>
                <xsl:when test="filter/@status = 'failed'">
                    <xsl:attribute name="class">error</xsl:attribute>
                    <xsl:text>The system encountered technical problems while sending your email.</xsl:text>
                </xsl:when>
                <xsl:otherwise>Email sent.</xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>

</xsl:stylesheet>

