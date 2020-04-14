<!-- MODS extensions for CTHS, providing fields not in the natural slurp. -->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
  version="1.0"
  exclude-result-prefixes="mods">

  <!-- Title field. -->
  <xsl:template match="mods:mods/mods:titleInfo[not(@type)]" name="title_template" mode="cths_mods_extensions">
    <xsl:variable name="title">
      <xsl:call-template name="cths_parse_title"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'title'"/>
      <xsl:with-param name="content" select="$title"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Sortable title field. -->
  <xsl:template match="mods:mods/mods:titleInfo[not(@type)][1]" mode="cths_mods_extensions">
    <!-- Call title_template so this also gets added to the _ms field. -->
    <xsl:call-template name="title_template"/>
    <xsl:variable name="title_no_nonSort">
      <xsl:call-template name="cths_parse_title">
        <xsl:with-param name="include_nonSort" select="false()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'title'"/>
      <xsl:with-param name="content" select="$title_no_nonSort"/>
      <xsl:with-param name="suffix" select="'_ss'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Uniform title field. -->
  <xsl:template match="mods:mods/mods:titleInfo[@type = 'uniform']" mode="cths_mods_extensions">
    <xsl:variable name="title_uniform">
      <xsl:call-template name="cths_parse_title"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'title_uniform'"/>
      <xsl:with-param name="content" select="$title_uniform"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Alternative title field. -->
  <xsl:template match="mods:mods/mods:titleInfo[@type = 'alternative']" mode="cths_mods_extensions">
    <xsl:variable name="title_alternative">
      <xsl:call-template name="cths_parse_title"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'title_alternative'"/>
      <xsl:with-param name="content" select="$title_alternative"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Creator field. -->
  <xsl:template match="mods:mods/mods:name[@type = 'personal' or @type = 'corporate'][mods:role/mods:roleTerm[.= 'Creator']]" name="name_creator_template" mode="cths_mods_extensions">
    <xsl:variable name="name_creator">
      <xsl:call-template name="cths_parse_name"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'name_creator'"/>
      <xsl:with-param name="content" select="$name_creator"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Personal name subject field. -->
  <xsl:template match="mods:mods/mods:subject/mods:name[@type = 'personal']" mode="cths_mods_extensions">
    <xsl:variable name="names_subject_personal_all">
      <xsl:call-template name="cths_parse_name"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'names_subject_personal_all'"/>
      <xsl:with-param name="content" select="$names_subject_personal_all"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Corporate name subject field. -->
  <xsl:template match="mods:mods/mods:subject/mods:name[@type = 'corporate']" mode="cths_mods_extensions">
    <xsl:variable name="names_subject_corporate_all">
      <xsl:call-template name="cths_parse_name"/>
    </xsl:variable>
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'names_subject_corporate_all'"/>
      <xsl:with-param name="content" select="$names_subject_corporate_all"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Genre field. -->
  <xsl:template match="mods:mods/mods:genre[not(@type)]" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'genre_noType'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Subject (not lcsh) field. -->
  <xsl:template match="mods:mods/mods:subject[not(@authority = 'lcsh')]/mods:topic" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'subject_not_lcsh'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Library call number field. -->
  <xsl:template match="mods:mods/mods:classification[@authority = 'local'][@displayLabel = 'Library call number']" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'library_call_number'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- LC type call number field. -->
  <xsl:template match="mods:mods/mods:classification[@authority = 'local'][@displayLabel = 'LC-type call number']" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'lc_type_call_number'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Koha identifier field. -->
  <xsl:template match="mods:mods/mods:recordInfo/mods:recordIdentifier[@source = 'koha']" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'koha_identifier'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Date created (qualified) field. -->
  <xsl:template match="mods:mods/mods:originInfo/mods:dateCreated[not(@encoding)]" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'date_created_no_encoding'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Date issued (qualified) field. -->
  <xsl:template match="mods:mods/mods:originInfo/mods:dateIssued[not(@encoding)]" mode="cths_mods_extensions">
    <xsl:call-template name="cths_write_field">
      <xsl:with-param name="field" select="'date_issued_no_encoding'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Template to write titles. -->
  <xsl:template name="cths_parse_title">
    <xsl:param name="include_nonSort" select="true()"/>

    <xsl:if test="$include_nonSort">
      <xsl:value-of select="normalize-space(mods:nonSort)"/>
      <xsl:if test="mods:nonSort">
        <xsl:text> </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="normalize-space(mods:title)"/>
    <xsl:if test="mods:subTitle">
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:value-of select="normalize-space(mods:subTitle)"/>
    <xsl:if test="mods:partName">
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:value-of select="normalize-space(mods:partName)"/>
    <xsl:if test="mods:partNumber">
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:value-of select="normalize-space(mods:partNumber)"/>
  </xsl:template>

  <!-- Template to write names. -->
  <xsl:template name="cths_parse_name">
    <!-- Lifted from www.loc.gov/standards/mods/v3/MODS3-5_DC_XSLT2-0.xsl. -->
    <xsl:for-each select="mods:namePart[not(@type)]">
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text> </xsl:text>
    </xsl:for-each>
    <xsl:value-of select="normalize-space(mods:namePart[@type='family'])"/>
    <xsl:if test="mods:namePart[@type='given']">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="normalize-space(mods:namePart[@type='given'])"/>
    </xsl:if>
    <xsl:if test="mods:namePart[@type='date']">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="normalize-space(mods:namePart[@type='date'])"/>
      <xsl:text/>
    </xsl:if>
    <xsl:if test="mods:displayForm">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="normalize-space(mods:displayForm)"/>
      <xsl:text>) </xsl:text>
    </xsl:if>
    <xsl:for-each select="mods:role[mods:roleTerm[@type='text']!='creator']">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="normalize-space(child::*)"/>
      <xsl:text>) </xsl:text>
    </xsl:for-each>
  </xsl:template>

  <!-- Field writer. -->
  <xsl:template name="cths_write_field">
    <xsl:param name="field"/>
    <xsl:param name="content" select="."/>
    <xsl:param name="suffix" select="'_ms'"/>
    <xsl:if test="not($content = '')">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat('cths_mods_', $field, $suffix)"/>
        </xsl:attribute>
        <xsl:value-of select="$content"/>
      </field>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
