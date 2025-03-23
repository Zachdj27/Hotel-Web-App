-- Hotel Chains
INSERT INTO Chaine_hoteliere (name, adresse_bureau, nombre_hotels, email)
VALUES
('Elite Suites', '123 Prestige Ave, City, Country', 8, 'contact@elitesuites.com'),
('Budget Stay', '456 Affordable St, City, Country', 8, 'info@budgetstay.com'),
('Green Getaways', '789 Eco Blvd, City, Country', 8, 'support@greengeaways.com'),
('Royal Resorts', '101 Royal Rd, City, Country', 8, 'hello@royalresorts.com'),
('Coastal Escapes', '202 Beachfront Dr, City, Country', 8, 'reservations@coastalescapes.com');

-- Hotels
-- Chain 1: Elite Suites
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement)
VALUES
(1, 'Elite Suites Downtown', '101 City St, City, Country', '123-001-2345', 'downtown@elitesuites.com', 5),
(1, 'Elite Suites Beachfront', '202 Ocean Blvd, City, Country', '123-001-2346', 'beachfront@elitesuites.com', 5),
(1, 'Elite Suites Garden', '303 Park Ave, City, Country', '123-001-2347', 'garden@elitesuites.com', 4),
(1, 'Elite Suites Hilltop', '404 Hillside Rd, City, Country', '123-001-2348', 'hilltop@elitesuites.com', 4),
(1, 'Elite Suites Mountain', '505 Summit Ave, City, Country', '123-001-2349', 'mountain@elitesuites.com', 5),
(1, 'Elite Suites Cityview', '606 City View Rd, City, Country', '123-001-2350', 'cityview@elitesuites.com', 3),
(1, 'Elite Suites Seaside', '707 Beach Rd, City, Country', '123-001-2351', 'seaside@elitesuites.com', 4),
(1, 'Elite Suites Countryside', '808 Countryside Ave, City, Country', '123-001-2352', 'countryside@elitesuites.com', 3);

-- Chain 2: Budget Stay
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement)
VALUES
(2, 'Budget Stay Downtown', '909 Urban St, City, Country', '234-001-2345', 'downtown@budgetstay.com', 2),
(2, 'Budget Stay Cityside', '1010 City View Rd, City, Country', '234-001-2346', 'cityside@budgetstay.com', 2),
(2, 'Budget Stay Highway', '1111 Freeway Rd, City, Country', '234-001-2347', 'highway@budgetstay.com', 1),
(2, 'Budget Stay Riverside', '1212 River St, City, Country', '234-001-2348', 'riverside@budgetstay.com', 2),
(2, 'Budget Stay Coastal', '1313 Shore Blvd, City, Country', '234-001-2349', 'coastal@budgetstay.com', 3),
(2, 'Budget Stay Suburbs', '1414 Suburb Rd, City, Country', '234-001-2350', 'suburbs@budgetstay.com', 1),
(2, 'Budget Stay Urban', '1515 City Blvd, City, Country', '234-001-2351', 'urban@budgetstay.com', 2),
(2, 'Budget Stay Village', '1616 Village Rd, City, Country', '234-001-2352', 'village@budgetstay.com', 3);

-- Chain 3: Green Getaways
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement)
VALUES
(3, 'Green Getaways Forest', '1717 Eco Park Rd, City, Country', '345-001-2345', 'forest@greengeaways.com', 4),
(3, 'Green Getaways River', '1818 Riverbank Ave, City, Country', '345-001-2346', 'river@greengeaways.com', 5),
(3, 'Green Getaways Desert', '1919 Desert Path, City, Country', '345-001-2347', 'desert@greengeaways.com', 3),
(3, 'Green Getaways Jungle', '2020 Jungle Rd, City, Country', '345-001-2348', 'jungle@greengeaways.com', 4),
(3, 'Green Getaways Mountain', '2121 Peak Rd, City, Country', '345-001-2349', 'mountain@greengeaways.com', 5),
(3, 'Green Getaways Lakeside', '2222 Lakeview Ave, City, Country', '345-001-2350', 'lakeside@greengeaways.com', 3),
(3, 'Green Getaways Urban', '2323 Green St, City, Country', '345-001-2351', 'urban@greengeaways.com', 2),
(3, 'Green Getaways Retreat', '2424 Retreat Rd, City, Country', '345-001-2352', 'retreat@greengeaways.com', 4);

-- Chain 4: Royal Resorts
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement)
VALUES
(4, 'Royal Resorts Plaza', '2525 Regal Blvd, City, Country', '456-001-2345', 'plaza@royalresorts.com', 5),
(4, 'Royal Resorts Oceanview', '2626 Shoreline Dr, City, Country', '456-001-2346', 'oceanview@royalresorts.com', 5),
(4, 'Royal Resorts Cityview', '2727 Downtown Ave, City, Country', '456-001-2347', 'cityview@royalresorts.com', 4),
(4, 'Royal Resorts Hillside', '2828 Hills Rd, City, Country', '456-001-2348', 'hillside@royalresorts.com', 4),
(4, 'Royal Resorts Summit', '2929 Mountain Rd, City, Country', '456-001-2349', 'summit@royalresorts.com', 5),
(4, 'Royal Resorts Urban', '3030 Urban St, City, Country', '456-001-2350', 'urban@royalresorts.com', 3),
(4, 'Royal Resorts Parkview', '3131 Park Ave, City, Country', '456-001-2351', 'parkview@royalresorts.com', 4),
(4, 'Royal Resorts Country', '3232 Country Rd, City, Country', '456-001-2352', 'country@royalresorts.com', 3);

-- Chain 5: Coastal Escapes
INSERT INTO Hotel (chain_id, name, adresse, numero_telephone, email, classement)
VALUES
(5, 'Coastal Escapes Sunrise', '3333 Sunrise Dr, City, Country', '567-001-2345', 'sunrise@coastalescapes.com', 4),
(5, 'Coastal Escapes Horizon', '3434 Horizon Blvd, City, Country', '567-001-2346', 'horizon@coastalescapes.com', 5),
(5, 'Coastal Escapes Retreat', '3535 Shore Rd, City, Country', '567-001-2347', 'retreat@coastalescapes.com', 4),
(5, 'Coastal Escapes Island', '3636 Island Rd, City, Country', '567-001-2348', 'island@coastalescapes.com', 5),
(5, 'Coastal Escapes Cityview', '3737 City Blvd, City, Country', '567-001-2349', 'cityview@coastalescapes.com', 3),
(5, 'Coastal Escapes Bayview', '3838 Bay Rd, City, Country', '567-001-2350', 'bayview@coastalescapes.com', 4),
(5, 'Coastal Escapes Urban', '3939 Ocean St, City, Country', '567-001-2351', 'urban@coastalescapes.com', 2),
(5, 'Coastal Escapes Lagoon', '4040 Lagoon Dr, City, Country', '567-001-2352', 'lagoon@coastalescapes.com', 3);
