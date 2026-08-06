<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            queryBinding="xslt2">
   <sch:ns prefix="bn-beh"
           uri="http://xoev.de/schemata/basisnachricht/behoerde/1_0"/>
   <sch:ns prefix="bn-g2g" uri="http://xoev.de/schemata/basisnachricht/g2g/1_1"/>
   <sch:ns prefix="bn-kom"
           uri="http://xoev.de/schemata/basisnachricht/kommunikation/1_0"/>
   <sch:ns prefix="bn-uq-g2g"
           uri="http://xoev.de/schemata/basisnachricht/unqualified/g2g/1_1"/>
   <sch:ns prefix="din91379"
           uri="urn:xoev-de:kosit:xoev:datentyp:din-91379_2022-08"/>
   <sch:ns prefix="dinspec91379"
           uri="urn:xoev-de:kosit:xoev:datentyp:din-spec-91379_2019-03"/>
   <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
   <sch:ns prefix="xbauk" uri="http://www.xleitstelle.de/xbau/kernmodul/1/4/0"/>
   <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
   <sch:ns prefix="xoev-code" uri="http://xoev.de/schemata/code/1_0"/>
   <sch:ns prefix="xoev-lc" uri="http://xoev.de/latinchars/1_1/datatypes"/>
   <sch:pattern>
      <!--Abstrakte Regeln-->
      <!-- /Data/XBau-Kernmodul/Datentypen/Datentypen zu Prozessnachrichten/ruleset.anlagen (schRuleSet) -->
      <sch:rule id="rule-sch-xbauk-001" abstract="true">
         <sch:assert id="sch-xbauk-001"
                     test="count(//anhangOderVerlinkung/*/dateiname) = count(distinct-values(//anhangOderVerlinkung/*/dateiname)) ">Dateinamen der Anlagen zu einer Nachricht müssen eindeutig sein.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-xbauk-002" abstract="true">
         <sch:assert id="sch-xbauk-002"
                     test="count(//anhangOderVerlinkung/*/dokumentid) = count(distinct-values(//anhangOderVerlinkung/*/dokumentid)) ">Dokument-IDs der Anlagen zu einer Nachricht müssen eindeutig sein.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-xbauk-003" abstract="true">
         <sch:assert id="sch-xbauk-003"
                     test="count(//anhangOderVerlinkung/verlinkung/uriVerlinkung) = count(distinct-values(//anhangOderVerlinkung/verlinkung/uriVerlinkung)) ">URIs verlinkter Anlagen zu einer Nachricht müssen eindeutig sein.</sch:assert>
      </sch:rule>
      <!--Konkrete Regeln-->
      <sch:rule context="xbauk:prozessnachrichten.aktenzeichen.1121">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.eingangsbestaetigung.1120">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.einstellenDokumente.1150">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.fachlicheKommunikation.1142">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.formellePruefungBefundliste.1140">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.gebuehrenbescheid.1160">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.generischeQuittierungEingang.1180">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.generischeRueckmeldungAbruf.1181">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.quittierungRuecknahme.1131">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.ruecknahme.1130">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.rueckweisung.G2G.1100">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.statusFuerAntragsportal.1170">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:prozessnachrichten.zustellungSchreiben.1141">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:universellerAntrag.angepassterAntrag.1202">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:universellerAntrag.antrag.1200">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:universellerAntrag.bescheid.1205">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:universellerAntrag.materiellePruefungBefundliste.1203">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
      <sch:rule context="xbauk:universellerAntrag.stellungnahme.1204">
         <sch:extends rule="rule-sch-xbauk-001"/>
         <sch:extends rule="rule-sch-xbauk-002"/>
         <sch:extends rule="rule-sch-xbauk-003"/>
      </sch:rule>
   </sch:pattern>
</sch:schema>
