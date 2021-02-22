<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="3.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Format ">
    <xsl:output method="html"/>
    <xsl:strip-space elements="section"/>

    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/article/title">
        <h1 align="center">
            <xsl:apply-templates/>
        </h1>
    </xsl:template>

    <!-- Top Level Heading -->
    <xsl:template match="/article/section/section">
        <div>
            <xsl:apply-templates select="section|B|I|U|DEF|link"/>
        </div>
        <xsl:apply-templates select="section|PARA|list|NOTE"/>
    </xsl:template>

    <!--    &lt;!&ndash; Second-Level Heading &ndash;&gt;-->
    <!--    <xsl:template match="/article/section/section">-->
    <!--        <h3> <xsl:apply-templates select="text()|B|I|U|DEF|LINK"/> </h3>-->
    <!--        <xsl:apply-templates select="section|PARA|LIST|NOTE"/>-->
    <!--    </xsl:template>-->

    <!-- Third-Level Heading -->
    <xsl:template match="/ARTICLE/SECT/SECT/SECT">
        <xsl:message terminate="yes">Error: Sections can only be nested 2 deep.</xsl:message>
    </xsl:template>

    <!-- Paragraph -->
    <xsl:template match="para">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Code -->
    <xsl:template match="code">
    <span style="font-style:italic;">
        <xsl:apply-templates select="text()"/>
    </span>
    </xsl:template>


    <!-- Title -->
    <xsl:template match="title">
        <h2>
            <xsl:apply-templates select="text()|B|I|U|DEF|LINK"/>
        </h2>
        <xsl:apply-templates select="title|LIST|NOTE"/>
    </xsl:template>

    <!-- Text -->

      <xsl:template match="text()">
        <xsl:value-of select="normalize-space()"/>
      </xsl:template>


<!--    &lt;!&ndash; LIST  &ndash;&gt;-->
<!--    <xsl:template match="orderedlist">-->
<!--        <xsl:if test="@type='ordered'">-->
<!--            <ol>-->
<!--                <xsl:apply-templates/>-->
<!--            </ol>-->
<!--        </xsl:if>-->
<!--        <xsl:if test="@type='unordered'">-->
<!--            <ul>-->
<!--                <xsl:apply-templates/>-->
<!--            </ul>-->
<!--        </xsl:if>-->
<!--    </xsl:template>-->

    <!-- LIST  -->
    <xsl:template match="orderedlist">
            <ol type ="1">
                <xsl:apply-templates/>
            </ol>
    </xsl:template>

    <!-- LIST  -->
    <xsl:template match="itemizedlist">
            <ul>
                <xsl:apply-templates/>
            </ul>
    </xsl:template>

    <!-- list ITEM -->
    <xsl:template match="listitem">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

<!--    <xsl:template match="NOTE">-->
<!--        <blockquote>-->
<!--            <b>Note:</b>-->
<!--            <br/>-->
<!--            <xsl:apply-templates/>-->
<!--        </blockquote>-->
<!--    </xsl:template>-->

<!--    <xsl:template match="DEF">-->
<!--        <i>-->
<!--            <xsl:apply-templates/>-->
<!--        </i>-->
<!--    </xsl:template>-->

    <xsl:template match="B|I|U">
        <xsl:element name="{name()}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ulink">
        <xsl:if test="@target">
            <!--Target attribute specified.-->
            <xsl:call-template name="htmLink">
                <xsl:with-param name="dest" select="@target"/>  <!--Destination = attribute value-->
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="not(@target)">
            <!--Target attribute not specified.-->
            <xsl:call-template name="htmLink">
                <xsl:with-param name="dest">
                    <xsl:apply-templates/>  <!--Destination value = text of node-->
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!-- A named template that constructs an HTML link -->
    <xsl:template name="htmLink">
        <xsl:param name="dest" select="UNDEFINED"/> <!--default value-->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$dest"/> <!--link target-->
            </xsl:attribute>
            <xsl:apply-templates/> <!--name of the link from text of node-->
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>