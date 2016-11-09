:- dynamic student/5, professor/4, klausur/2.

%student(matrikelnummer, nachname, vorname, studiengang, semester)

student(12345, mueller, lisa, informatik, 3).
student(23456, meyer, anna, lehramt, 5).
student(34567, schultz, max, psychologie, 3).
student(45678, schmidt, leo, informatik, 5).
student(56789, fischer, emily, informatik, 1).
student(67890, weber, wolfgang, psychologie, 7).

%professor(identifikationsnummer, nachname, vorname, fachbereich)

professor(9876, wagner, richard, musik).
professor(8765, becker, ludwig, lehramt).
professor(7654, hoffman, bryan, psychologie).
professor(6543, koch, renate, informatik).
professor(5432, bauer, miriam, psychologie).
professor(4321, richter, marianne, informatik).

%klausur(modul, professorNr, termin, studentenMatrikelNummer, erreichteProzent)

klausur(statistik, 7654, 20160909, 45678, 80).
klausur(statistik, 7654, 20160909, 34567, 35).
klausur(statistik, 7654, 20161009, 34567, 55).
klausur(softwareentwicklung, 6543, 20140706, 67890, 28).
klausur(softwareentwicklung, 6543, 20140706, 12345, 32).
klausur(softwareentwicklung, 6543, 20140806, 23456, 79).
klausur(softwareentwicklung, 6543, 20140806, 56789, 67).
klausur(datenbanken, 4321, 20160817, 34567, 85).
klausur(datenbanken, 4321, 20160817, 56789, 48).
klausur(datenbanken, 4321, 20160917, 23456, 62).
klausur(datenbanken, 4321, 20160917, 67890, 94).









        