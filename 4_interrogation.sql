/* USAGE SCENARIO
This database is used by a specialized Magic: The Gathering store that also
organizes local tournaments and advises players building decks for different formats.

The main user is a Tournament and Store Manager.

This person uses the database for four practical purposes:
1) help players find cards legal in specific formats such as Standard, Pioneer, Modern, Commander or Pauper
2) recommend cards according to deck-building criteria such as color, type, subtype, mana cost, rarity and price
3) identify valuable cards for collectors, such as Mythic, legendary, rare and expensive cards
4) prepare tournament and shop reports, for example statistics by rarity, set, color and format legality

DATA TO EXTRACT

The Tournament and Store Manager needs queries to retrieve:
- names, prices and mana costs of cards
- cards by set, color, type, subtype and rarity
- cards legal or not legal in a chosen format
- legendary cards, token cards and collector-oriented cards
- price statistics by rarity, set, color and type
- cards matching advanced conditions such as:
	* cards without subtype
	* cards legal in several formats
    * cards more expensive than others in a category
	* cards suitable for Pauper or Commander players
*/

USE MagicTheGatheringDB;

-- 1) Cards sorted from most expensive to cheapest
SELECT card_name, card_price FROM cards ORDER BY card_price DESC, card_name;

-- 2) Unique sets represented in the store catalog
SELECT DISTINCT set_code FROM cards ORDER BY set_code;

-- 3) Cards whose names begin with 'A'
SELECT card_id, card_name, card_price FROM cards WHERE card_name LIKE 'A%' ORDER BY card_name;

-- 4) Cards with converted mana cost between 2 and 4
SELECT card_id, card_name, card_converted_mana_cost FROM cards 
WHERE card_converted_mana_cost BETWEEN 2 AND 4 ORDER BY card_converted_mana_cost, card_name;

-- 5) Cards with rarity Rare or Mythic
SELECT c.card_id, c.card_name, r.rarity_name FROM cards c 
JOIN rarity r ON c.rarity_id = r.rarity_id WHERE r.rarity_name IN ('Rare', 'Mythic') ORDER BY r.rarity_name, c.card_name;

-- 6) Legendary cards interesting for collectors
SELECT card_id, card_name, card_price, card_converted_mana_cost FROM cards
WHERE legendary = TRUE ORDER BY card_price DESC;

-- 7) Token cards used as game accessories during play
SELECT card_id, card_name FROM cards
WHERE token = TRUE ORDER BY card_name;

-- 8) Number of cards by rarity
SELECT r.rarity_name, COUNT(*) AS total_cards FROM cards c
JOIN rarity r ON c.rarity_id = r.rarity_id GROUP BY r.rarity_name ORDER BY total_cards DESC, r.rarity_name;

-- 9) Average card price by set
SELECT s.set_name, ROUND(AVG(c.card_price), 2) AS avg_price FROM cards c
JOIN c_set s ON c.set_code = s.set_code GROUP BY s.set_name ORDER BY avg_price DESC, s.set_name;

-- 10) Minimum and maximum price by color
SELECT ic.color_name, MIN(c.card_price) AS min_price, MAX(c.card_price) AS max_price FROM is_of_color ic
JOIN cards c ON ic.card_id = c.card_id GROUP BY ic.color_name ORDER BY max_price DESC, ic.color_name;

-- 11) Number of cards by type, keeping only types with at least 3 cards
SELECT it.type_name, COUNT(*) AS total_cards FROM is_of_type it GROUP BY it.type_name
HAVING COUNT(*) >= 3 ORDER BY total_cards DESC, it.type_name;

-- 12) Average mana cost by rarity, only rarities with average cost above 3
SELECT r.rarity_name, ROUND(AVG(c.card_converted_mana_cost), 2) AS avg_cmc FROM cards c
JOIN rarity r ON c.rarity_id = r.rarity_id GROUP BY r.rarity_name
HAVING AVG(c.card_converted_mana_cost) > 3 ORDER BY avg_cmc DESC, r.rarity_name;

-- 13) Number of legal cards by format, keeping only formats with at least 10 legal cards
SELECT f.format_name, COUNT(*) AS legal_cards FROM format_legality fl
JOIN c_format f ON fl.format_id = f.format_id WHERE fl.legality_status = 'Legal'
GROUP BY f.format_name HAVING COUNT(*) >= 10
ORDER BY legal_cards DESC, f.format_name;

-- 14) Card and rarity
SELECT c.card_name, r.rarity_name FROM cards c
JOIN rarity r ON c.rarity_id = r.rarity_id ORDER BY c.card_name;

-- 15) Complete collector view: card, set, rarity, artist and price
SELECT c.card_name, s.set_name, r.rarity_name, CONCAT(a.artist_fname, ' ', a.artist_lname) AS artist_name, c.card_price
FROM cards c JOIN c_set s ON c.set_code = s.set_code 
JOIN rarity r ON c.rarity_id = r.rarity_id 
JOIN artist a ON c.artist_id = a.artist_id
ORDER BY c.card_name;

-- 16) Cards and their colors, useful for deck building advice
SELECT c.card_name, ic.color_name FROM cards c
JOIN is_of_color ic ON c.card_id = ic.card_id ORDER BY c.card_name, ic.color_name;

-- 17) All cards and their subtype if they have one
SELECT c.card_name, ios.subtype_name FROM cards c
LEFT JOIN is_of_subtype ios ON c.card_id = ios.card_id ORDER BY c.card_name, ios.subtype_name;

-- 18) Cards legal in Commander with type and rarity
SELECT c.card_name, it.type_name, r.rarity_name FROM cards c
JOIN is_of_type it ON c.card_id = it.card_id
JOIN rarity r ON c.rarity_id = r.rarity_id
JOIN format_legality fl ON c.card_id = fl.card_id
JOIN c_format f ON fl.format_id = f.format_id
WHERE f.format_name = 'Commander' AND fl.legality_status = 'Legal'
ORDER BY c.card_name, it.type_name;

-- 19) Number of subtypes per card
SELECT c.card_name, COUNT(ios.subtype_name) AS total_subtypes FROM cards c
LEFT JOIN is_of_subtype ios ON c.card_id = ios.card_id
GROUP BY c.card_id, c.card_name ORDER BY total_subtypes DESC, c.card_name;

-- 20) Mythic cards, useful for collector recommendations
SELECT card_id, card_name, card_price FROM cards
WHERE rarity_id IN (
    SELECT rarity_id FROM rarity WHERE rarity_name = 'Mythic'
)
ORDER BY card_price DESC, card_name;

-- 21) Cards that are not colorless
SELECT card_id, card_name FROM cards
WHERE card_id NOT IN (
    SELECT card_id FROM is_of_color WHERE color_name = 'Colorless'
)
ORDER BY card_name;

-- 22) Cards that have at least one subtype
SELECT c.card_id, c.card_name FROM cards c
WHERE EXISTS (
    SELECT 1 FROM is_of_subtype ios WHERE ios.card_id = c.card_id
)
ORDER BY c.card_name;

-- 23) Cards with no subtype
SELECT c.card_id, c.card_name FROM cards c
WHERE NOT EXISTS (
    SELECT 1 FROM is_of_subtype ios WHERE ios.card_id = c.card_id
)
ORDER BY c.card_name;

-- 24) Cards more expensive than at least one Mythic card
SELECT card_id, card_name, card_price FROM cards
WHERE card_price > ANY (
    SELECT c2.card_price FROM cards c2
    JOIN rarity r2 ON c2.rarity_id = r2.rarity_id WHERE r2.rarity_name = 'Mythic'
)
ORDER BY card_price DESC, card_name;

-- 25) Cards cheaper than all Mythic cards
SELECT card_id, card_name, card_price FROM cards
WHERE card_price < ALL (
    SELECT c2.card_price FROM cards c2
    JOIN rarity r2 ON c2.rarity_id = r2.rarity_id WHERE r2.rarity_name = 'Mythic'
)
ORDER BY card_price ASC, card_name;

-- 26) Cards legal in Standard, Pioneer and Modern at the same time
SELECT c.card_id, c.card_name FROM cards c
WHERE EXISTS (
    SELECT 1 FROM format_legality fl1
    JOIN c_format f1 ON fl1.format_id = f1.format_id
    WHERE fl1.card_id = c.card_id AND f1.format_name = 'Standard' AND fl1.legality_status = 'Legal'
)
AND EXISTS (
    SELECT 1 FROM format_legality fl2
    JOIN c_format f2 ON fl2.format_id = f2.format_id
    WHERE fl2.card_id = c.card_id AND f2.format_name = 'Pioneer' AND fl2.legality_status = 'Legal'
)
AND EXISTS (
    SELECT 1 FROM format_legality fl3
    JOIN c_format f3 ON fl3.format_id = f3.format_id
    WHERE fl3.card_id = c.card_id AND f3.format_name = 'Modern' AND fl3.legality_status = 'Legal'
)
ORDER BY c.card_name;

-- 27) Cards that are not legal in Pauper
SELECT c.card_id, c.card_name FROM cards c
WHERE NOT EXISTS (
    SELECT 1 FROM format_legality fl
	JOIN c_format f ON fl.format_id = f.format_id
    WHERE fl.card_id = c.card_id AND f.format_name = 'Pauper' AND fl.legality_status = 'Legal'
)
ORDER BY c.card_name;
