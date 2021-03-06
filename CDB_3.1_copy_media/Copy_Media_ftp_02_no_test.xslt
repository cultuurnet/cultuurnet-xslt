<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Updated on 27/08/10 to add the externalid prefix to the image filename to ensure it is unique.

This version for 3.1 Draft = IIS 3.0


This xslt is to be used on the publisher side of IIS3.
It copies the xml with no modifications so it can be used as input to the OOSDB
It copies media files from the file where the XML is to a directory specified in a variable or in the code
It copies text files from the file where the XML is to the longdescription tag.
Only use this for external imports  (Socuis, SKB etc). It is not needed for feeds from the CDB as the media references will be coprrect.
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:java="http://xml.apache.org/xalan/java" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:extfun="external_functions" xmlns:file="java.io.File" xmlns:url="java.net.URL" xmlns:stream="java.io.OutputStreamWriter" xmlns:xalan="http://xml.apache.org/xalan" exclude-result-prefixes="n1  xalan java extfun file">
	<!--   xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL"  -->
	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>
	<xalan:component prefix="extfun">
		<xalan:script lang="javascript"><![CDATA[ 
		
		//------------------------------------------------------------ 
		function writeLoopjpg_test(file_in,url_out)
		 {
		 
		// This works but is very slow.
			
		var url_1 = new java.net.URL(url_out);
		
		var  connection = url_1.openConnection();
		connection.setDoOutput(true);
		
		//The following gives an error when the file doesn't exist which means we want to copy it
		try {
			var content = url_1.getContent()
			}
			catch(err)
			{
		
				// make sure we can access the output url
				try {
					var output_stream = java.io.OutputStream(connection.getOutputStream())
					}
					catch(err)
					{
					return false
					}
		
		
				// make sure the input file exists
				try 	{
						var input_file = java.io.FileInputStream(file_in)
						}
						catch(err)
						{
						return false
						}
	
				while ((read = input_file.read()) != -1) 
				{	
				var write = output_stream.write(read)
				}
		

			var close_1 = input_file.close()
				var close_2 = output_stream.close()

		 return 'true'
		 }
		 //file exists
		 return 'false'
		 }
	
		]]></xalan:script>
	</xalan:component>
	<!-- usage 
	<xsl:param name="iis.ext.dir"/>
	<xsl:variable name="filename" select="concat($iis.ext.dir,'/',$filename_from)"/>
	-->
	<xsl:param name="iis.publication.externalIdPrefix"/>
	<xsl:param name="iis.publication.name"/>
	<xsl:param name="iis.publication.id"/>
	<xsl:template match="/">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	<xsl:template match="node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="n1:file">
		<file>
			<xsl:variable name="local_dir_1">
				<xsl:value-of select="java:org.apache.xalan.lib.NodeInfo.systemId()"/>
			</xsl:variable>
			<xsl:variable name="local_dir_2">
				<xsl:choose>
					<!--for the test BE PC strip off the leading file://-->
					<xsl:when test="contains($local_dir_1,'D:/XML/XML')">
						<xsl:value-of select="substring($local_dir_1,9)"/>
					</xsl:when>
					<!--for IIS3 strip off the leading file: -->
					<xsl:otherwise>
						<xsl:value-of select="substring($local_dir_1,6)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="local_dir_3">
				<xsl:call-template name="string_to_last_slash">
					<xsl:with-param name="text_string" select="$local_dir_2"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- if the filename is a reference then leave it and do nothing. The export will get the file and copy it into the xmls zip file -->
			<!-- if the media file is in the input zip file then copy it to an ftp site -->
			<!-- ftp://media:cnET2008Udb@media.cultuurnet.be/partnermedia -->
			<!--
			<xsl:value-of select="$iis.publication.externalIdPrefix"/>
			<xsl:value-of select="$iis.publication.name"/>
			<xsl:value-of select="$iis.publication.id"/>
			-->
			<!-- the filename can only be 250 characters long -->
			<xsl:variable name="fiename_length">
				<xsl:value-of select="string-length(n1:filename)"/>
			</xsl:variable>
			<xsl:variable name="externalid_length">
				<xsl:value-of select="string-length($iis.publication.externalIdPrefix)"/>
			</xsl:variable>
			<xsl:variable name="filename_from_plus_ext_id_length">
				<xsl:value-of select="$externalid_length+1+$fiename_length"/>
			</xsl:variable>
			
			<xsl:variable name="filename_from" select="n1:filename"/>
			<!-- <xsl:variable name="filename_from_plus_ext_id" select="substring(concat($iis.publication.externalIdPrefix,'_',$filename_from),1,200)"/> -->
			<xsl:variable name="filename_from_plus_ext_id">
				<xsl:choose>
					<xsl:when test="$filename_from_plus_ext_id_length &gt; 200">
					<xsl:variable name="too_long_by"><xsl:value-of select="$filename_from_plus_ext_id_length - 200"></xsl:value-of></xsl:variable>
					<xsl:variable name="start_from"><xsl:value-of select="$too_long_by+$externalid_length+1"></xsl:value-of></xsl:variable>
					<xsl:value-of select="concat($iis.publication.externalIdPrefix,'_',substring($filename_from,$start_from))"></xsl:value-of>
					
					
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="concat($iis.publication.externalIdPrefix,'_',$filename_from)"></xsl:value-of></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			
			
			
			
			<xsl:variable name="full_filename_from" select="concat($local_dir_3,$filename_from)"/>
			<xsl:variable name="filename" select="concat('ftp://media:cnET2008Udb@media.cultuurnet.be/partnermedia','/',$filename_from_plus_ext_id)"/>
			<xsl:variable name="file" select="file:new($filename)"/>
			<!--
			<xsl:value-of select="$full_filename_from"/>
			<xsl:value-of select="'                      '"/>
			<xsl:value-of select="$filename"/>
			-->
			<!-- no test for some partners that didn't send the media files to start with 
			<xsl:if test="not(file:exists($file))">   -->
				<xsl:if test="extfun:writeLoopjpg_test($full_filename_from,$filename)"/>
				<!-- to test <xsl:value-of select="extfun:writeLoopjpg_test($full_filename_from,$filename)"></xsl:value-of> -->
			<!-- /xsl:if> -->
			<xsl:copy-of select="n1:copyright"/>
			<filename>
				<xsl:choose>
					<xsl:when test="substring(n1:hlink,1,4) != 'http'">
						<xsl:value-of select="$filename_from_plus_ext_id"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="n1:filename"/>
					</xsl:otherwise>
				</xsl:choose>
			</filename>
			<xsl:copy-of select="n1:filetype"/>
			<hlink>
				<xsl:choose>
					<xsl:when test="substring(n1:hlink,1,4) != 'http'">
						<xsl:value-of select="$filename"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="n1:hlink"/>
					</xsl:otherwise>
				</xsl:choose>
			</hlink>
			<xsl:copy-of select="n1:mediatype"/>
			<xsl:copy-of select="n1:title"/>
		</file>
	</xsl:template>
	<xsl:template name="string_to_last_slash">
		<xsl:param name="text_string"/>
		<xsl:choose>
			<xsl:when test="contains($text_string,'/')">
				<xsl:value-of select="substring-before($text_string,'/')"/>
				<xsl:value-of select="'/'"/>
				<xsl:call-template name="string_to_last_slash">
					<xsl:with-param name="text_string" select="substring-after($text_string,'/')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- <xsl:value-of select="$text_string"/> -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="string_after_last_slash">
		<xsl:param name="text_string"/>
		<xsl:choose>
			<xsl:when test="contains($text_string,'/')">
				<!--<xsl:value-of select="substring-before($text_string,'/')"/>
				<xsl:value-of select="'/'"/> -->
				<xsl:call-template name="string_after_last_slash">
					<xsl:with-param name="text_string" select="substring-after($text_string,'/')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text_string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
