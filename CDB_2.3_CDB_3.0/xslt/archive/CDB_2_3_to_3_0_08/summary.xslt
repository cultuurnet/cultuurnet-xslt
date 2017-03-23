<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" extension-element-prefixes="extfun" xmlns:extfun="external_functions" xmlns:xalan="http://xml.apache.org/xalan" version="1.0" exclude-result-prefixes="ot">
	<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>
	<xsl:template name="tijdelijk_summary">
		<xsl:for-each select="ot:opening_times">
			<xsl:for-each select="opening_times_instance">
				<xsl:variable name="pos" select="position()"/>
				<xsl:if test="position() = 1">
					<xsl:value-of select="day_type"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,1,4)"/>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' om '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if>
				</xsl:if>
				<xsl:if test="position() != 1">
					<!--xxx<xsl:copy-of select="../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start"></xsl:copy-of>zzz
						xxx<xsl:value-of select="time_start"></xsl:value-of>xxx
						zzz<xsl:value-of select="../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start"></xsl:value-of>zzz-->
					<xsl:value-of select="', '"/>
					<xsl:if test="substring(time_start,1,10) !=substring(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start,1,10)">
						<xsl:value-of select="day_type"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,9,2)"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="substring(time_start,6,2)"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="substring(time_start,1,4)"/>
					</xsl:if>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' om '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="period_summary">
		<xsl:value-of select="'Van '"/>
		<xsl:value-of select="substring(date_from,9,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_from,6,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_from,1,4)"/>
		<xsl:value-of select="' tot '"/>
		<xsl:value-of select="substring(date_to,9,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_to,6,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_to,1,4)"/>
		<xsl:for-each select="ot:opening_times">
			<!-- chack that an opening time that is not 23:00  or 00:00 is present -->
			<!--	<xsl:for-each select="opening_times_instance[open_type = 'open']"> -->
			<xsl:for-each select="opening_times_instance">
				<xsl:if test="string(open_type) = 'open'">
					<xsl:variable name="pos" select="position()"/>
			<!--xxx<xsl:value-of select="$pos"/>zzz-->
				<xsl:if test="position() = 1">
						<xsl:value-of select="' open op'"/>
					</xsl:if>
					<xsl:if test="position() != 1">
						<xsl:value-of select="','"/>
					</xsl:if>
					<xsl:if test="string(day_type) !=string(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/day_type)">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="day_type"/>
						
					</xsl:if>
					<xsl:if test="string(day_type) !=string(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/day_type) and
					substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'"><xsl:value-of select="' om '"/></xsl:if>
					
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="ot:opening_times">
			<xsl:for-each select="opening_times_instance[open_type = 'open op afspraak']">
				<xsl:if test="position() = 1">
					<xsl:value-of select="' op afspraak'"/>
				</xsl:if>
				<xsl:if test="position() != 1">
					<xsl:value-of select="','"/>
				</xsl:if>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="day_type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="substring(time_start,12,5)"/>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:variable name="shut">
			<!--
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year='1970']">
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="day_type"/>
				</xsl:for-each>
			</xsl:for-each>
			-->
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year != '1970']">
					<xsl:if test="position() = 1">
						<!-- <xsl:value-of select="' en '"/> -->
					</xsl:if>
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,1,4)"/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:variable>
		<xsl:if test="string($shut) != ''">
			<xsl:value-of select="' gesloten op '"/>
			<xsl:value-of select="$shut"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="permanent_summary">
		<xsl:value-of select="'Open '"/>
		<xsl:for-each select="ot:opening_times">
			<xsl:for-each select="opening_times_instance[open_type = 'open']">
				<xsl:if test="position() = 1">
					<xsl:value-of select="'op'"/>
				</xsl:if>
				<xsl:if test="position() != 1">
					<xsl:value-of select="','"/>
				</xsl:if>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="day_type"/>
				<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
					<xsl:value-of select="' '"/>
					<xsl:value-of select="substring(time_start,12,5)"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="ot:opening_times">
			<xsl:for-each select="opening_times_instance[open_type = 'open op afspraak']">
				<xsl:if test="position() = 1">
					<xsl:value-of select="' op afspraak'"/>
				</xsl:if>
				<xsl:if test="position() != 1">
					<xsl:value-of select="','"/>
				</xsl:if>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="day_type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="substring(time_start,12,5)"/>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:variable name="shut">
			<!--
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year='1970']">
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="day_type"/>
				</xsl:for-each>
				
			</xsl:for-each>
			-->
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year != '1970']">
					<xsl:if test="position() = 1">
						<!-- <xsl:value-of select="' en '"/> -->
					</xsl:if>
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,1,4)"/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:variable>
		<xsl:if test="string($shut) != ''">
			<xsl:value-of select="' gesloten op '"/>
			<xsl:value-of select="$shut"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
