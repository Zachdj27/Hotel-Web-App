-- 1. Ajouter une réservation pour un client existant
INSERT INTO Booking (client_id, r_date, status) 
VALUES (3, '2025-06-10', 'Réservé');

-- 2. Modifier une réservation (ex: Confirmer une réservation)
UPDATE Booking 
SET status = 'Confirmé' 
WHERE booking_id = 5;

-- 3. Supprimer une réservation annulée
DELETE FROM Booking 
WHERE booking_id = 6 AND status = 'Annulé';

-- 4. Afficher les chambres disponibles d’un hôtel donné
SELECT c.room_id, c.numero_chambre, c.prix, c.capacite, c.vue
FROM Chambre c
LEFT JOIN Booking_Chambre bc ON c.room_id = bc.room_id
LEFT JOIN Booking b ON bc.booking_id = b.booking_id
WHERE c.hotel_id = 2 
AND (b.status IS NULL OR b.status != 'Confirmé');

-- Trigger 1 : Empêcher la double réservation d’une chambre
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Booking_Chambre bc
        JOIN Booking b ON bc.booking_id = b.booking_id
        WHERE bc.room_id = NEW.room_id 
        AND b.r_date = (SELECT r_date FROM Booking WHERE booking_id = NEW.booking_id)
    ) THEN
        RAISE EXCEPTION 'Cette chambre est déjà réservée à cette date.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON Booking_Chambre
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
