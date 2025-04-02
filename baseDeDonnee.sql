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
    INSERT INTO Location (booking_id, client_id, l_date)
    VALUES (NEW.booking_id, NEW.client_id, CURRENT_DATE);
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


