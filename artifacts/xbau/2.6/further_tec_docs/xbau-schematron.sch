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
   <sch:ns prefix="xbau" uri="http://www.xleitstelle.de/xbau/2/6"/>
   <sch:ns prefix="xbauk" uri="http://www.xleitstelle.de/xbau/kernmodul/1/3/0"/>
   <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
   <sch:ns prefix="xoev-code" uri="http://xoev.de/schemata/code/1_0"/>
   <sch:ns prefix="xoev-lc" uri="http://xoev.de/latinchars/1_1/datatypes"/>
   <sch:pattern>
      <!--Abstrakte Regeln-->
      <!-- /Data/XBau/Nachrichten/Statistik/Datentypen/DatenEinzelnesGebaeude -->
      <sch:rule id="rule-sch-stat-001" abstract="true">
         <sch:assert id="sch-stat-001"
                     test="exists(xbau:baugenehmigung/xbau:genehmigungsfreistellung)">Die Angabe zur Baugenehmigung bzw. Genehmigungsfreistellung fehlt.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/Datentypen/HeizungHeizenergie -->
      <sch:rule id="rule-sch-stat-008" abstract="true">
         <sch:assert id="sch-stat-008"
                     test="not((xbau:primaereHeizenergieHeizung/xbau:code/code = '001' and xbau:sekundaereHeizenergieHeizung/xbau:code/code = '014') or (xbau:primaereHeizenergieHeizung/xbau:code/code = '014' and xbau:sekundaereHeizenergieHeizung/xbau:code/code = '001'))">Die angegebene Kombination von primärer und sekundärer Wärmeenergie ist nicht plausibel.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.01 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-011" abstract="true">
         <sch:assert id="sch-stat-011"
                     test="if (exists(xbau:anzahlVollgeschosse) and xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and  xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and xbau:anzahlDerWohnungen/xbau:gesamtanzahlWohnungen = 1) then (xbau:anzahlVollgeschosse &lt;= 3) else true()">Die angegebene Anzahl Vollgeschosse überschreitet den Maximalwert drei, der für Wohngebäude mit nur einer Wohnung zulässig ist.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-012" abstract="true">
         <sch:assert id="sch-stat-012"
                     test="if (exists(xbau:baukosten[xbau:kostengruppe300 or xbau:kostengruppe400]) and xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and (xbau:bruttoRauminhaltBRI &gt; 0)) then (((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &gt;= 150) and ((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &lt;= 400)) else true()">Die veranschlagten Baukosten je Kubikmeter liegen außerhalb des Rahmens von 150 bis 400 € bei einem neu errichteten Wohngebäude.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-013" abstract="true">
         <sch:assert id="sch-stat-013"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then (not(exists(xbau:angabenGebaeude/xbau:haustypWohngebaeude))) else true()">Die Angabe des Haustyps des Wohngebäudes ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-014" abstract="true">
         <sch:assert id="sch-stat-014"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:ueberwiegendVerwendeterBaustoff))) else true()">Die Angabe des überwiegend verwendeten Baustoffs ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-015" abstract="true">
         <sch:assert id="sch-stat-015"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:heizungHeizenergie))) else true()">Angaben zur Heizung und zur Heizenergie sind nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-016" abstract="true">
         <sch:assert id="sch-stat-016"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:bruttoRauminhaltBRI))) else true()">Die Angabe des Bruttorauminhalts ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-017" abstract="true">
         <sch:assert id="sch-stat-017"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:anzahlVollgeschosse))) else true()">Die Angabe der Anzahl der Vollgeschosse ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-018" abstract="true">
         <sch:assert id="sch-stat-018"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:sonstigeLueftungsanlagen))) else true()">Die Angabe zu Lüftungsanlagen ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-019" abstract="true">
         <sch:assert id="sch-stat-019"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then (not(exists(xbau:kuehlung))) else true()">Die Angabe zur Kühlung ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-020" abstract="true">
         <sch:assert id="sch-stat-020"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:erfuellungGEG))) else true()">Angaben zur Erfüllung des Gebäudeenergiegesetzes sind nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.02 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-003" abstract="true">
         <sch:assert id="sch-stat-003"
                     test="if (//xbau:genehmigungsfreistellung/code = '3') then (//xbau:flurstueck/bundesland)[1]/code = ('03','08','11','12','13','14','15') else true()">Die angegebene Genehmigungsfreistellung ist nur in Niedersachsen, Baden-Württemberg, Berlin, Brandenburg, Mecklenburg-Vorpommern, Sachsen und Sachsen-Anhalt zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-004" abstract="true">
         <sch:assert id="sch-stat-004"
                     test="if (//xbau:genehmigungsfreistellung/code = '4') then (//xbau:flurstueck/bundesland)[1]/code = ('03','08','14','15') else true()">Die angegebene Genehmigungsfreistellung ist nur in Niedersachsen, Baden-Württemberg, Sachsen und Sachsen-Anhalt zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-005" abstract="true">
         <sch:assert id="sch-stat-005"
                     test="if (//xbau:genehmigungsfreistellung/code = ('5','6','7','8')) then (//xbau:flurstueck/bundesland)[1]/code = ('03','08') else true()">Die angegebene Genehmigungsfreistellung ist nur in Niedersachsen und Baden-Württemberg zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-006" abstract="true">
         <sch:assert id="sch-stat-006"
                     test="if (//xbau:genehmigungsfreistellung/code = '9') then (//xbau:flurstueck/bundesland)[1]/code = '9' else true()">Die angegebene Genehmigungsfreistellung ist nur in Bayern zulässig.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.03 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-002" abstract="true">
         <sch:assert id="sch-stat-002" test="exists(//xbau:flurstueck/bundesland)">Die Angabe des Bundeslandes fehlt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-007" abstract="true">
         <sch:assert id="sch-stat-007"
                     test="not(normalize-space(//xbau:bauherr//familienname/name) = '' and normalize-space(//xbau:bauherr/organisation/name) = '')">Der Bauherr muss angegeben werden.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.04 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-009" abstract="true">
         <sch:assert id="sch-stat-009"
                     test="if (exists(xbau:kategorie)) then ((xbau:kategorie/code='7' and exists(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)) or (xbau:kategorie/code != '7' and not(exists(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)))) else true()">Wenn die Wohnungskategorie "7 oder mehr als 7 Räume" gewählt wird, muss die Anzahl der Räume angegeben werden und umgekehrt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-010" abstract="true">
         <sch:assert id="sch-stat-010"
                     test="not(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen &lt; 7*xbau:anzahlWohnungen)">Bei Wohnungen mit sieben oder mehr Räumen muss die Gesamtzahl der Räume mindestens das Siebenfache der Wohnungsanzahl betragen. Die angegebene Raumanzahl ist zu gering.</sch:assert>
      </sch:rule>
      <!--Konkrete Regeln-->
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauabgang.0426//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.erloscheneBaugenehmigung.0422//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-002"/>
         <sch:extends rule="rule-sch-stat-007"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425">
         <sch:extends rule="rule-sch-stat-003"/>
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421">
         <sch:extends rule="rule-sch-stat-003"/>
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427">
         <sch:extends rule="rule-sch-stat-003"/>
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423">
         <sch:extends rule="rule-sch-stat-003"/>
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-008"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
         <sch:extends rule="rule-sch-stat-016"/>
         <sch:extends rule="rule-sch-stat-017"/>
         <sch:extends rule="rule-sch-stat-018"/>
         <sch:extends rule="rule-sch-stat-019"/>
         <sch:extends rule="rule-sch-stat-020"/>
      </sch:rule>
   </sch:pattern>
</sch:schema>
