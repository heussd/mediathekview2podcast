<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="date">
	<xsl:output indent="yes"/>
	<xsl:template match="/">
			<rss xmlns:content="http://purl.org/rss/1.0/modules/content/"
			  xmlns:dc="http://purl.org/dc/elements/1.1/"
			  xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/"
			  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
			  version="2.0">
			  <channel>
			    <title>&#8482; TV</title>
			    <language>de-DE</language>

			    <xsl:variable name="today" select="translate(substring-before(date:date-time(), 'T'), '-', '')"/>
			    <xsl:variable name="minDate" select="translate(substring-before(date:add(date:date-time(), '-P1M'), 'T'), '-', '')" />

				<!-- Iterate over Downlads (sic!) that are not in the future. Podcast items with future dates are likely to cause problem in podcasting apps, e.g. the iOS Podcast app. Also, limit to items published within the last month-->
				<xsl:for-each select="Mediathek/Downlad[concat(substring-after(substring-after(Datum, '.'), '.'),substring-before(substring-after(Datum, '.'),'.'),substring-before(Datum, '.')) &lt;= $today and concat(substring-after(substring-after(Datum, '.'), '.'),substring-before(substring-after(Datum, '.'),'.'),substring-before(Datum, '.')) &gt; $minDate]">

				 	<!-- Produce a ISO 8601 date format with built in XSLT 1.0 capabilities -->
					<xsl:variable name="isoDate" select="concat(substring-after(substring-after(Datum, '.'), '.'),'-',substring-before(substring-after(Datum, '.'),'.'),'-',substring-before(Datum, '.'))" />
					<xsl:variable name="month" select="substring-before(substring-after(Datum, '.'),'.')" />
					<xsl:variable name="day" select="substring-before(Datum, '.')" />
					<xsl:variable name="year" select="substring-after(substring-after(Datum, '.'), '.')" />

					 <item>
					      <title><xsl:value-of select="Sender" /> - <xsl:value-of select="Thema" /></title>
					      <description><xsl:value-of select="Titel" /></description>
					      <link><xsl:value-of select="Film-URL" /></link>

					      <enclosure>
					      	<xsl:attribute name="url">
							    <xsl:value-of select="Film-URL" />
							</xsl:attribute>
							<xsl:attribute name="length">0</xsl:attribute>
					      </enclosure>
					      
						<xsl:variable name="monthName">
						<xsl:choose>
							<xsl:when test="$month = '01'">Jan</xsl:when>
							<xsl:when test="$month = '02'">Feb</xsl:when>
						    <xsl:when test="$month = '03'">Mar</xsl:when>
							<xsl:when test="$month = '04'">Apr</xsl:when>
							<xsl:when test="$month = '05'">May</xsl:when>
							<xsl:when test="$month = '06'">Jun</xsl:when>
							<xsl:when test="$month = '07'">Jul</xsl:when>
							<xsl:when test="$month = '08'">Aug</xsl:when>
						    <xsl:when test="$month = '09'">Sep</xsl:when>
						    <xsl:when test="$month = '10'">Oct</xsl:when>
							<xsl:when test="$month = '11'">Nov</xsl:when>
						    <xsl:when test="$month = '12'">Dec</xsl:when>
						    <xsl:otherwise/>
						</xsl:choose>
						</xsl:variable>
						
				      <!--<pubDate>Thu, <xsl:value-of select="concat($day, ' ', $monthName, ' ', $year)"/>&#160;<xsl:value-of select="date:time()"/></pubDate>-->
				      <!-- iOS Podcast app will not show new podcasts with an older date. Use current timestamp here -->
				      <pubDate><xsl:value-of select="substring(date:day-name(), 1, 3)"/>, <xsl:value-of select="date:day-in-month()"/>&#160;<xsl:value-of select="substring(date:month-name(), 1, 3)"/>&#160;<xsl:value-of select="date:year()"/>&#160;<xsl:value-of select="date:time()"/></pubDate>
				      <dc:date><xsl:value-of select="$isoDate" />T<xsl:value-of select="date:time()"/></dc:date>

				      <guid isPermaLink="true"><xsl:value-of select="Film-URL" /></guid>
				      <itunes:author><xsl:value-of select="Sender" /> </itunes:author>
				    </item>

	 			</xsl:for-each>
			</channel>
		</rss>
	</xsl:template>
</xsl:stylesheet>