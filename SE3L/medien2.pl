:- dynamic kategorie/3.        % ermoeglicht dynamische Veraenderung
%:- multifile kategorie/3.      % ermoeglicht verteilte Definition in mehreren Files

unterkategorieZu(KATEGORIE, ULISTE) :- kategorie(ID,KATEGORIE,_), findall(NAME, kategorie(_, NAME, ID), ULISTE).
duplikatKategorien(DLISTE) :- findall(X, (kategorie(ID1, X,_), kategorie(ID2, X,_), ID1 \= ID2), LISTE), sort(LISTE, DLISTE).
kategorienOhneUnterkategorien(LISTE) :-  findall((ID,KATEGORIE),  (kategorie(ID, KATEGORIE,_), findall(NAME, kategorie(_,NAME,ID), ULISTE), length(ULISTE, 0)), LISTE).
verletzteHirarchien(SORTED) :- findall((KID,NAME,UID), (kategorie(KID, NAME, UID), kategorie(KID, NAME, UID2), UID\=UID2), LISTE), sort(LISTE, SORTED).

% kategorie(Id_Unterkategorie,Name_Unterkategorie,Id_Oberkategorie)
kategorie(1,buch,0).
kategorie(2,ebuch,0).
kategorie(3,hoerbuch,0).
kategorie(4,kinder,1).
kategorie(5,kinder,2).
kategorie(6,kinder,3).
kategorie(7,krimi,1).
kategorie(8,krimi,2).
kategorie(9,krimi,3).
kategorie(10,roman,1).
kategorie(11,roman,2).
kategorie(12,roman,3).
kategorie(13,sachbuch,1).
kategorie(14,sachbuch,2).
kategorie(15,bilderbuch,4).
kategorie(16,reisefuehrer,13).
kategorie(17,lexikon,13).
kategorie(18,lyrik,1).
kategorie(19,lyrik,3).
kategorie(20,bastelbuch,4).
kategorie(21,woerterbuch,13).

% produkt(PId,KId,Titel,Autor,Verlag,Jahr,Lagerbestand).
produkt(12345,10,sonnenuntergang,hoffmann_susanne,meister,2008,23).
produkt(12346,18,hoffnung,sand_molly,kasper,2007,319).
produkt(12347,7,winterzeit,wolf_michael,meister,2005,0).
produkt(12348,7,blutrache,wolf_michael,meister,2013,200).
produkt(12349,7,winterzeit,wolf_michael,meister,2012,100).

produkt(23456,11,sonnenuntergang,hoffmann_susanne,meister,2012,1).
produkt(23457,11,spuren_im_schnee,wolf_michael,meister,2012,1).
produkt(23458,8,blutrache,wolf_michael,meister,2013,1).

produkt(34567,19,hoffnung,sand_molly,audio,2011,51).
produkt(34568,9,winterzeit,wolf_michael,audio,2009,16).

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
