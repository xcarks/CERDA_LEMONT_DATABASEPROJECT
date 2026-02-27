# CERDA-LEMONT-DATABASEPROJECT

PROMPT USED:  
"Act as a digital entertainment company that wants to develop a website to manage and display information about the cards of Magic: The Gathering.  
Your task is to write a database case study description in paragraph format. The company wants to computerize the management of card information, including their characteristics, classifications, artistic information, sets, rarity, and legality in different formats.  
The text must allow us to clearly identify entities, attributes, relationships, cardinalities, and constraints in order to build a conceptual, logical, and physical data model.  
The final text should be written in such a way that we can clearly deduce identifiers, descriptive properties, associations between elements, participation constraints, and business rules without them being explicitly listed.   
The result must resemble a realistic university database modeling case study."  

BUSINESS RULES:  
"A digital entertainment company wants to create a website to computerize and centralize information about the cards of the game Magic: The Gathering, published by Wizards of the Coast.  
The objective of the platform is to allow users to consult detailed information about each card, including its characteristics, classifications, artistic information, expansion sets, rarity, and legality in different competitive formats.  
The company explains the system requirements as follows:  
The system must manage a collection of Cards. Each card represents a unique game design and must be identified by a Card ID. For each card, the company wants to store its name, price, converted mana cost, whether it is legendary or not, and whether it is a token card.  
Each card belongs to one or several Types (for example Creature, Instant, Sorcery, Land, etc.). A type is defined only by its name. A type may classify many cards, and a card may have multiple types.  
In addition, a card may have zero, one, or several Subtypes (for example Wizard, Dragon, Equipment, etc.). A subtype is defined only by its name. A subtype can be associated with many cards, and a card can be associated with multiple subtypes.  
Each card may also have one or several Colors (for example White, Blue, Black, Red, Green). A color is defined only by the name of the color. A color may correspond to many cards, and a card may have zero or multiple colors.  
Each card is illustrated by one Artist. An artist must be identified by an Artist ID, and the system must store the artist’s name, surname, and full name. An artist may illustrate many different cards, but each card is illustrated by exactly one artist.  
Cards are published within Sets (expansions). Each set must have the code as identifier, also you have to include its name, and release date. A set contains many cards, and a card appears in only one set. Therefore, the system must allow tracking the presence of a card in one or several set.  
Each card has a Rarity classification(Common, Uncommon, rare, mythical). The system must record whether the card is rare or not. A rarity category can apply to many cards, and each card has one rarity per set in which it appears.  
The company also wants the website to indicate the legality of each card in different competitive Formats. The formats to be managed are:  
- Standard
- Modern
- Vintage
- Commander
- Legacy
- Historic
- Pauper
- Pioneer 

For each format specifically, the legality must be stored as an enumerated value with one of the following states: (legal, not legal, banned, restricted).  
A card may have a different legality status in each format. Therefore, the system must allow a card to be associated with multiple formats, and for each association, a legality status must be recorded.  
The company specifies the following general rules:  
- A card must have exactly one Card ID.
- A card must have exactly one artist.
- A card must belong to at least one type.
- A card may have zero or more subtypes.
- A card may have zero or more colors.
- A card must appear in one set.
- A set may contain many cards.
- A card may have one legality status per format.  

Each format may contain many cards.
The objective of the database is to allow users to search for cards by name, type, subtype, color, artist, set, rarity, price, and legality in a specific format.  
The company wants the database structure to clearly represent the entities (Card, Type, Subtype, Color, Artist, Set, Rarity, Format), their attributes, and the relationships between them, so that a conceptual, logical, and physical data model can be designed from this description."  


MCD PICTURE:  
<img width="862" height="636" alt="image" src="https://github.com/user-attachments/assets/6a64a55d-e71a-4237-889e-9c53005c65c7" />


