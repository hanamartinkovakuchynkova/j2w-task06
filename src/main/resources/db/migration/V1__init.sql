CREATE TABLE vizitka
(
    id IDENTITY PRIMARY KEY,
    cele_jmeno VARCHAR(100) NOT NULL,
    firma      VARCHAR(100) NOT NULL,
    ulice      VARCHAR(100) NOT NULL,
    obec       VARCHAR(100) NOT NULL,
    psc        CHAR(5)      NOT NULL,
    email      VARCHAR(100),
    telefon    VARCHAR(20),
    web        VARCHAR(100)
);


INSERT INTO vizitka (cele_jmeno, firma, ulice, obec, psc, email, telefon, web)
VALUES ('Dita (Přikrylová) Formánková', 'Czechitas z. s.', 'Václavské náměstí 837/11', 'Praha 1', '11000', 'dita@czechitas.cs', '+420 800123456',
        'www.czechitas.cz'),
       ('Barbora Bühnová', 'Czechitas z. s.', 'Václavské náměstí 837/11', 'Praha 1', '11000', NULL, '+420 800123456', 'www.czechitas.cz'),
       ('Monika Ptáčníková', 'Czechitas z. s.', 'Václavské náměstí 837/11', 'Praha 1', '11000', 'monika@czechitas.cs', '+420 800123456', 'www.czechitas.cz'),
       ('Mirka Zatloukalová', 'Czechitas z. s.', 'Václavské náměstí 837/11', 'Praha 1', '11000', 'mirka@czechitas.cs', NULL, 'www.czechitas.cz');
