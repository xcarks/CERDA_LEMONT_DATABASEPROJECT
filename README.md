# CERDA-LEMONT-DATABASEPROJECT

PROMPT USED:  
You work in the field of digital entertainment data management. Your company is involved in the domain of collectible card game information services. It is a digital content company such as Scryfall, Gatherer, or other online platforms that provide structured information about trading card games.
The company has collected structured information about cards, including identification data, pricing information, mana cost, rarity classification, artistic attribution, release sets, and legality in different competitive formats.  

Take inspiration from the following website:  
https://scryfall.com  

Your company wants to apply MERISE to design an information system. You are responsible for the analysis part, i.e., gathering the company's requirements. It has called on a computer engineering student to carry out this project, and you must provide him with the necessary information so that he can then apply the following steps of database design and development himself.  

First, establish the data business rules for your company in the form of a bulleted list. The rules must reflect how the company operates and manages card information, but they must not include technical database terminology. They should be written as operational rules expressed by someone who understands the business but not information system modeling.  

Next, based on these rules, provide a raw data dictionary grouped in a table with the following columns:
- Meaning of the data  
- Type (text, numeric, date, boolean, enumeration, etc.)  
- Size in number of characters or digits  
The dictionary must contain between 25 and 35 data items.  
The data dictionary must include information related to:  
- Card identification and characteristics (identifier, name, price, converted mana cost, legendary status, token status)  
- Classification data (type name, subtype name, color name)  
- Artistic information (artist identifier, name, surname, full name)  
- Expansion release information (set identifier, set name, set code, release date)  
- Rarity information  
- Format legality information (Standard, Modern, Vintage, Commander, Legacy, Historic, Pauper, Pioneer)  
- For each legality attribut, it must allow the values: legal, not legal, banned, restricted  
  
The raw data dictionary must only describe the meaning, type, and size of each data item. It must not describe primary keys, foreign keys, relationships, or modeling assumptions.  

Provide the business rules first, then the raw data dictionary table.  

The final result must be suitable for a MERISE analysis phase document.  

BUSINESS RULES:  
The company operates a digital information service dedicated to collectible card games. The following rules describe how the business manages and maintains card information:  

- Each card published in the game has a unique internal identifier used by the company.  
- A card is identified by its official name as published by the game editor.  
- A card may belong to one or more colors (for example white, blue, black, red, green, or colorless).  
- Each card has a mana cost and a converted mana cost used to evaluate its play cost.  
- A card may be marked as legendary or non-legendary.  
- A card may be marked as a token or non-token.  
- Each card has a rarity level defined by the publisher (e.g., common, uncommon, rare, mythic).  
- A card is printed in one or more expansion sets.  
- Each expansion set has a unique identifier, a name, a short code, and a release date.  
- A card’s market price is tracked and updated regularly.  
- A card is associated with one or more types (e.g., creature, sorcery, artifact).  
- A card may have one or more subtypes (e.g., elf, wizard, equipment).  
- The company records the artist who created the card illustration.  
- Each artist has an internal identifier, a first name, and a last name.  
- The company stores the full name of the artist as displayed on the card.  
- Cards may have different legality statuses depending on the competitive format.  
- The company tracks legality for the following formats: Standard, Modern, Vintage, Commander, Legacy, Historic, Pauper, and Pioneer.  
- For the each legality formats, it can be marked as: legal, not legal, banned, or restricted.  
- A card’s legality status must reflect the most recent official rules update.  
- The company maintains historical expansion release information even after rotation from competitive formats.  
- Pricing information is stored in a specific currency.  
- Cards must always be associated with at least one expansion set.  
- Cards may share the same name but are distinguished by their set and internal identifier.  
- Classification information (type, subtype, color, rarity) follows official publisher terminology.  
- All stored information must reflect officially published data from the game editor.  

DATA DICTIONARY:
| Meaning of the Data              | Type                                               | Size                       |
| -------------------------------- | -------------------------------------------------- | -------------------------- |
| Card internal identifier         | Text                                               | 50 characters              |
| Card official name               | Text                                               | 50 characters              |
| Card converted mana cost         | Numeric (integrer)                                 | 32 digits                  |
| Card market price                | Numeric (decimal)                                  | 11 digits (2 decimals)     |
| Legendary status indicator       | Boolean                                            | 1 character                |
| Token status indicator           | Boolean                                            | 1 character                |
| Type name                        | Text                                               | 50 characters              |
| Subtype name                     | Text                                               | 50 characters              |
| Color name                       | Text                                               | 20 characters              |
| Rarity name                      | Enumeration (common, uncommon, rare, mythic)       | 10 characters              |
| Artist identifier                | Text                                               | 36 characters              |
| Artist first name                | Text                                               | 80 characters              |
| Artist last name                 | Text                                               | 80 characters              |
| Artist full name                 | Text                                               | 160 characters             |
| Expansion set name               | Text                                               | 150 characters             |
| Expansion set code               | Text                                               | 10 characters              |
| Expansion release date           | Date                                               | 10 characters (YYYY-MM-DD) |
| Standard format legality status  | Enumeration (legal, not legal, banned, restricted) | 15 characters              |
| Modern format legality status    | Enumeration                                        | 15 characters              |
| Vintage format legality status   | Enumeration                                        | 15 characters              |
| Commander format legality status | Enumeration                                        | 15 characters              |
| Legacy format legality status    | Enumeration                                        | 15 characters              |
| Historic format legality status  | Enumeration                                        | 15 characters              |
| Pauper format legality status    | Enumeration                                        | 15 characters              |
| Pioneer format legality status   | Enumeration                                        | 15 characters              |


MCD PICTURE:  
<img width="862" height="636" alt="image" src="https://github.com/user-attachments/assets/6a64a55d-e71a-4237-889e-9c53005c65c7" />


