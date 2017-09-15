<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:UML = 'org.omg.xmi.namespace.UML'
>
	
	<xsl:template match="/XMI">
		<Ontology xmlns="http://www.w3.org/2002/07/owl#"
		     xml:base="{@iri}"
		     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		     xmlns:xml="http://www.w3.org/XML/1998/namespace"
		     xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
		     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		     ontologyIRI="{@iri}">
		    <Prefix name="owl" IRI="http://www.w3.org/2002/07/owl#"/>
		    <Prefix name="rdf" IRI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
		    <Prefix name="xml" IRI="http://www.w3.org/XML/1998/namespace"/>
		    <Prefix name="xsd" IRI="http://www.w3.org/2001/XMLSchema#"/>
		    <Prefix name="rdfs" IRI="http://www.w3.org/2000/01/rdf-schema#"/>
		    
		    <!-- Search for classes in the UML Model -->
		    <xsl:apply-templates select="XMI.content/UML:Model/UML:Namespace.ownedElement/UML:Class"/>
		    <xsl:apply-templates select="XMI.content/UML:Model/UML:Namespace.ownedElement/UML:Association"/>
		</Ontology>
	</xsl:template>

	<!-- Class and ObjectProperty -->
	<xsl:template match="UML:Class">
		<xsl:variable name="xmi.id" select="substring-after( UML:ModelElement.stereotype/UML:Stereotype/@href, '#')"/>
		
		<xsl:choose>
			<xsl:when test="$xmi.id = '127-0-1-1--7cb14c61:15e7a3e4e85:-8000:0000000000000A61'">
				<Declaration>
					<Class IRI="#{@name}"/>
				</Declaration>
			</xsl:when>
			<xsl:when test="$xmi.id = '127-0-1-1--7cb14c61:15e7a3e4e85:-8000:0000000000000A63'">
				<Declaration>
 					<ObjectProperty IRI="#{@name}"/>
				</Declaration>
			</xsl:when>
		</xsl:choose>
		
	    <!-- Search for attributes in the UML Model -->
	    <xsl:apply-templates select="UML:Classifier.feature/UML:Attribute"/>
	</xsl:template>

	<!-- DataProperty -->
	<xsl:template match="UML:Attribute">
		<xsl:variable name="xmi.id" select="substring-after( UML:ModelElement.stereotype/UML:Stereotype/@href, '#')"/>
		<xsl:choose>
			<xsl:when test="$xmi.id = '127-0-1-1--7cb14c61:15e7a3e4e85:-8000:0000000000000A62'">
				<Declaration>
 					<DataProperty IRI="#{@name}"/>
				</Declaration>		
 			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- ObjectPropertyDomain -->
	<xsl:template match="UML:Association">
		<xsl:variable name="xmi.id" select="substring-after( UML:ModelElement.stereotype/UML:Stereotype/@href, '#')"/>
		<xsl:choose>
			<xsl:when test="$xmi.id = '127-0-1-1--7cb14c61:15e7a3e4e85:-8000:0000000000000A65'">
				<xsl:variable name="idref" select="UML:Association.connection/UML:AssociationEnd/UML:AssociationEnd.participant/UML:Class/@xmi.idref" />
			    <ObjectPropertyDomain>
					<ObjectProperty IRI="#{$idref}"/>
	        		<Class IRI=""/>
				</ObjectPropertyDomain>	
				</xsl:when>
		</xsl:choose>	    
	</xsl:template>

</xsl:stylesheet>