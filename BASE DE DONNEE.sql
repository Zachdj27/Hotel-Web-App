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
    hotel_id SERIAL PRIMARY KEY,
    chain_id INT REFERENCES Chaine_hoteliere(chain_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    adresse TEXT,
    numero_telephone VARCHAR(20),
    email VARCHAR(100),
    classement INT CHECK (classement BETWEEN 1 AND 5)
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
    etendre BOOLEAN DEFAULT FALSE,
    dommages TEXT
);

-- Table Employee
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    NAS VARCHAR(20) UNIQUE NOT NULL,
    nom_complet VARCHAR(255) NOT NULL,
    adresse TEXT,
    poste VARCHAR(100)
);

--  Relation "TravailleDans" (N:M entre Employee et Hotel)
CREATE TABLE TravailleDans (
    employee_id INT REFERENCES Employee(employee_id) ON DELETE CASCADE,
    hotel_id INT REFERENCES Hotel(hotel_id) ON DELETE CASCADE,
    PRIMARY KEY (employee_id, hotel_id)
);


--  Table Client
CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    NAS VARCHAR(20) UNIQUE NOT NULL,
    nom_complet VARCHAR(255) NOT NULL,
    adresse TEXT,
    date_enregistrement DATE DEFAULT CURRENT_DATE
);

--  Table Booking (Réservation)
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(client_id) ON DELETE CASCADE,
    r_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Réservé', 'Confirmé', 'Annulé'))
);

--  Relation "Booking_Chambre" (N:M entre Booking et Chambre)
CREATE TABLE Booking_Chambre (
    booking_id INT REFERENCES Booking(booking_id) ON DELETE SET NULL,
    room_id INT REFERENCES Chambre(room_id) ON DELETE CASCADE,
    PRIMARY KEY (booking_id, room_id),
    UNIQUE (booking_id, room_id)
);

--  Table Location (Lorsqu’un client enregistre sa réservation)
CREATE TABLE Location (
    location_id SERIAL PRIMARY KEY,
    booking_id  INT  UNIQUE NULL, --Permettre location sans réservation
    client_id INT REFERENCES Client(client_id) ON DELETE CASCADE,
    l_date DATE DEFAULT CURRENT_DATE,
	FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);


--  Table Paiement (Transaction enregistrée par un employé)
CREATE TABLE Paiement (
    paiement_id SERIAL PRIMARY KEY,
    location_id INT REFERENCES Location(location_id) ON DELETE CASCADE,
    employee_id INT REFERENCES Employee(employee_id) ON DELETE CASCADE,
    montant DECIMAL(10,2) NOT NULL,
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--  Index pour optimiser les requêtes SQL
CREATE INDEX idx_hotel_chain ON Hotel(chain_id);
CREATE INDEX idx_room_price ON Chambre(prix);
CREATE INDEX idx_booking_client ON Booking(client_id);
