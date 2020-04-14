<!-- MODS extensions for CTHS. Slurps for fields with "all" suffixes.-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
  version="1.0"
  exclude-result-prefixes="mods">

  <!-- All titles. -->
  <xsl:template match="//mods:titleInfo" mode="cths_mods_extensions_all_suffix">
    <xsl:variable name="titles_all">
      <xsl:call-template name="cths_parse_title"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'titles_all'"/>
      <xsl:with-param name="content" select="$titles_all"/>
    </xsl:call-template>
  </xsl:template>

  <!-- All personal names. -->
  <xsl:template match="mods:mods//mods:name[@type = 'personal']" mode="cths_mods_extensions_all_suffix">
    <xsl:variable name="names_personal_all">
      <xsl:call-template name="cths_parse_name"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'names_personal_all'"/>
      <xsl:with-param name="content" select="$names_personal_all"/>
    </xsl:call-template>
  </xsl:template>

  <!-- All corporate names. -->
  <xsl:template match="mods:mods//mods:name[@type = 'corporate']" mode="cths_mods_extensions_all_suffix">
    <xsl:variable name="names_corporate_all">
      <xsl:call-template name="cths_parse_name"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'names_corporate_all'"/>
      <xsl:with-param name="content" select="$names_corporate_all"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Hierarchical subjects field. -->
  <xsl:template match="mods:mods/mods:subject[@authority = 'lcsh' and not(mods:geographic and count(*) = 1)]" mode="cths_mods_extensions_all_suffix">
    <xsl:variable name="subjects">
      <xsl:for-each select="./*">
        <!-- Sort criteria: name, titleInfo, then the rest. -->
        <xsl:sort select="not(local-name() = 'name')"/>
        <xsl:sort select="not(local-name() = 'titleInfo')"/>
        <xsl:choose>
          <xsl:when test="local-name() = 'name'">
            <xsl:call-template name="cths_parse_name"/>
          </xsl:when>
          <xsl:when test="local-name() = 'titleInfo'">
            <xsl:call-template name="cths_parse_title"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position() != last()">
          <xsl:text>--</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'subject_lcsh_hierarchical'"/>
      <xsl:with-param name="content" select="$subjects"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Genre field. -->
  <xsl:template match="mods:mods/mods:genre" mode="cths_mods_extensions_all_suffix">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'genre_all'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Form field. -->
  <xsl:template match="mods:mods/mods:physicalDescription/mods:form" mode="cths_mods_extensions_all_suffix">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'form_all'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
