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
      <sch:rule id="rule-sch-stat-004" abstract="true">
         <sch:assert id="sch-stat-004"
                     test="not((xbau:heizenergie/xbau:primaereHeizenergieHeizung/xbau:code/code='001' and xbau:heizenergie/xbau:sekundaereHeizenergieHeizung/xbau:code/code='014') or (xbau:heizenergie/xbau:primaereHeizenergieHeizung/xbau:code/code='014' and xbau:heizenergie/xbau:sekundaereHeizenergieHeizung/xbau:code/code='001'))">Die angegebene Kombination von primärer und sekundärer Wärmeenergie ist nicht plausibel.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.01 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-002-BB" abstract="true">
         <sch:assert id="sch-stat-002-BB"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '12')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Brandenburg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-BE" abstract="true">
         <sch:assert id="sch-stat-002-BE"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '11')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Berlin) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-BW" abstract="true">
         <sch:assert id="sch-stat-002-BW"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '08')) then (//xbau:genehmigungsfreistellung/code != '9') else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Baden-Württemberg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-BY" abstract="true">
         <sch:assert id="sch-stat-002-BY"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '09')) then (//xbau:genehmigungsfreistellung/code = ('1','2','9')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Bayern) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-HB" abstract="true">
         <sch:assert id="sch-stat-002-HB"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '04')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Bremen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-HE" abstract="true">
         <sch:assert id="sch-stat-002-HE"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '06')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Hessen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-HH" abstract="true">
         <sch:assert id="sch-stat-002-HH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '02')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Hamburg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-MV" abstract="true">
         <sch:assert id="sch-stat-002-MV"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '13')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Mecklenburg-Vorpommern) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-NI" abstract="true">
         <sch:assert id="sch-stat-002-NI"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '03')) then (//xbau:genehmigungsfreistellung/code != '9') else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Niedersachsen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-NW" abstract="true">
         <sch:assert id="sch-stat-002-NW"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '05')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Nordrhein-Westfalen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-RP" abstract="true">
         <sch:assert id="sch-stat-002-RP"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '07')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Rheinland-Pfalz) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-SH" abstract="true">
         <sch:assert id="sch-stat-002-SH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '01')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Schleswig-Holstein) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-SL" abstract="true">
         <sch:assert id="sch-stat-002-SL"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '10')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Saarland) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-SN" abstract="true">
         <sch:assert id="sch-stat-002-SN"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '14')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3','4')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Sachsen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-ST" abstract="true">
         <sch:assert id="sch-stat-002-ST"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '15')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3','4')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Sachsen-Anhalt) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-TH" abstract="true">
         <sch:assert id="sch-stat-002-TH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (../..//xbau:flurstueck/bundesland/code = '16')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Thüringen) nicht zulässig.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.02 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-005" abstract="true">
         <sch:assert id="sch-stat-005"
                     test="not(xbau:kategorie/code='7' and empty(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)) and not(xbau:kategorie/code != '7' and not(empty(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen)))">Wenn die Wohnungskategorie "7 oder mehr als 7 Räume" gewählt wird, muss die Anzahl der Räume angegeben werden und umgekehrt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-006" abstract="true">
         <sch:assert id="sch-stat-006"
                     test="not(xbau:anzahlRaeumebeiWohnungenMitSiebenOderMehrRaeumen &lt; 7*xbau:anzahlWohnungen)">Bei Wohnungen mit sieben oder mehr Räumen muss die Gesamtzahl der Räume mindestens das Siebenfache der Wohnungsanzahl betragen. Die angegebene Raumanzahl ist zu gering.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.03 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-001" abstract="true">
         <sch:assert id="sch-stat-001"
                     test="exists(xbau:baugenehmigung/xbau:genehmigungsfreistellung)">Die Angabe zum baurechtlichen Verfahren fehlt.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-007" abstract="true">
         <sch:assert id="sch-stat-007"
                     test="if (xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and  xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and xbau:anzahlDerWohnungen/xbau:gesamtanzahlWohnungen = 1) then (xbau:anzahlVollgeschosse &lt;= 3) else true()">Die angegebene Anzahl Vollgeschosse überschreitet den Maximalwert drei, der für Wohngebäude mit nur einer Wohnung zulässig ist.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-008" abstract="true">
         <sch:assert id="sch-stat-008"
                     test="if (xbau:angabenGebaeude/xbau:artDesWohngebaeudes/code = ('1','2') and xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = ('1','2') and (xbau:bruttoRauminhaltBRI &gt; 0)) then (((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &gt;= 150) and ((xbau:baukosten/xbau:kostengruppe300+xbau:baukosten/xbau:kostengruppe400) div (100*xbau:bruttoRauminhaltBRI) &lt;= 400)) else true()">Die veranschlagten Baukosten je Kubikmeter liegen außerhalb des Rahmens von 150 bis 400 € bei einem neu errichteten Wohngebäude.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-009" abstract="true">
         <sch:assert id="sch-stat-009"
                     test="if (xbau:baugenehmigung/xbau:artDerBautaetigkeit/code = '3') then (not(exists(xbau:angabenGebaeude/xbau:haustypWohngebaeude)) and not(exists(xbau:ueberwiegendVerwendeterBaustoff)) and not(exists(xbau:heizungHeizenergie)) and not(exists(xbau:bruttoRauminhaltBRI)) and not(exists(xbau:anzahlVollgeschosse)) and not(exists(xbau:sonstigeLueftungsanlagen)) and not(exists(xbau:kuehlung)) and not(exists(xbau:erfuellungGEG))) else true()">Es wurden Angaben gemacht, die nur für Neubauten zulässig sind (dies sind: Art der Bautätigkeit, Haustyp Wohngebäude, überwiegend verwendeter Baustoff, Heizung/Heizenergie, Bruttorauminhalt, Anzahl Vollgeschosse, Lüftungsanlagen, Kühlung und Erfüllung GEG).</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.04 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-003" abstract="true">
         <sch:assert id="sch-stat-003" test="exists(//xbau:beteiligteBauprojekt)">Der Bauherr muss angegeben werden.</sch:assert>
      </sch:rule>
      <!-- /Data/XBau/Nachrichten/Statistik/ruleset.statistik.05 (schRuleSet) -->
      <sch:rule id="rule-sch-stat-002-01-BB" abstract="true">
         <sch:assert id="sch-stat-002-01-BB"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '12')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Brandenburg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-BE" abstract="true">
         <sch:assert id="sch-stat-002-01-BE"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '11')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Berlin) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-BW" abstract="true">
         <sch:assert id="sch-stat-002-01-BW"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '08')) then (//xbau:genehmigungsfreistellung/code != '9') else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Baden-Württemberg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-BY" abstract="true">
         <sch:assert id="sch-stat-002-01-BY"
                     test="iif (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '09')) then (//xbau:genehmigungsfreistellung/code = ('1','2','9')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Bayern) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-HB" abstract="true">
         <sch:assert id="sch-stat-002-01-HB"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '04')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Bremen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-HE" abstract="true">
         <sch:assert id="sch-stat-002-01-HE"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '06')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Hessen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-HH" abstract="true">
         <sch:assert id="sch-stat-002-01-HH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '02')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Hamburg) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-MV" abstract="true">
         <sch:assert id="sch-stat-002-01-MV"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '13')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Mecklenburg-Vorpommern) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-NI" abstract="true">
         <sch:assert id="sch-stat-002-01-NI"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '03')) then (//xbau:genehmigungsfreistellung/code != '9') else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Niedersachsen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-NW" abstract="true">
         <sch:assert id="sch-stat-002-01-NW"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '05')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Nordrhein-Westfalen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-RP" abstract="true">
         <sch:assert id="sch-stat-002-01-RP"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '07')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Rheinland-Pfalz) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-SH" abstract="true">
         <sch:assert id="sch-stat-002-01-SH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '01')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Schleswig-Holstein) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-SL" abstract="true">
         <sch:assert id="sch-stat-002-01-SL"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '10')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Saarland) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-SN" abstract="true">
         <sch:assert id="sch-stat-002-01-SN"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '14')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3','4')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Sachsen) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-ST" abstract="true">
         <sch:assert id="sch-stat-002-01-ST"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '15')) then (//xbau:genehmigungsfreistellung/code = ('1','2','3','4')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Sachsen-Anhalt) nicht zulässig.</sch:assert>
      </sch:rule>
      <sch:rule id="rule-sch-stat-002-01-TH" abstract="true">
         <sch:assert id="sch-stat-002-01-TH"
                     test="if (exists(//xbau:baugenehmigung/xbau:genehmigungsfreistellung) and (//xbau:flurstueck/bundesland/code = '16')) then (//xbau:genehmigungsfreistellung/code = ('1','2')) else true()">Die angegebene Genehmigungsfreistellung ist im Bundesland des Bauvorhabens (Thüringen) nicht zulässig.</sch:assert>
      </sch:rule>
      <!--Konkrete Regeln-->
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-01-BB"/>
         <sch:extends rule="rule-sch-stat-002-01-BE"/>
         <sch:extends rule="rule-sch-stat-002-01-BW"/>
         <sch:extends rule="rule-sch-stat-002-01-BY"/>
         <sch:extends rule="rule-sch-stat-002-01-HB"/>
         <sch:extends rule="rule-sch-stat-002-01-HE"/>
         <sch:extends rule="rule-sch-stat-002-01-HH"/>
         <sch:extends rule="rule-sch-stat-002-01-MV"/>
         <sch:extends rule="rule-sch-stat-002-01-NI"/>
         <sch:extends rule="rule-sch-stat-002-01-NW"/>
         <sch:extends rule="rule-sch-stat-002-01-RP"/>
         <sch:extends rule="rule-sch-stat-002-01-SH"/>
         <sch:extends rule="rule-sch-stat-002-01-SL"/>
         <sch:extends rule="rule-sch-stat-002-01-SN"/>
         <sch:extends rule="rule-sch-stat-002-01-ST"/>
         <sch:extends rule="rule-sch-stat-002-01-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-01-BB"/>
         <sch:extends rule="rule-sch-stat-002-01-BE"/>
         <sch:extends rule="rule-sch-stat-002-01-BW"/>
         <sch:extends rule="rule-sch-stat-002-01-BY"/>
         <sch:extends rule="rule-sch-stat-002-01-HB"/>
         <sch:extends rule="rule-sch-stat-002-01-HE"/>
         <sch:extends rule="rule-sch-stat-002-01-HH"/>
         <sch:extends rule="rule-sch-stat-002-01-MV"/>
         <sch:extends rule="rule-sch-stat-002-01-NI"/>
         <sch:extends rule="rule-sch-stat-002-01-NW"/>
         <sch:extends rule="rule-sch-stat-002-01-RP"/>
         <sch:extends rule="rule-sch-stat-002-01-SH"/>
         <sch:extends rule="rule-sch-stat-002-01-SL"/>
         <sch:extends rule="rule-sch-stat-002-01-SN"/>
         <sch:extends rule="rule-sch-stat-002-01-ST"/>
         <sch:extends rule="rule-sch-stat-002-01-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-01-BB"/>
         <sch:extends rule="rule-sch-stat-002-01-BE"/>
         <sch:extends rule="rule-sch-stat-002-01-BW"/>
         <sch:extends rule="rule-sch-stat-002-01-BY"/>
         <sch:extends rule="rule-sch-stat-002-01-HB"/>
         <sch:extends rule="rule-sch-stat-002-01-HE"/>
         <sch:extends rule="rule-sch-stat-002-01-HH"/>
         <sch:extends rule="rule-sch-stat-002-01-MV"/>
         <sch:extends rule="rule-sch-stat-002-01-NI"/>
         <sch:extends rule="rule-sch-stat-002-01-NW"/>
         <sch:extends rule="rule-sch-stat-002-01-RP"/>
         <sch:extends rule="rule-sch-stat-002-01-SH"/>
         <sch:extends rule="rule-sch-stat-002-01-SL"/>
         <sch:extends rule="rule-sch-stat-002-01-SN"/>
         <sch:extends rule="rule-sch-stat-002-01-ST"/>
         <sch:extends rule="rule-sch-stat-002-01-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-01-BB"/>
         <sch:extends rule="rule-sch-stat-002-01-BE"/>
         <sch:extends rule="rule-sch-stat-002-01-BW"/>
         <sch:extends rule="rule-sch-stat-002-01-BY"/>
         <sch:extends rule="rule-sch-stat-002-01-HB"/>
         <sch:extends rule="rule-sch-stat-002-01-HE"/>
         <sch:extends rule="rule-sch-stat-002-01-HH"/>
         <sch:extends rule="rule-sch-stat-002-01-MV"/>
         <sch:extends rule="rule-sch-stat-002-01-NI"/>
         <sch:extends rule="rule-sch-stat-002-01-NW"/>
         <sch:extends rule="rule-sch-stat-002-01-RP"/>
         <sch:extends rule="rule-sch-stat-002-01-SH"/>
         <sch:extends rule="rule-sch-stat-002-01-SL"/>
         <sch:extends rule="rule-sch-stat-002-01-SN"/>
         <sch:extends rule="rule-sch-stat-002-01-ST"/>
         <sch:extends rule="rule-sch-stat-002-01-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-01-BB"/>
         <sch:extends rule="rule-sch-stat-002-01-BE"/>
         <sch:extends rule="rule-sch-stat-002-01-BW"/>
         <sch:extends rule="rule-sch-stat-002-01-BY"/>
         <sch:extends rule="rule-sch-stat-002-01-HB"/>
         <sch:extends rule="rule-sch-stat-002-01-HE"/>
         <sch:extends rule="rule-sch-stat-002-01-HH"/>
         <sch:extends rule="rule-sch-stat-002-01-MV"/>
         <sch:extends rule="rule-sch-stat-002-01-NI"/>
         <sch:extends rule="rule-sch-stat-002-01-NW"/>
         <sch:extends rule="rule-sch-stat-002-01-RP"/>
         <sch:extends rule="rule-sch-stat-002-01-SH"/>
         <sch:extends rule="rule-sch-stat-002-01-SL"/>
         <sch:extends rule="rule-sch-stat-002-01-SN"/>
         <sch:extends rule="rule-sch-stat-002-01-ST"/>
         <sch:extends rule="rule-sch-stat-002-01-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:datenEinzelnesGebaeude">
         <sch:extends rule="rule-sch-stat-001"/>
         <sch:extends rule="rule-sch-stat-002-BB"/>
         <sch:extends rule="rule-sch-stat-002-BE"/>
         <sch:extends rule="rule-sch-stat-002-BW"/>
         <sch:extends rule="rule-sch-stat-002-BY"/>
         <sch:extends rule="rule-sch-stat-002-HB"/>
         <sch:extends rule="rule-sch-stat-002-HE"/>
         <sch:extends rule="rule-sch-stat-002-HH"/>
         <sch:extends rule="rule-sch-stat-002-MV"/>
         <sch:extends rule="rule-sch-stat-002-NI"/>
         <sch:extends rule="rule-sch-stat-002-NW"/>
         <sch:extends rule="rule-sch-stat-002-RP"/>
         <sch:extends rule="rule-sch-stat-002-SH"/>
         <sch:extends rule="rule-sch-stat-002-SL"/>
         <sch:extends rule="rule-sch-stat-002-SN"/>
         <sch:extends rule="rule-sch-stat-002-ST"/>
         <sch:extends rule="rule-sch-stat-002-TH"/>
         <sch:extends rule="rule-sch-stat-007"/>
         <sch:extends rule="rule-sch-stat-008"/>
         <sch:extends rule="rule-sch-stat-009"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauabgang.0426//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.erloscheneBaugenehmigung.0422//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:allgemeineAngaben">
         <sch:extends rule="rule-sch-stat-003"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:heizenergie">
         <sch:extends rule="rule-sch-stat-004"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baufertigstellung.0425//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baugenehmigung.0421//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauabgang.0426//xbau:anzahlRaeume">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.bauueberhang.0427//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.baubeginn.0423//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.fertigstellungRohbau.0424//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenAlt">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
      <sch:rule context="xbau:statistik.datenBauvorhaben.0420//xbau:anzahlDerWohnungenNeu">
         <sch:extends rule="rule-sch-stat-005"/>
         <sch:extends rule="rule-sch-stat-006"/>
      </sch:rule>
   </sch:pattern>
</sch:schema>
