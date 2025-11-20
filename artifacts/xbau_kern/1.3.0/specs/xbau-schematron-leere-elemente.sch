<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            queryBinding="xslt2">
   <sch:pattern>
      <!--Abstrakte Regeln-->
      <sch:rule id="rule-sch-xbau-gen-001" abstract="true">
         <sch:assert id="sch-xbau-gen-001" test="not(not(*) and normalize-space(.) = '')">Es dürfen keine Elemente übermittelt werden, die leer sind oder nur Whitespace enthalten.</sch:assert>
      </sch:rule>
      
      <!--Konkrete Regeln-->
      <sch:rule context="//*">
         <sch:extends rule="rule-sch-xbau-gen-001"/>
      </sch:rule>
   </sch:pattern>
</sch:schema>
