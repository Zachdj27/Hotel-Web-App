--Example de requêtes
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

