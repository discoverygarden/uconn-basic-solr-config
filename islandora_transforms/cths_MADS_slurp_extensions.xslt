<!-- MADS extensions for CTHS, providing fields not in the natural slurp. -->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mads="http://www.loc.gov/mads/v2"
  version="1.0"
  exclude-result-prefixes="mads">

  <!-- Display Name field. -->
  <xsl:template match="mads:mads/mads:variant/mads:name[@type= 'personal']/mads:namePart[@type = 'fullerForm']" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'display_name'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Organization Name field. -->
  <xsl:template match="mads:mads/mads:authority/mads:name[@type= 'corporate']/mads:namePart" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'organization_name'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Birth Date field. -->
  <xsl:template match="mads:mads/mads:personInfo/mads:birthDate[@encoding = 'iso8601']" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'birth_date'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Death Date field. -->
  <xsl:template match="mads:mads/mads:personInfo/mads:deathDate[@encoding = 'iso8601']" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'death_date'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Start Date field. -->
  <xsl:template match="mads:mads/mads:organizationInfo/mads:startDate[@encoding = 'iso8601']" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'start_date'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- End Date field. -->
  <xsl:template match="mads:mads/mads:organizationInfo/mads:endDate[@encoding = 'iso8601']" mode="cths_mads_extensions">
    <xsl:call-template name="cths_write_mads_field">
      <xsl:with-param name="field" select="'end_date'"/>
      <xsl:with-param name="content" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Field writer. -->
  <xsl:template name="cths_write_mads_field">
    <xsl:param name="field"/>
    <xsl:param name="content" select="."/>
    <xsl:param name="suffix" select="'_ms'"/>
    <xsl:if test="not($content = '')">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat('cths_mads_', $field, $suffix)"/>
        </xsl:attribute>
        <xsl:value-of select="$content"/>
      </field>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
