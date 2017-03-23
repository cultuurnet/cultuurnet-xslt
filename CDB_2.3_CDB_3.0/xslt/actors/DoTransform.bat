@echo off

AltovaXSLT -xsl T:\XSLT\CDB_2.3_CDB_3.0\xslt\actors\MapToCdbXSD_3_1.xslt -xml <PleaseSetInputInstance.xml> -out T:\XSD\CDB_3_1\CdbXSD_3_1.xml  %*
IF ERRORLEVEL 1 EXIT/B %ERRORLEVEL%
