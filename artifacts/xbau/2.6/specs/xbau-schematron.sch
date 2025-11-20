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
      <!-- /Data/XBau/Nachrichten/Statistik/Datentypen/HeizungHeizenergie -->
      <sch:rule id="rule-sch-stat-003" abstract="true">
         <sch:assert id="sch-stat-003"
                     test="not((xbau:primaereHeizenergieHeizung/xbau:code/code = '001' and xbau:sekundaereHeizenergieHeizung/xbau:code/code = '014') or (xbau:primaereHeizenergieHeizung/xbau:code/code = '014' and xbau:sekundaereHeizenergieHeizung/xbau:code/code = '001'))">Die angegebene Kombination von primärer und sekundärer Wärmeenergie ist nicht plausibel.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Baukasten/Nachrichtenkopf/Nachrichtenkopf.G2G -->
      <sch:rule id="rule-sch-xbau-001" abstract="true">
         <sch:assert id="sch-xbau-001"
                     test="if (leser/verzeichnisdienst/code = 'DVDV') then (matches(leser/kennung,'^[a-z]{3}:\d+$')) else true()">Eine Behördenkennung im DVDV muss aus einem Präfix aus drei Kleinbuchstaben, einem Doppelpunkt und einer Folge von Ziffern bestehen. Die Behördenkennung des Elements "leser" verstößt gegen diese Festlegung.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-xbau-002" abstract="true">
         <sch:assert id="sch-xbau-002"
                     test="if (autor/verzeichnisdienst/code = 'DVDV') then (matches(autor/kennung,'^[a-z]{3}:\d+$')) else true()">Eine Behördenkennung im DVDV muss aus einem Präfix aus drei Kleinbuchstaben, einem Doppelpunkt und einer Folge von Ziffern bestehen. Die Behördenkennung des Elements "autor" verstößt gegen diese Festlegung.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Anzeige/anzeige.beseitigungAbsicht.0950 -->
      <sch:rule id="rule-sch-anz-001" abstract="true">
         <sch:assert id="sch-anz-001" test="exists(xbau:anzeigender)">Zur Weiterleitung an die Statistik ist ein Anzeigender anzugeben. Die Nachricht enthält kein Element "anzeigender".</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.01 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-006" abstract="true">
         <sch:assert id="sch-stat-006"
                     test="if (exists(xbau:anzahlVollgeschosse) and xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and  xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and xbau:anzahlDerWohnungen/xbau:gesamtanzahlWohnungen = 1) then (xbau:anzahlVollgeschosse &lt;= 3) else true()">Die angegebene Anzahl Vollgeschosse überschreitet den Maximalwert drei, der für Wohngebäude mit nur einer Wohnung zulässig ist.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-007" abstract="true">
         <sch:assert id="sch-stat-007"
                     test="if (exists(xbau:baukosten[xbau:kostengruppe300 or xbau:kostengruppe400]) and xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and (xbau:bruttoRauminhaltBRI &gt; 0)) then (((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &gt;= 150) and ((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &lt;= 400)) else true()">Die veranschlagten Baukosten je Kubikmeter liegen außerhalb des Rahmens von 150 bis 400 € bei einem neu errichteten Wohngebäude.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-008" abstract="true">
         <sch:assert id="sch-stat-008"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then (not(exists(xbau:angabenGebaeude/xbau:haustypWohngebaeude))) else true()">Die Angabe des Haustyps des Wohngebäudes ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-009" abstract="true">
         <sch:assert id="sch-stat-009"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:ueberwiegendVerwendeterBaustoff))) else true()">Die Angabe des überwiegend verwendeten Baustoffs ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-010" abstract="true">
         <sch:assert id="sch-stat-010"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:heizungHeizenergie))) else true()">Angaben zur Heizung und zur Heizenergie sind nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-011" abstract="true">
         <sch:assert id="sch-stat-011"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:bruttoRauminhaltBRI))) else true()">Die Angabe des Bruttorauminhalts ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-012" abstract="true">
         <sch:assert id="sch-stat-012"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:anzahlVollgeschosse))) else true()">Die Angabe der Anzahl der Vollgeschosse ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-013" abstract="true">
         <sch:assert id="sch-stat-013"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:sonstigeLueftungsanlagen))) else true()">Die Angabe zu Lüftungsanlagen ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-014" abstract="true">
         <sch:assert id="sch-stat-014"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then (not(exists(xbau:kuehlung))) else true()">Die Angabe zur Kühlung ist nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-015" abstract="true">
         <sch:assert id="sch-stat-015"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then ( not(exists(xbau:erfuellungGEG))) else true()">Angaben zur Erfüllung des Gebäudeenergiegesetzes sind nur für Neubauten zulässig.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.03 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-001" abstract="true">
         <sch:assert id="sch-stat-001" test="exists(//xbau:flurstueck/bundesland)">Die Angabe des Bundeslandes fehlt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002" abstract="true">
         <sch:assert id="sch-stat-002"
                     test="not(normalize-space(//xbau:bauherr//familienname/name) = '' and normalize-space(//xbau:bauherr/organisation/name) = '')">Der Bauherr muss angegeben werden.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.04 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-004" abstract="true">
         <sch:assert id="sch-stat-004"
                     test="if (exists(xbau:kategorie)) then ((xbau:kategorie/code='7' and exists(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)) or (xbau:kategorie/code != '7' and not(exists(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)))) else true()">Wenn die Wohnungskategorie "7 oder mehr als 7 Räume" gewählt wird, muss die Anzahl der Räume angegeben werden und umgekehrt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-005" abstract="true">
         <sch:assert id="sch-stat-005"
                     test="not(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen &lt; 7*xbau:anzahlWohnungen)">Bei Wohnungen mit sieben oder mehr Räumen muss die Gesamtzahl der Räume mindestens das Siebenfache der Wohnungsanzahl betragen. Die angegebene Raumanzahl ist zu gering.</sch:assert>
      </sch:rule>
      <!--Konkrete Regeln-->
      <sch:rule context="xbau:anzeige.beseitigungAbsicht.0950">
         <sch:extends rule="rule-sch-anz-001"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauabgang.0426//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.erloscheneBaugenehmigung.0422//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-004"/>
         <sch:extends rule="rule-sch-stat-005"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-006"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
         <sch:extends rule="rule-sch-stat-010"/>
         <sch:extends rule="rule-sch-stat-011"/>
         <sch:extends rule="rule-sch-stat-012"/>
         <sch:extends rule="rule-sch-stat-013"/>
         <sch:extends rule="rule-sch-stat-014"/>
         <sch:extends rule="rule-sch-stat-015"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.anhoerung.0253//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.antrag.0250//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.antragGeaendert.0252//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.bescheid.0255//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.formellePruefung.0251//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abgeschlossenheit.stellungnahme.0254//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.anhoerung.0223//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.antrag.0220//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.antragGeaendert.0222//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.bescheid.0225//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.formellePruefung.0221//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:abweichung.stellungnahme.0224//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.anforderungGrundbuchauszug.0125//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.antrag.0120//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.antragGeaendert.0122//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.ergebnis.0123//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.formellePruefung.0121//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:akteneinsicht.uebermittlungGrundbuchauszug.0126//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:angrenzer.stellungnahme.0310//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.baubeginn.0900//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.baubeginnAeusserung.0904//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.baubeginnBaufreigabe.0902//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.baubeginnUntersagung.0901//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.beseitigungAbsicht.0950//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.beseitigungBestaetigung.0955//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.beseitigungGeaendert.0952//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.beseitigungUntersagung.0953//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.erklaerungGEG.0903//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.nutzungsaufnahme.0910//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.nutzungsaufnahmeAeusserung.0913//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.nutzungsaufnahmeBauabnahme.0912//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:anzeige.nutzungsaufnahmeUntersagung.0911//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauberatung.anfrage.0110//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauberatung.auskunft.0111//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.anhoerung.0203//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.antrag.0200//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.antragGeaendert.0202//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.bescheid.0205//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.formellePruefung.0201//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baugenehmigung.stellungnahme.0204//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulasten.eintragung.0703//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulasten.information.0702//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulasten.korrekturErklaerung.0704//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulasten.nachforderung.0701//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulasten.vorlageErklaerung.0700//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastenverzeichnis.anfrage.0710//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastenverzeichnis.anfrageGeaendert.0712//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastenverzeichnis.auskunft.0713//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastenverzeichnis.formellePruefung.0711//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.antrag.0720//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.information.0726//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.korrekturAntrag.0722//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.loeschungEintrag.0725//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.nachforderung.0721//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.stellungnahme.0724//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:baulastloeschung.stellungnahmeAufforderung.0723//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauzustand.aeusserung.0923//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauzustand.anzeige.0920//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauzustand.befundliste.0921//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:bauzustand.freigabe.0922//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.aufforderung.0300//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.aufforderungKorrektur.0302//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.formellePruefung.0301//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.reaktionZwischennachricht.0306//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.ruecknahme.0304//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.stellungnahme.0303//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:beteiligung.zwischennachricht.0305//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:genehmigungsfreistellung.anzeige.0600//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:genehmigungsfreistellung.anzeigeBAB.0601//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:genehmigungsfreistellung.ergebnis.0602//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:genehmigungsfreistellung.ergebnisBAB.0603//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.anhoerung.0243//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.antrag.0240//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.antragGeaendert.0242//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.bescheid.0245//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.formellePruefung.0241//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:grundstuecksteilung.stellungnahme.0244//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:informationsempfaenger.benachrichtigung.0400//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:informationsempfaenger.benachrichtigungUV.0401//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:kammernverzeichnis.anfrage.0930//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:kammernverzeichnis.auskunft.0931//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:prozessnachrichten.aenderungProjektraumdaten.0100//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:prozessnachrichten.aktenraum.angelegt.0151//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:prozessnachrichten.aktenraum.anlegen.0150//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:prozessnachrichten.aktenraum.zugriffVerweigern.0152//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.angepassteUnterlagen.0505//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.auftragsbestaetigung.0501//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.formellePruefung.0502//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.mitteilungBaubeginnsanzeige.0508//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.nachforderungUnterlagen.0504//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.pruefauftrag.0500//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.pruefauftragKorrektur.0503//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:pruefingenieure.pruefbericht.0506//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauabgang.0426//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.erloscheneBaugenehmigung.0422//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.anhoerung.0233//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.antrag.0230//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.antragGeaendert.0232//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.bescheid.0235//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.formellePruefung.0231//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:teilbaugenehmigung.stellungnahme.0234//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:ueberwachungspflichtigeAnlagen.erinnerung.0801//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:ueberwachungspflichtigeAnlagen.pruefbescheinigung.0800//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.anhoerung.0263//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.antrag.0260//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.antragGeaendert.0262//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.bescheid.0265//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.formellePruefung.0261//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:verlaengerung.stellungnahme.0264//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.anhoerung.0213//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.antrag.0210//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.antragGeaendert.0212//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.bescheid.0215//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.formellePruefung.0211//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
      <sch:rule context="xbau:vorbescheid.stellungnahme.0214//nachrichtenkopf.g2g">
         <sch:extends rule="rule-sch-xbau-001"/>
         <sch:extends rule="rule-sch-xbau-002"/>
      </sch:rule>
   </sch:pattern>
</sch:schema>
