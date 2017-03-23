@echo off

AltovaXSLT -xsl C:\XML\XSLT\CDB_3_1_to_3_2\MapToCdbXSD.xslt -xml <PleaseSetInputInstance.xml> -out C:\XML\XSD\CDB_XSD_3_2\CdbXSD.xml  %*
IF ERRORLEVEL 1 EXIT/B %ERRORLEVEL%
