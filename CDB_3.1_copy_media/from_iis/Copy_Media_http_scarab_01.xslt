<?xml version="1.0" encoding="ISO-8859-1"?>
<!--

-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:java="http://xml.apache.org/xalan/java" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:extfun="external_functions" xmlns:url="java.net.URL" xmlns:file="java.io.File" xmlns:stream="java.io.OutputStreamWriter" xmlns:xalan="http://xml.apache.org/xalan" exclude-result-prefixes="n1  xalan java extfun file">
	<!--   xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL"  -->
	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>
	<xalan:component prefix="extfun">
		<xalan:script lang="javascript"><![CDATA[ 
		
		 
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx		 
		 
		 function filetofile_http(file_in,file_out)
		 {
		 var url = new java.net.URL(file_in);
		 
		 //put this here. If the file is empty then it will show up in the ftp site with lenght zero.
		 var output_file = java.io.FileOutputStream(file_out)
		
		var  connection = url.openConnection();
		
		connection.setDoOutput(true);
		
		//var input_stream = java.io.InputStream(connection.getInputStream())
		//while ((read = input_stream.read()) != -1) 
		//{
		//var write = output_file.write(read)
		//}
		
		// test   return connection.getContentLength()
		
		if (connection.getContentLength() > 0)
		{
		
		
		try 	{
				var input_stream = java.io.InputStream(connection.getInputStream())
				}
				catch(err)
				{
				return  false
				}
			
		while ((read = input_stream.read()) != -1) 
		{
		var write = output_file.write(read)
		}
		
		
		//var close_1 = output_file.close()
		//var close_2 = input_file.close()

		 return true
		}
		 return false
		 }
		//------------------------------------------------------------ 
		
		 //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		 function filetofile_y(file_in,file_out)
		 {
		 var url = new java.net.URL(file_in);
		 var output_file = java.io.FileOutputStream(file_out)
		

		//var password = new java.lang.String
		//password +=  "access" + ":" + "cinesharing";
		encoded_pw = "YWNjZXNzOmNpbmVzaGFyaW5n"
		// use http://rumkin.com/tools/compression/base64.php

		var  connection = url.openConnection();
		
		var pw=connection.setRequestProperty("Authorization", "Basic " + encoded_pw);
		
		//connection.setDoOutput(true);
		
		var input_stream = java.io.InputStream(connection.getInputStream())
		
		while ((read = input_stream.read()) != -1) 
		{
		var write = output_file.write(read)
		}
		
		
		
		
		
		
		try 	{
				var input_file = java.io.InputStream(connection.getInputStream())
				}
				catch(err)
				{
				return false
				}
			
		
		
		//var close_1 = output_file.close()
		//var close_2 = input_file.close()

		 return true
		 
		 }
		 
		 //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
		]]></xalan:script>
	</xalan:component>
	<!-- usage 
	<xsl:param name="iis.ext.dir"/>
	<xsl:variable name="filename" select="concat($iis.ext.dir,'/',$filename_from)"/>
	-->
	<xsl:param name="iis.publication.externalIdPrefix"/>
	<xsl:param name="iis.publication.name"/>
	<xsl:param name="iis.publication.id"/>
	<xsl:param name="iis.ext.dir"/>
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
			<!--
			<xsl:value-of select="$iis.publication.externalIdPrefix"/>
			<xsl:value-of select="$iis.publication.name"/>
			<xsl:value-of select="$iis.publication.id"/>
			-->
			<!-- the filename can only be 250 characters long -->
			<!-- for scarab the filename is the url so we need to strip off att the characters up to and including the last slash -->
			<xsl:variable name="scarab_filename">
				<xsl:call-template name="string_after_last_slash">
					<xsl:with-param name="text_string" select="n1:filename"/>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:variable name="fiename_length">
				<xsl:value-of select="string-length($scarab_filename)"/>
			</xsl:variable>
			<xsl:variable name="externalid_length">
				<xsl:value-of select="string-length($iis.publication.externalIdPrefix)"/>
			</xsl:variable>
			<xsl:variable name="filename_from_plus_ext_id_length">
				<xsl:value-of select="$externalid_length+1+$fiename_length"/>
			</xsl:variable>
			<xsl:variable name="filename_from" select="$scarab_filename"/>
			<!-- <xsl:variable name="filename_from_plus_ext_id" select="substring(concat($iis.publication.externalIdPrefix,'_',$filename_from),1,200)"/> -->
			<xsl:variable name="filename_from_plus_ext_id">
				<xsl:choose>
					<xsl:when test="$filename_from_plus_ext_id_length &gt; 200">
						<xsl:variable name="too_long_by">
							<xsl:value-of select="$filename_from_plus_ext_id_length - 200"/>
						</xsl:variable>
						<xsl:variable name="start_from">
							<xsl:value-of select="$too_long_by+$externalid_length+1"/>
						</xsl:variable>
						<xsl:value-of select="concat($iis.publication.externalIdPrefix,'_',substring($filename_from,$start_from))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($iis.publication.externalIdPrefix,'_',$filename_from)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="full_filename_from" select="concat($local_dir_3,$filename_from)"/>
			<xsl:variable name="filename" select="concat($iis.ext.dir,'/',$filename_from_plus_ext_id)"/>
			<xsl:variable name="file" select="file:new($filename)"/>
			<xsl:variable name="http_filename">
				<xsl:value-of select="n1:hlink"/>
			</xsl:variable>
			
			<!-- test   xxx <xsl:value-of select="file:length($file)"></xsl:value-of>zzz  -->
			<xsl:value-of select="of"
			
			<xsl:if test="not(file:exists($file)) or file:length($file)=0 ">
				<!-- <xsl:if test="extfun:filetofile_http($http_filename,translate($filename,' ','_'))"/>  -->
				<!-- test zzz<xsl:value-of select="extfun:filetofile_http($http_filename,translate($filename,' ','_'))"/>xxx  -->
				 <xsl:if test="extfun:filetofile_http($http_filename,translate($filename,' ','_'))"/>
			</xsl:if>
			<xsl:copy-of select="n1:copyright"/>
			<filename>
				<xsl:choose>
					<xsl:when test="substring(n1:hlink,1,4) != 'http'">
						<!--  <xsl:value-of select="$filename_from_plus_ext_id"/>  -->
						<xsl:value-of select="translate($filename_from_plus_ext_id,' ','_')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$scarab_filename"/>
					</xsl:otherwise>
				</xsl:choose>
			</filename>
			<xsl:copy-of select="n1:filetype"/>
			<xsl:variable name="hlink_filename" select="concat('ftp://ftp.045:Kihuesac@ftp.iis.uitdatabank.be/mediafolder','/',translate($filename_from_plus_ext_id,' ','_'))"/>
			<hlink>
				<xsl:choose>
					<xsl:when test="substring(n1:hlink,1,4) != 'http'">
						<xsl:value-of select="$hlink_filename"/>
					</xsl:when>
					<xsl:otherwise>
						<!--  <xsl:value-of select="n1:hlink"/>  -->
						<xsl:value-of select="$hlink_filename"/>
					</xsl:otherwise>
				</xsl:choose>
				<!-- test
				xxx<xsl:value-of select="$iis.ext.dir"></xsl:value-of>xxx
				yyy<xsl:value-of select="$full_filename_from"></xsl:value-of>yyy
				zzz<xsl:value-of select="$filename"></xsl:value-of>zzz -->
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
