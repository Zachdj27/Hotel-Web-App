--Tout pour créer la base de donneé
--  Table Chaine Hotelière
CREATE TABLE Chaine_hoteliere (
    chain_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    adresse_bureau TEXT,
    nombre_hotels INT,
    email VARCHAR(100)
);

--  Table Hôtel
CREATE TABLE Hotel (
    hotel_id INT PRIMARY KEY,
    chain_id INT REFERENCES Chaine_hoteliere(chain_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    adresse TEXT,
    numero_telephone VARCHAR(20),
    email VARCHAR(100),
    classement INT CHECK (classement BETWEEN 1 AND 5),
    pays VARCHAR(255),
    zone VARCHAR(255) --région/ville où se situe l'hôtel
);

--  Table Chambre
CREATE TABLE Chambre (
    room_id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES Hotel(hotel_id) ON DELETE CASCADE,
    numero_chambre VARCHAR(10) NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    commodites TEXT,
    capacite INT CHECK (capacite > 0),
    vue VARCHAR(50),
    superficie INT CHECK (superficie > 0),
    etendre BOOLEAN DEFAULT FALSE,
    dommages TEXT
);

-- Table Employee
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES Hotel(hotel_id) ON DELETE CASCADE, --hôtel où l'employé travaille
    NAS VARCHAR(20) UNIQUE NOT NULL,
    nom_complet VARCHAR(255) NOT NULL,
    adresse TEXT,
    poste VARCHAR(100),
    password VARCHAR(255),
);

--  Table Client
CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    NAS VARCHAR(20) UNIQUE NOT NULL,
    nom_complet VARCHAR(255) NOT NULL,
    adresse TEXT,
    password VARCHAR(255),
    date_enregistrement DATE DEFAULT CURRENT_DATE
);

--  Table Booking (Réservation)
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(client_id) ON DELETE CASCADE,
    room_id INT REFERENCES Chambre(room_id) ON DELETE CASCADE,
    entry_date DATE NOT NULL, --Day when they check in
    leaving_date DATE NOT NULL, --Checkout day
    status VARCHAR(20) CHECK (status IN ('Réservé', 'Confirmé', 'Annulé'))
);


--  Table Location (Lorsqu’un client enregistre sa réservation)
CREATE TABLE Location (
    location_id SERIAL PRIMARY KEY,
    booking_id  INT  UNIQUE NULL, --Permettre location sans réservation
    client_id INT NOT NULL REFERENCES Client(client_id) ON DELETE CASCADE,
    l_date DATE DEFAULT CURRENT_DATE,
	FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

--  Index pour optimiser les requêtes SQL
CREATE INDEX idx_hotel_chain ON Hotel(chain_id);
CREATE INDEX idx_room_price ON Chambre(prix);
CREATE INDEX idx_booking_client ON Booking(client_id);

-- Trigger 1 : Empêcher la double réservation d’une chambre
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Booking 
        WHERE room_id = NEW.room_id
        AND status IN ('Réservé', 'Confirmé')
        AND (
            NEW.entry_date BETWEEN entry_date AND leaving_date
            OR NEW.leaving_date BETWEEN entry_date AND leaving_date
            OR (NEW.entry_date <= entry_date AND NEW.leaving_date >= leaving_date) 
        )
    ) THEN
        RAISE EXCEPTION 'Cette chambre est déjà réservée pour ces dates.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON Booking
FOR EACH ROW
EXECUTE FUNCTION check_room_availability();

-- Trigger 2 : Automatiser la conversion d’une réservation en location
CREATE OR REPLACE FUNCTION convert_booking_to_location()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.client_id IS NOT NULL THEN
        INSERT INTO Location (booking_id, client_id, l_date)
        VALUES (NEW.booking_id, NEW.client_id, CURRENT_DATE);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_booking_confirmed
AFTER UPDATE ON Booking
FOR EACH ROW
WHEN (NEW.status = 'Confirmé')
EXECUTE FUNCTION convert_booking_to_location();

-- Creation de Vue
--Nombre de chambre par zone

CREATE OR REPLACE VIEW Chambre_par_zone AS
SELECT 
    h.zone, 
    COUNT(c.room_id) AS nombre_chambres_disponibles
FROM Chambre c
JOIN Hotel h ON c.hotel_id = h.hotel_id
WHERE NOT EXISTS (
    SELECT 1 
    FROM Booking b
    WHERE b.room_id = c.room_id 
    AND (b.status = 'Confirmé'
    OR b.status ='Réservé')
    AND (
        CURRENT_DATE BETWEEN b.entry_date AND b.leaving_date
    )
)
GROUP BY h.zone;

--capacité total d'un hotel (Seulement les chambres disponibles)
CREATE OR REPLACE VIEW Capacite_hotel_disponible AS 
SELECT 
    h.hotel_id,
    h.name, 
    SUM(c.capacite) AS capacite_total_disponible
FROM Chambre c
JOIN Hotel h ON c.hotel_id = h.hotel_id
WHERE NOT EXISTS (
    SELECT 1 
    FROM Booking b
    WHERE b.room_id = c.room_id 
    AND b.status IN ('Confirmé', 'Réservé')
    AND CURRENT_DATE BETWEEN b.entry_date AND b.leaving_date
)
GROUP BY h.hotel_id, h.name;


-- Insert an employee
INSERT INTO Employee (hotel_id, NAS, nom_complet, adresse, poste, password)
VALUES (1, '300355543', 'John Doe', '123 Main St', 'Manager', 'motDePasse');

-- Insert a client
INSERT INTO Client (NAS, nom_complet, adresse, password)
VALUES ('300355345', 'Jane Smith', '456 Oak Ave', 'Password');

-- Hotel Chains 
INSERT INTO Chaine_hoteliere (chain_id, name, adresse_bureau, nombre_hotels, email)
VALUES
(1,'Elite Suites', '123 Prestige Ave, New York, USA', 8, 'contact@elitesuites.com'),
(2,'Budget Stay', '456 Affordable St, Toronto, Canada', 8, 'info@budgetstay.com'),
(3,'Green Getaways', '789 Eco Blvd, Miami, USA', 8, 'support@greengeaways.com'),
(4,'Royal Resorts', '101 Royal Rd, Cancun, Mexico', 8, 'hello@royalresorts.com'),
(5,'Coastal Escapes', '202 Beachfront Dr, San Diego, USA', 8, 'reservations@coastalescapes.com');

-- Hotels (modified to fit the new table structure)
-- Chain 1: Elite Suites (New York, USA)
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement, pays, zone)
VALUES
(1, 'Elite Suites Downtown', '101 City St, New York', '123-001-2345', 'downtown@elitesuites.com', 5, 'USA', 'New York'),
(1, 'Elite Suites Beachfront', '202 Ocean Blvd, New York', '123-001-2346', 'beachfront@elitesuites.com', 5, 'USA', 'New York'),
(1, 'Elite Suites Garden', '303 Park Ave, New York', '123-001-2347', 'garden@elitesuites.com', 4, 'USA', 'New York'),
(1, 'Elite Suites Hilltop', '404 Hillside Rd, Albany', '123-001-2348', 'hilltop@elitesuites.com', 4, 'USA', 'Albany'),
(1, 'Elite Suites Mountain', '505 Summit Ave, Albany', '123-001-2349', 'mountain@elitesuites.com', 5, 'USA', 'Albany'),
(1, 'Elite Suites Cityview', '606 City View Rd, Syracuse', '123-001-2350', 'cityview@elitesuites.com', 3, 'USA', 'Syracuse'),
(1, 'Elite Suites Seaside', '707 Beach Rd, Syracuse', '123-001-2351', 'seaside@elitesuites.com', 4, 'USA', 'Syracuse'),
(1, 'Elite Suites Countryside', '808 Countryside Ave, Rochester', '123-001-2352', 'countryside@elitesuites.com', 3, 'USA', 'Rochester');

-- Chain 2: Budget Stay (Toronto, Canada)
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement, pays, zone)
VALUES
(2, 'Budget Stay Downtown', '909 Urban St, Toronto', '234-001-2345', 'downtown@budgetstay.com', 2, 'Canada', 'Toronto'),
(2, 'Budget Stay Cityside', '1010 City View Rd, Toronto', '234-001-2346', 'cityside@budgetstay.com', 2, 'Canada', 'Toronto'),
(2, 'Budget Stay Highway', '1111 Freeway Rd, Mississauga', '234-001-2347', 'highway@budgetstay.com', 1, 'Canada', 'Mississauga'),
(2, 'Budget Stay Riverside', '1212 River St, Mississauga', '234-001-2348', 'riverside@budgetstay.com', 2, 'Canada', 'Mississauga'),
(2, 'Budget Stay Coastal', '1313 Shore Blvd, Ottawa', '234-001-2349', 'coastal@budgetstay.com', 3, 'Canada', 'Ottawa'),
(2, 'Budget Stay Suburbs', '1414 Suburb Rd, Ottawa', '234-001-2350', 'suburbs@budgetstay.com', 1, 'Canada', 'Ottawa'),
(2, 'Budget Stay Urban', '1515 City Blvd, London', '234-001-2351', 'urban@budgetstay.com', 2, 'Canada', 'London'),
(2, 'Budget Stay Village', '1616 Village Rd, London', '234-001-2352', 'village@budgetstay.com', 3, 'Canada', 'London');

-- Chain 3: Green Getaways (Miami, USA)
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement, pays, zone)
VALUES
(3, 'Green Getaways Forest', '1717 Eco Park Rd, Miami', '345-001-2345', 'forest@greengeaways.com', 4, 'USA', 'Miami'),
(3, 'Green Getaways River', '1818 Riverbank Ave, Miami', '345-001-2346', 'river@greengeaways.com', 5, 'USA', 'Miami'),
(3, 'Green Getaways Desert', '1919 Desert Path, Orlando', '345-001-2347', 'desert@greengeaways.com', 3, 'USA', 'Orlando'),
(3, 'Green Getaways Jungle', '2020 Jungle Rd, Orlando', '345-001-2348', 'jungle@greengeaways.com', 4, 'USA', 'Orlando'),
(3, 'Green Getaways Mountain', '2121 Peak Rd, Tampa', '345-001-2349', 'mountain@greengeaways.com', 5, 'USA', 'Tampa'),
(3, 'Green Getaways Lakeside', '2222 Lakeview Ave, Tampa', '345-001-2350', 'lakeside@greengeaways.com', 3, 'USA', 'Tampa'),
(3, 'Green Getaways Urban', '2323 Green St, Jacksonville', '345-001-2351', 'urban@greengeaways.com', 2, 'USA', 'Jacksonville'),
(3, 'Green Getaways Retreat', '2424 Retreat Rd, Jacksonville', '345-001-2352', 'retreat@greengeaways.com', 4, 'USA', 'Jacksonville');

-- Chain 4: Royal Resorts (Cancun, Mexico)
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement, pays, zone)
VALUES
(4, 'Royal Resorts Plaza', '2525 Regal Blvd, Cancun', '456-001-2345', 'plaza@royalresorts.com', 5, 'Mexico', 'Cancun'),
(4, 'Royal Resorts Oceanview', '2626 Shoreline Dr, Cancun', '456-001-2346', 'oceanview@royalresorts.com', 5, 'Mexico', 'Cancun'),
(4, 'Royal Resorts Cityview', '2727 Downtown Ave, Playa del Carmen', '456-001-2347', 'cityview@royalresorts.com', 4, 'Mexico', 'Playa del Carmen'),
(4, 'Royal Resorts Hillside', '2828 Hills Rd, Playa del Carmen', '456-001-2348', 'hillside@royalresorts.com', 4, 'Mexico', 'Playa del Carmen'),
(4, 'Royal Resorts Summit', '2929 Mountain Rd, Tulum', '456-001-2349', 'summit@royalresorts.com', 5, 'Mexico', 'Tulum'),
(4, 'Royal Resorts Urban', '3030 Urban St, Tulum', '456-001-2350', 'urban@royalresorts.com', 3, 'Mexico', 'Tulum'),
(4, 'Royal Resorts Parkview', '3131 Park Ave, Cozumel', '456-001-2351', 'parkview@royalresorts.com', 4, 'Mexico', 'Cozumel'),
(4, 'Royal Resorts Country', '3232 Country Rd, Cozumel', '456-001-2352', 'country@royalresorts.com', 3, 'Mexico', 'Cozumel');

-- Chain 5: Coastal Escapes (San Diego, USA)
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement, pays, zone)
VALUES
(5, 'Coastal Escapes Sunrise', '3333 Sunrise Dr, San Diego', '567-001-2345', 'sunrise@coastalescapes.com', 4, 'USA', 'San Diego'),
(5, 'Coastal Escapes Horizon', '3434 Horizon Blvd, San Diego', '567-001-2346', 'horizon@coastalescapes.com', 5, 'USA', 'San Diego'),
(5, 'Coastal Escapes Retreat', '3535 Shore Rd, San Diego', '567-001-2347', 'retreat@coastalescapes.com', 4, 'USA', 'San Diego'),
(5, 'Coastal Escapes Island', '3636 Island Rd, Coronado', '567-001-2348', 'island@coastalescapes.com', 5, 'USA', 'Coronado'),
(5, 'Coastal Escapes Cityview', '3737 City Blvd, Coronado', '567-001-2349', 'cityview@coastalescapes.com', 3, 'USA', 'Coronado'),
(5, 'Coastal Escapes Bayview', '3838 Bay Rd, Carlsbad', '567-001-2350', 'bayview@coastalescapes.com', 4, 'USA', 'Carlsbad'),
(5, 'Coastal Escapes Urban', '3939 Ocean St, Carlsbad', '567-001-2351', 'urban@coastalescapes.com', 2, 'USA', 'Carlsbad'),
(5, 'Coastal Escapes Lagoon', '4040 Lagoon Dr, Oceanside', '567-001-2352', 'lagoon@coastalescapes.com', 3, 'USA', 'Oceanside');


-- Données pour les chambres d'hôtels individuelles

-- Elite Suites Hotels
-- Elite Suites - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (1, '101', 150.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL, 20),
       (1, '102', 250.00, 'TV, Air Conditionné, Réfrigérateur', 2, 'Mer', true, NULL, 30),
       (1, '103', 300.00, 'TV, Air Conditionné, Mini-Bar', 3, 'Mer', false, NULL, 40),
       (1, '104', 350.00, 'TV, Air Conditionné', 2, 'Montagne', false, NULL, 28),
       (1, '105', 500.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', true, NULL, 50);

-- Elite Suites - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (2, '201', 200.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL, 22),
       (2, '202', 270.00, 'TV, Air Conditionné', 2, 'Mer', true, NULL, 32),
       (2, '203', 350.00, 'TV, Air Conditionné', 3, 'Montagne', false, NULL, 42),
       (2, '204', 420.00, 'TV, Air Conditionné, Mini-Bar', 4, 'Mer', false, NULL, 48),
       (2, '205', 500.00, 'TV, Air Conditionné, Réfrigérateur', 5, 'Mer', true, NULL, 55);

-- Elite Suites - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (3, '301', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL, 21),
       (3, '302', 230.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL, 31),
       (3, '303', 280.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL, 41),
       (3, '304', 330.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Mer', true, NULL, 43),
       (3, '305', 400.00, 'TV, Air Conditionné, Balcon', 4, 'Montagne', false, NULL, 52);

-- Elite Suites - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (4, '401', 170.00, 'TV, Réfrigérateur', 1, 'Montagne', false, NULL, 23),
       (4, '402', 220.00, 'TV, Air Conditionné', 2, 'Mer', true, NULL, 33),
       (4, '403', 290.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL, 43),
       (4, '404', 360.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', false, NULL, 45),
       (4, '405', 460.00, 'TV, Air Conditionné, Balcon', 5, 'Mer', true, NULL, 58);

-- Elite Suites - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (5, '501', 180.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL, 24),
       (5, '502', 240.00, 'TV, Air Conditionné, Mini-Bar', 2, 'Montagne', true, NULL, 34),
       (5, '503', 310.00, 'TV, Réfrigérateur', 3, 'Mer', false, NULL, 44),
       (5, '504', 370.00, 'TV, Air Conditionné, Réfrigérateur', 4, 'Montagne', true, NULL, 47),
       (5, '505', 450.00, 'TV, Mini-Bar, Balcon', 5, 'Mer', false, NULL, 57);

-- Elite Suites - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (6, '601', 200.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL, 25),
       (6, '602', 270.00, 'TV, Air Conditionné, Mini-Bar', 2, 'Mer', true, NULL, 35),
       (6, '603', 320.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Mer', false, NULL, 45),
       (6, '604', 380.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL, 46),
       (6, '605', 470.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL, 59);

-- Elite Suites - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (7, '701', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL, 26),
       (7, '702', 250.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL, 36),
       (7, '703', 300.00, 'TV, Réfrigérateur', 3, 'Mer', false, NULL, 46),
       (7, '704', 370.00, 'TV, Air Conditionné, Mini-Bar', 3, 'Montagne', true, NULL, 48),
       (7, '705', 450.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL, 56);

-- Elite Suites - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages, superficie) 
VALUES (8, '801', 180.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL, 27),
       (8, '802', 230.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL, 37),
       (8, '803', 280.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', false, NULL, 47),
       (8, '804', 340.00, 'TV, Air Conditionné', 3, 'Mer', true, NULL, 49),
       (8, '805', 420.00, 'TV, Air Conditionné, Balcon', 5, 'Mer', false, NULL, 60);

-- Budget Stay Hotels
-- Budget Stay Hotels
-- Budget Stay - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (9, '101', 100.00, 'TV, Air Conditionné', 1, 'Montagne', 20, false, NULL),
       (9, '102', 120.00, 'TV, Réfrigérateur', 2, 'Mer', 25, true, NULL),
       (9, '103', 150.00, 'TV, Air Conditionné', 3, 'Mer', 30, false, NULL),
       (9, '104', 180.00, 'TV, Air Conditionné', 2, 'Montagne', 28, true, NULL),
       (9, '105', 200.00, 'TV, Air Conditionné', 4, 'Mer', 35, false, NULL);

-- Budget Stay - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (10, '201', 110.00, 'TV, Air Conditionné', 1, 'Montagne', 22, false, NULL),
       (10, '202', 140.00, 'TV, Réfrigérateur', 2, 'Mer', 26, true, NULL),
       (10, '203', 170.00, 'TV, Air Conditionné', 3, 'Mer', 32, false, NULL),
       (10, '204', 200.00, 'TV, Mini-Bar', 3, 'Montagne', 30, true, NULL),
       (10, '205', 250.00, 'TV, Air Conditionné', 4, 'Mer', 38, false, NULL);

-- Budget Stay - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (11, '301', 100.00, 'TV, Air Conditionné', 1, 'Mer', 21, false, NULL),
       (11, '302', 140.00, 'TV, Réfrigérateur', 2, 'Montagne', 27, true, NULL),
       (11, '303', 180.00, 'TV, Mini-Bar', 3, 'Mer', 33, false, NULL),
       (11, '304', 210.00, 'TV, Air Conditionné', 3, 'Montagne', 31, true, NULL),
       (11, '305', 250.00, 'TV, Réfrigérateur', 4, 'Mer', 39, false, NULL);

-- Budget Stay - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (12, '401', 120.00, 'TV, Air Conditionné', 1, 'Montagne', 23, false, NULL),
       (12, '402', 150.00, 'TV, Mini-Bar', 2, 'Mer', 28, true, NULL),
       (12, '403', 180.00, 'TV, Air Conditionné', 3, 'Mer', 34, false, NULL),
       (12, '404', 210.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', 32, true, NULL),
       (12, '405', 230.00, 'TV, Air Conditionné', 4, 'Mer', 40, false, NULL);

-- Budget Stay - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (13, '501', 130.00, 'TV, Air Conditionné', 1, 'Mer', 24, false, NULL),
       (13, '502', 160.00, 'TV, Air Conditionné', 2, 'Montagne', 29, true, NULL),
       (13, '503', 190.00, 'TV, Mini-Bar', 3, 'Mer', 35, false, NULL),
       (13, '504', 220.00, 'TV, Air Conditionné', 3, 'Montagne', 33, true, NULL),
       (13, '505', 250.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', 41, false, NULL);

-- Budget Stay - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (14, '601', 140.00, 'TV, Air Conditionné', 1, 'Montagne', 25, false, NULL),
       (14, '602', 170.00, 'TV, Mini-Bar', 2, 'Mer', 30, true, NULL),
       (14, '603', 200.00, 'TV, Air Conditionné', 3, 'Montagne', 36, false, NULL),
       (14, '604', 230.00, 'TV, Air Conditionné', 3, 'Mer', 34, true, NULL),
       (14, '605', 260.00, 'TV, Mini-Bar', 4, 'Mer', 42, false, NULL);

-- Budget Stay - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (15, '701', 110.00, 'TV, Air Conditionné', 1, 'Mer', 22, false, NULL),
       (15, '702', 140.00, 'TV, Air Conditionné', 2, 'Montagne', 27, true, NULL),
       (15, '703', 190.00, 'TV, Mini-Bar', 3, 'Mer', 33, false, NULL),
       (15, '704', 210.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', 31, true, NULL),
       (15, '705', 250.00, 'TV, Mini-Bar', 4, 'Mer', 39, false, NULL);

-- Budget Stay - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (16, '801', 120.00, 'TV, Air Conditionné', 1, 'Mer', 23, false, NULL),
       (16, '802', 150.00, 'TV, Mini-Bar', 2, 'Montagne', 28, true, NULL),
       (16, '803', 180.00, 'TV, Air Conditionné', 3, 'Mer', 34, false, NULL),
       (16, '804', 200.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', 32, true, NULL),
       (16, '805', 240.00, 'TV, Air Conditionné', 4, 'Mer', 40, false, NULL);

-- Green Getaways Hotels
-- Green Getaways - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (17, '101', 140.00, 'TV, Air Conditionné', 1, 'Montagne', 25, false, NULL),
       (17, '102', 170.00, 'TV, Réfrigérateur', 2, 'Mer', 30, true, NULL),
       (17, '103', 200.00, 'TV, Air Conditionné', 3, 'Mer', 35, false, NULL),
       (17, '104', 230.00, 'TV, Air Conditionné', 3, 'Montagne', 33, true, NULL),
       (17, '105', 280.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', 40, false, NULL);

-- Green Getaways - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (18, '201', 150.00, 'TV, Air Conditionné', 1, 'Mer', 26, false, NULL),
       (18, '202', 180.00, 'TV, Mini-Bar', 2, 'Montagne', 31, true, NULL),
       (18, '203', 220.00, 'TV, Air Conditionné', 3, 'Mer', 36, false, NULL),
       (18, '204', 260.00, 'TV, Air Conditionné', 3, 'Montagne', 34, true, NULL),
       (18, '205', 300.00, 'TV, Mini-Bar', 4, 'Mer', 42, false, NULL);

-- Green Getaways - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (19, '301', 160.00, 'TV, Air Conditionné', 1, 'Mer', 27, false, NULL),
       (19, '302', 200.00, 'TV, Mini-Bar', 2, 'Montagne', 32, true, NULL),
       (19, '303', 250.00, 'TV, Air Conditionné', 3, 'Mer', 37, false, NULL),
       (19, '304', 290.00, 'TV, Air Conditionné', 3, 'Montagne', 35, true, NULL),
       (19, '305', 350.00, 'TV, Mini-Bar', 4, 'Mer', 43, false, NULL);

-- Green Getaways - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (20, '401', 140.00, 'TV, Air Conditionné', 1, 'Montagne', 25, false, NULL),
       (20, '402', 170.00, 'TV, Air Conditionné', 2, 'Mer', 30, true, NULL),
       (20, '403', 220.00, 'TV, Air Conditionné', 3, 'Mer', 35, false, NULL),
       (20, '404', 260.00, 'TV, Mini-Bar', 3, 'Montagne', 33, true, NULL),
       (20, '405', 310.00, 'TV, Air Conditionné', 4, 'Mer', 41, false, NULL);

-- Green Getaways - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (21, '501', 170.00, 'TV, Air Conditionné', 1, 'Mer', 28, false, NULL),
       (21, '502', 210.00, 'TV, Air Conditionné', 2, 'Montagne', 33, true, NULL),
       (21, '503', 250.00, 'TV, Mini-Bar', 3, 'Mer', 38, false, NULL),
       (21, '504', 290.00, 'TV, Air Conditionné', 3, 'Montagne', 36, true, NULL),
       (21, '505', 350.00, 'TV, Air Conditionné', 4, 'Mer', 44, false, NULL);

-- Green Getaways - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (22, '601', 150.00, 'TV, Air Conditionné', 1, 'Montagne', 26, false, NULL),
       (22, '602', 180.00, 'TV, Mini-Bar', 2, 'Mer', 31, true, NULL),
       (22, '603', 220.00, 'TV, Air Conditionné', 3, 'Mer', 36, false, NULL),
       (22, '604', 260.00, 'TV, Air Conditionné', 3, 'Montagne', 34, true, NULL),
       (22, '605', 300.00, 'TV, Air Conditionné', 4, 'Mer', 42, false, NULL);

-- Green Getaways - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (23, '701', 180.00, 'TV, Air Conditionné', 1, 'Mer', 29, false, NULL),
       (23, '702', 210.00, 'TV, Mini-Bar', 2, 'Montagne', 34, true, NULL),
       (23, '703', 240.00, 'TV, Air Conditionné', 3, 'Mer', 37, false, NULL),
       (23, '704', 280.00, 'TV, Mini-Bar', 3, 'Montagne', 35, true, NULL),
       (23, '705', 350.00, 'TV, Air Conditionné', 4, 'Mer', 43, false, NULL);

-- Green Getaways - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (24, '801', 190.00, 'TV, Air Conditionné', 1, 'Montagne', 30, false, NULL),
       (24, '802', 230.00, 'TV, Mini-Bar', 2, 'Mer', 35, true, NULL),
       (24, '803', 260.00, 'TV, Air Conditionné', 3, 'Mer', 38, false, NULL),
       (24, '804', 300.00, 'TV, Air Conditionné', 3, 'Montagne', 36, true, NULL),
       (24, '805', 380.00, 'TV, Air Conditionné', 4, 'Mer', 44, false, NULL);

-- Royal Resorts Hotels
-- Royal Resorts - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (25, '101', 200.00, 'TV, Air Conditionné', 1, 'Mer', 32, false, NULL),
       (25, '102', 240.00, 'TV, Mini-Bar', 2, 'Montagne', 38, true, NULL),
       (25, '103', 300.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (25, '104', 350.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (25, '105', 400.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', 45, false, NULL);

-- Royal Resorts - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (26, '201', 220.00, 'TV, Air Conditionné', 1, 'Mer', 33, false, NULL),
       (26, '202', 260.00, 'TV, Mini-Bar', 2, 'Montagne', 39, true, NULL),
       (26, '203', 320.00, 'TV, Air Conditionné', 3, 'Mer', 43, false, NULL),
       (26, '204', 370.00, 'TV, Air Conditionné', 3, 'Montagne', 41, true, NULL),
       (26, '205', 450.00, 'TV, Air Conditionné', 4, 'Mer', 46, false, NULL);

-- Royal Resorts - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (27, '301', 210.00, 'TV, Air Conditionné', 1, 'Mer', 32, false, NULL),
       (27, '302', 250.00, 'TV, Mini-Bar', 2, 'Montagne', 38, true, NULL),
       (27, '303', 280.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (27, '304', 330.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (27, '305', 400.00, 'TV, Mini-Bar', 4, 'Mer', 45, false, NULL);

-- Royal Resorts - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (28, '401', 230.00, 'TV, Air Conditionné', 1, 'Mer', 33, false, NULL),
       (28, '402', 280.00, 'TV, Mini-Bar', 2, 'Montagne', 39, true, NULL),
       (28, '403', 320.00, 'TV, Air Conditionné', 3, 'Mer', 43, false, NULL),
       (28, '404', 380.00, 'TV, Air Conditionné', 3, 'Montagne', 41, true, NULL),
       (28, '405', 450.00, 'TV, Mini-Bar', 4, 'Mer', 46, false, NULL);

-- Royal Resorts - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (29, '501', 200.00, 'TV, Air Conditionné', 1, 'Mer', 32, false, NULL),
       (29, '502', 240.00, 'TV, Mini-Bar', 2, 'Montagne', 38, true, NULL),
       (29, '503', 300.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (29, '504', 350.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (29, '505', 420.00, 'TV, Air Conditionné', 4, 'Mer', 45, false, NULL);

-- Royal Resorts - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (30, '601', 210.00, 'TV, Air Conditionné', 1, 'Mer', 32, false, NULL),
       (30, '602', 250.00, 'TV, Mini-Bar', 2, 'Montagne', 38, true, NULL),
       (30, '603', 290.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (30, '604', 340.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (30, '605', 400.00, 'TV, Air Conditionné', 4, 'Mer', 45, false, NULL);

-- Royal Resorts - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (31, '701', 230.00, 'TV, Air Conditionné', 1, 'Mer', 33, false, NULL),
       (31, '702', 270.00, 'TV, Mini-Bar', 2, 'Montagne', 39, true, NULL),
       (31, '703', 320.00, 'TV, Air Conditionné', 3, 'Mer', 43, false, NULL),
       (31, '704', 380.00, 'TV, Air Conditionné', 3, 'Montagne', 41, true, NULL),
       (31, '705', 450.00, 'TV, Mini-Bar', 4, 'Mer', 46, false, NULL);

-- Royal Resorts - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (32, '801', 220.00, 'TV, Air Conditionné', 1, 'Montagne', 32, false, NULL),
       (32, '802', 260.00, 'TV, Mini-Bar', 2, 'Mer', 38, true, NULL),
       (32, '803', 300.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (32, '804', 350.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (32, '805', 420.00, 'TV, Air Conditionné', 4, 'Mer', 45, false, NULL);

-- Coastal Escapes Hotels
-- Coastal Escapes - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (33, '101', 160.00, 'TV, Air Conditionné', 1, 'Mer', 28, false, NULL),
       (33, '102', 190.00, 'TV, Mini-Bar', 2, 'Montagne', 33, true, NULL),
       (33, '103', 240.00, 'TV, Air Conditionné', 3, 'Mer', 37, false, NULL),
       (33, '104', 280.00, 'TV, Air Conditionné', 3, 'Montagne', 35, true, NULL),
       (33, '105', 350.00, 'TV, Mini-Bar', 4, 'Mer', 42, false, NULL);

-- Coastal Escapes - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (34, '201', 180.00, 'TV, Air Conditionné', 1, 'Mer', 29, false, NULL),
       (34, '202', 220.00, 'TV, Mini-Bar', 2, 'Montagne', 34, true, NULL),
       (34, '203', 260.00, 'TV, Air Conditionné', 3, 'Mer', 38, false, NULL),
       (34, '204', 300.00, 'TV, Air Conditionné', 3, 'Montagne', 36, true, NULL),
       (34, '205', 380.00, 'TV, Mini-Bar', 4, 'Mer', 43, false, NULL);

-- Coastal Escapes - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (35, '301', 190.00, 'TV, Air Conditionné', 1, 'Mer', 30, false, NULL),
       (35, '302', 230.00, 'TV, Mini-Bar', 2, 'Montagne', 35, true, NULL),
       (35, '303', 270.00, 'TV, Air Conditionné', 3, 'Mer', 39, false, NULL),
       (35, '304', 310.00, 'TV, Air Conditionné', 3, 'Montagne', 37, true, NULL),
       (35, '305', 380.00, 'TV, Mini-Bar', 4, 'Mer', 44, false, NULL);

-- Coastal Escapes - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (36, '401', 200.00, 'TV, Air Conditionné', 1, 'Mer', 31, false, NULL),
       (36, '402', 240.00, 'TV, Mini-Bar', 2, 'Montagne', 36, true, NULL),
       (36, '403', 280.00, 'TV, Air Conditionné', 3, 'Mer', 40, false, NULL),
       (36, '404', 320.00, 'TV, Air Conditionné', 3, 'Montagne', 38, true, NULL),
       (36, '405', 400.00, 'TV, Mini-Bar', 4, 'Mer', 45, false, NULL);

-- Coastal Escapes - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (37, '501', 210.00, 'TV, Air Conditionné', 1, 'Mer', 32, false, NULL),
       (37, '502', 250.00, 'TV, Mini-Bar', 2, 'Montagne', 37, true, NULL),
       (37, '503', 290.00, 'TV, Air Conditionné', 3, 'Mer', 41, false, NULL),
       (37, '504', 340.00, 'TV, Air Conditionné', 3, 'Montagne', 39, true, NULL),
       (37, '505', 420.00, 'TV, Mini-Bar', 4, 'Mer', 46, false, NULL);

-- Coastal Escapes - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (38, '601', 220.00, 'TV, Air Conditionné', 1, 'Mer', 33, false, NULL),
       (38, '602', 260.00, 'TV, Mini-Bar', 2, 'Montagne', 38, true, NULL),
       (38, '603', 300.00, 'TV, Air Conditionné', 3, 'Mer', 42, false, NULL),
       (38, '604', 340.00, 'TV, Air Conditionné', 3, 'Montagne', 40, true, NULL),
       (38, '605', 420.00, 'TV, Mini-Bar', 4, 'Mer', 45, false, NULL);

-- Coastal Escapes - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (39, '701', 230.00, 'TV, Air Conditionné', 1, 'Mer', 34, false, NULL),
       (39, '702', 270.00, 'TV, Mini-Bar', 2, 'Montagne', 39, true, NULL),
       (39, '703', 310.00, 'TV, Air Conditionné', 3, 'Mer', 43, false, NULL),
       (39, '704', 360.00, 'TV, Air Conditionné', 3, 'Montagne', 41, true, NULL),
       (39, '705', 440.00, 'TV, Mini-Bar', 4, 'Mer', 46, false, NULL);

-- Coastal Escapes - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, superficie, etendre, dommages) 
VALUES (40, '801', 240.00, 'TV, Air Conditionné', 1, 'Mer', 35, false, NULL),
       (40, '802', 280.00, 'TV, Mini-Bar', 2, 'Montagne', 40, true, NULL),
       (40, '803', 320.00, 'TV, Air Conditionné', 3, 'Mer', 44, false, NULL),
       (40, '804', 370.00, 'TV, Air Conditionné', 3, 'Montagne', 42, true, NULL),
       (40, '805', 450.00, 'TV, Mini-Bar', 4, 'Mer', 47, false, NULL);
