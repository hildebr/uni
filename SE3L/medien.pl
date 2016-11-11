:- dynamic produkt/7, verkauft/4.        % ermoeglicht dynamische Veraenderung
%:- multifile produkt/7, verkauft/4.      % ermoeglicht verteilte Definition in mehreren Files

aktuellerpreis(TITEL, AUTOR, VERLAG, ID, PREIS) :- findall(JAHR, verkauft(ID,JAHR,_,_), LISTE), max_list(LISTE, MAX_JAHR), produkt(ID,_,TITEL,AUTOR,VERLAG,_,_), verkauft(ID,MAX_JAHR,PREIS,_).
letztesKatalogJahr(ID, LETZTES_JAHR) :- findall(JAHR, verkauft(ID,JAHR,_,_), LISTE), max_list(LISTE, LETZTES_JAHR).
nichtAngebotenImBestand(ID) :- verkauft(ID,2016,_,0), produkt(ID,_,_,_,_,_,BESTAND), BESTAND>0.
anzahlInKategorie(KATEGORIE, ANZAHL) :- aggregate_all(count, produkt(_,KATEGORIE,_,_,_,_,_), ANZAHL).
inKategorieVerkauft(KATEGORIE, EXEMPLARE) :- findall(SUM, (produkt(PID, KATEGORIE,_,_,_,_,_),findall(ANZAHL, verkauft(PID,_,_,ANZAHL), LISTE), sumlist(LISTE, SUM)), SUMLIST), sumlist(SUMLIST, EXEMPLARE).
preisnachlassInJahr(JAHR, NACHLASS) :- findall(ERLS, (verkauft(_,JAHR, PREIS, ANZAHL), ERLS is PREIS * ANZAHL), GELD), sumlist(GELD, EINNAHMEN), VORJAHR is JAHR-1, findall(ERLS2, (verkauft(_,VORJAHR, PREIS2, ANZAHL2), ERLS2 is PREIS2 * ANZAHL2), GELD2), sumlist(GELD2, EINNAHMEN2), NACHLASS is EINNAHMEN - EINNAHMEN2.

% produkt(PId,Kategorie,Titel,Autor,Verlag,Jahr,Lagerbestand).
produkt(12345,buch,sonnenuntergang,hoffmann_susanne,meister,2008,23).
produkt(12346,buch,hoffnung,sand_molly,kasper,2007,319).
produkt(12347,buch,winterzeit,wolf_michael,meister,2005,204).
produkt(12348,buch,blutrache,wolf_michael,meister,2013,0).
produkt(12349,buch,winterzeit,wolf_michael,meister,2012,100).

produkt(23456,ebuch,sonnenuntergang,hoffmann_susanne,meister,2012,1).
produkt(23457,ebuch,spuren_im_schnee,wolf_michael,meister,2012,1).
produkt(23458,ebuch,blutrache,wolf_michael,meister,2013,1).

produkt(34567,hoerbuch,hoffnung,sand_molly,audio,2011,51).
produkt(34568,hoerbuch,winterzeit,wolf_michael,audio,2009,16).


% verkauft(PId,Jahr,Preis,Anzahl).
verkauft(12345,2009,39,71).
verkauft(12345,2010,39,23).
verkauft(12345,2011,39,11).
verkauft(12345,2012,29,15).
verkauft(12345,2013,29,17).
verkauft(12345,2014,29,9).
verkauft(12345,2015,23,8).
verkauft(12345,2016,23,5).
verkauft(12346,2008,24,391).
verkauft(12346,2009,24,129).
verkauft(12346,2010,24,270).
verkauft(12346,2011,24,350).
verkauft(12346,2012,24,168).
verkauft(12346,2013,24,89).
verkauft(12346,2014,24,30).
verkauft(12346,2015,24,2).
verkauft(12346,2016,12,22).
verkauft(12347,2005,29,430).
verkauft(12347,2006,34,380).
verkauft(12347,2007,39,137).
verkauft(12347,2008,39,24).
verkauft(12347,2009,39,0).
verkauft(12347,2010,39,0).
verkauft(12347,2011,29,0).
verkauft(12347,2012,29,0).
verkauft(12347,2013,29,0).
verkauft(12347,2014,19,0).
verkauft(12347,2015,9,0).
verkauft(12347,2016,2,0).
verkauft(12348,2013,29,412).
verkauft(12348,2014,29,257).
verkauft(12348,2015,29,12).
verkauft(12348,2016,17,213).
verkauft(12349,2013,19,45).
verkauft(12349,2014,19,137).
verkauft(12349,2015,14,83).
verkauft(12349,2016,14,97).

verkauft(23456,2012,13,0).
verkauft(23456,2013,13,1).
verkauft(23456,2014,13,3).
verkauft(23456,2015,13,2).
verkauft(23456,2016,13,0).
verkauft(23457,2012,13,1).
verkauft(23457,2013,13,2).
verkauft(23457,2014,13,1).
verkauft(23457,2015,2,70).
verkauft(23457,2016,2,5).
verkauft(23458,2013,13,12).
verkauft(23458,2014,13,21).
verkauft(23458,2015,13,13).
verkauft(23458,2016,13,19).

verkauft(34567,2011,21,99).
verkauft(34567,2012,21,124).
verkauft(34567,2013,21,89).
verkauft(34567,2014,21,52).
verkauft(34567,2015,21,39).
verkauft(34567,2016,21,45).
verkauft(34568,2009,16,4).
verkauft(34568,2010,16,28).
verkauft(34568,2011,16,3).
verkauft(34568,2012,3,112).
verkauft(34568,2013,3,89).
verkauft(34568,2014,3,75).
verkauft(34568,2015,3,23).
verkauft(34568,2016,3,2).
