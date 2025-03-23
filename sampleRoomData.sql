--Données pour les chambres d'hotels individuelles

--Elite Suites Hotels
-- Elite Suites - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (1, '101', 150.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (1, '102', 250.00, 'TV, Air Conditionné, Réfrigérateur', 2, 'Mer', true, NULL),
       (1, '103', 300.00, 'TV, Air Conditionné, Mini-Bar', 3, 'Mer', false, NULL),
       (1, '104', 350.00, 'TV, Air Conditionné', 2, 'Montagne', false, NULL),
       (1, '105', 500.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', true, NULL);

-- Elite Suites - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (2, '201', 200.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (2, '202', 270.00, 'TV, Air Conditionné', 2, 'Mer', true, NULL),
       (2, '203', 350.00, 'TV, Air Conditionné', 3, 'Montagne', false, NULL),
       (2, '204', 420.00, 'TV, Air Conditionné, Mini-Bar', 4, 'Mer', false, NULL),
       (2, '205', 500.00, 'TV, Air Conditionné, Réfrigérateur', 5, 'Mer', true, NULL);

-- Elite Suites - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (3, '301', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (3, '302', 230.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (3, '303', 280.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (3, '304', 330.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Mer', true, NULL),
       (3, '305', 400.00, 'TV, Air Conditionné, Balcon', 4, 'Montagne', false, NULL);

-- Elite Suites - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (4, '401', 170.00, 'TV, Réfrigérateur', 1, 'Montagne', false, NULL),
       (4, '402', 220.00, 'TV, Air Conditionné', 2, 'Mer', true, NULL),
       (4, '403', 290.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (4, '404', 360.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', false, NULL),
       (4, '405', 460.00, 'TV, Air Conditionné, Balcon', 5, 'Mer', true, NULL);

-- Elite Suites - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (5, '501', 180.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (5, '502', 240.00, 'TV, Air Conditionné, Mini-Bar', 2, 'Montagne', true, NULL),
       (5, '503', 310.00, 'TV, Réfrigérateur', 3, 'Mer', false, NULL),
       (5, '504', 370.00, 'TV, Air Conditionné, Réfrigérateur', 4, 'Montagne', true, NULL),
       (5, '505', 450.00, 'TV, Mini-Bar, Balcon', 5, 'Mer', false, NULL);

-- Elite Suites - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (6, '601', 200.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (6, '602', 270.00, 'TV, Air Conditionné, Mini-Bar', 2, 'Mer', true, NULL),
       (6, '603', 320.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Mer', false, NULL),
       (6, '604', 380.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (6, '605', 470.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL);

-- Elite Suites - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (7, '701', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (7, '702', 250.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (7, '703', 300.00, 'TV, Réfrigérateur', 3, 'Mer', false, NULL),
       (7, '704', 370.00, 'TV, Air Conditionné, Mini-Bar', 3, 'Montagne', true, NULL),
       (7, '705', 450.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL);

-- Elite Suites - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (8, '801', 180.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (8, '802', 230.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL),
       (8, '803', 280.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', false, NULL),
       (8, '804', 340.00, 'TV, Air Conditionné', 3, 'Mer', true, NULL),
       (8, '805', 420.00, 'TV, Air Conditionné, Balcon', 5, 'Mer', false, NULL);

--Budget Stay Hotels

-- Budget Stay - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (9, '101', 100.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (9, '102', 120.00, 'TV, Réfrigérateur', 2, 'Mer', true, NULL),
       (9, '103', 150.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (9, '104', 180.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (9, '105', 200.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (10, '201', 110.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (10, '202', 140.00, 'TV, Réfrigérateur', 2, 'Mer', true, NULL),
       (10, '203', 170.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (10, '204', 200.00, 'TV, Mini-Bar', 3, 'Montagne', true, NULL),
       (10, '205', 250.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (11, '301', 100.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (11, '302', 140.00, 'TV, Réfrigérateur', 2, 'Montagne', true, NULL),
       (11, '303', 180.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (11, '304', 210.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (11, '305', 250.00, 'TV, Réfrigérateur', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (12, '401', 120.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (12, '402', 150.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL),
       (12, '403', 180.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (12, '404', 210.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', true, NULL),
       (12, '405', 230.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (13, '501', 130.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (13, '502', 160.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (13, '503', 190.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (13, '504', 220.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (13, '505', 250.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (14, '601', 140.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (14, '602', 170.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL),
       (14, '603', 200.00, 'TV, Air Conditionné', 3, 'Montagne', false, NULL),
       (14, '604', 230.00, 'TV, Air Conditionné', 3, 'Mer', true, NULL),
       (14, '605', 260.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (15, '701', 110.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (15, '702', 140.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (15, '703', 190.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (15, '704', 210.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', true, NULL),
       (15, '705', 250.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Budget Stay - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (16, '801', 120.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (16, '802', 150.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (16, '803', 180.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (16, '804', 200.00, 'TV, Air Conditionné, Réfrigérateur', 3, 'Montagne', true, NULL),
       (16, '805', 240.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);


--Green Gateways Hotels
-- Green Getaways - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (17, '101', 140.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (17, '102', 170.00, 'TV, Réfrigérateur', 2, 'Mer', true, NULL),
       (17, '103', 200.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (17, '104', 230.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (17, '105', 280.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (18, '201', 150.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (18, '202', 180.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (18, '203', 220.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (18, '204', 260.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (18, '205', 300.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (19, '301', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (19, '302', 200.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (19, '303', 250.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (19, '304', 290.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (19, '305', 350.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (20, '401', 140.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (20, '402', 170.00, 'TV, Air Conditionné', 2, 'Mer', true, NULL),
       (20, '403', 220.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (20, '404', 260.00, 'TV, Mini-Bar', 3, 'Montagne', true, NULL),
       (20, '405', 310.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (21, '501', 170.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (21, '502', 210.00, 'TV, Air Conditionné', 2, 'Montagne', true, NULL),
       (21, '503', 250.00, 'TV, Mini-Bar', 3, 'Mer', false, NULL),
       (21, '504', 290.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (21, '505', 350.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (22, '601', 150.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (22, '602', 180.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL),
       (22, '603', 220.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (22, '604', 260.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (22, '605', 300.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (23, '701', 180.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (23, '702', 210.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (23, '703', 240.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (23, '704', 280.00, 'TV, Mini-Bar', 3, 'Montagne', true, NULL),
       (23, '705', 350.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Green Getaways - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (24, '801', 190.00, 'TV, Air Conditionné', 1, 'Montagne', false, NULL),
       (24, '802', 230.00, 'TV, Mini-Bar', 2, 'Mer', true, NULL),
       (24, '803', 260.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (24, '804', 300.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (24, '805', 380.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);


-- Royal Resorts Hotels
-- Royal Resorts - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (25, '101', 200.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (25, '102', 240.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (25, '103', 300.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (25, '104', 350.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (25, '105', 400.00, 'TV, Air Conditionné, Balcon', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (26, '201', 220.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (26, '202', 260.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (26, '203', 320.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (26, '204', 370.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (26, '205', 450.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (27, '301', 210.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (27, '302', 250.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (27, '303', 280.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (27, '304', 330.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (27, '305', 400.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (28, '401', 230.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (28, '402', 280.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (28, '403', 320.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (28, '404', 380.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (28, '405', 450.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (29, '501', 200.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (29, '502', 240.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (29, '503', 300.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (29, '504', 350.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (29, '505', 420.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (30, '601', 210.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (30, '602', 250.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (30, '603', 290.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (30, '604', 340.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (30, '605', 400.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (31, '701', 230.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (31, '702', 270.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (31, '703', 320.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (31, '704', 380.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (31, '705', 450.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Royal Resorts - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (32, '801', 220.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (32, '802', 260.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (32, '803', 300.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (32, '804', 350.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (32, '805', 420.00, 'TV, Air Conditionné', 4, 'Mer', false, NULL);


-- Coastal Escape Hotels

-- Coastal Escapes - Hotel 1
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (33, '101', 160.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (33, '102', 190.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (33, '103', 240.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (33, '104', 280.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (33, '105', 350.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 2
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (34, '201', 180.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (34, '202', 220.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (34, '203', 260.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (34, '204', 300.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (34, '205', 380.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 3
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (35, '301', 190.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (35, '302', 230.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (35, '303', 270.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (35, '304', 310.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (35, '305', 380.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 4
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (36, '401', 200.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (36, '402', 240.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (36, '403', 280.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (36, '404', 320.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (36, '405', 400.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 5
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (37, '501', 210.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (37, '502', 250.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (37, '503', 290.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (37, '504', 340.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (37, '505', 420.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 6
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (38, '601', 220.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (38, '602', 260.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (38, '603', 300.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (38, '604', 340.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (38, '605', 420.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 7
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (39, '701', 230.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (39, '702', 270.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (39, '703', 310.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (39, '704', 360.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (39, '705', 440.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);

-- Coastal Escapes - Hotel 8
INSERT INTO Chambre (hotel_id, numero_chambre, prix, commodites, capacite, vue, etendre, dommages) 
VALUES (40, '801', 240.00, 'TV, Air Conditionné', 1, 'Mer', false, NULL),
       (40, '802', 280.00, 'TV, Mini-Bar', 2, 'Montagne', true, NULL),
       (40, '803', 320.00, 'TV, Air Conditionné', 3, 'Mer', false, NULL),
       (40, '804', 370.00, 'TV, Air Conditionné', 3, 'Montagne', true, NULL),
       (40, '805', 450.00, 'TV, Mini-Bar', 4, 'Mer', false, NULL);
