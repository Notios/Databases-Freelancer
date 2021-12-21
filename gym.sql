-- Gym Management System Database Design
-- Microsoft Jet SQL

-- Queries --

-- Not active members
SELECT Customers.[Κωδικός Πελάτη], Customers.Επώνυμο, Customers.Όνομα, Customers.Διεύθυνση, Customers.[Ημερομηνία Γέννησης], Customers.[Τηλέφωνο οικίας], Customers.[Κινητό τηλέφωνο], Customers.[e-mail], Customers.[Ημερομηνία Εγγραφής], Customers.[Ημερομηνία Λήξης], Customers.Πακέτο, Customers.Ανενεργοί, Customers.Φύλο, Customers.[Από που]
FROM Customers
WHERE (((Customers.Ανενεργοί)=Yes));

-- Check valid email address
SELECT Customers.Επώνυμο, Customers.Όνομα, Customers.[e-mail], Customers.Ανενεργοί
FROM Customers
WHERE (((Customers.[e-mail]) Like "*@*.*"));

-- Check valid mobile phone number from Greece
SELECT Customers.Όνομα, Customers.Επώνυμο, Customers.[Κινητό τηλέφωνο], Customers.Ανενεργοί, Customers.[Ημερομηνία Λήξης]
FROM Customers
WHERE (((Customers.[Κινητό τηλέφωνο]) Like "??????????" And (Customers.[Κινητό τηλέφωνο]) Like "69*") AND ((Customers.Ανενεργοί)=Yes) AND ((Customers.[Ημερομηνία Λήξης])<=#6/30/2016#));

-- Birthday Campaign
SELECT Customers.[e-mail], Customers.Επώνυμο, Customers.Όνομα, Customers.[Κινητό τηλέφωνο], Customers.[Κωδικός Πελάτη], Customers.[Ημερομηνία Γέννησης], Customers.[e-mail]
FROM Customers
WHERE (((Customers.[e-mail]) Like "*@*.*") AND ((Month([Ημερομηνία Γέννησης]))=Month(Date())) AND ((Day([Ημερομηνία Γέννησης]))=Day(Date())));

-- Trial to Subscribe
SELECT Δοκιμαστικά.ID, Δοκιμαστικά.Όνομα, Δοκιμαστικά.Επώνυμο, Δοκιμαστικά.Τηλέφωνο, Δοκιμαστικά.[Ημερομηνία Προσεύλευσης], Δοκιμαστικά.Mail, Δοκιμαστικά.[Έγιναν μέλη στο Eleven], Δοκιμαστικά.ΗΜΕΡΟΜΗΝΙΑ
FROM Δοκιμαστικά
WHERE (((Δοκιμαστικά.Mail) Is Not Null) AND ((Δοκιμαστικά.[Έγιναν μέλη στο Eleven])=No));

-- Back to Gym
SELECT Δοκιμαστικά.ID, Δοκιμαστικά.Όνομα, Δοκιμαστικά.Επώνυμο, Δοκιμαστικά.Mail, Δοκιμαστικά.[Έγιναν μέλη στο Eleven], Δοκιμαστικά.Τηλέφωνο
FROM Δοκιμαστικά
WHERE (((Δοκιμαστικά.Mail) Is Not Null) AND ((Δοκιμαστικά.[Έγιναν μέλη στο Eleven])=No) AND ((Δοκιμαστικά.Τηλέφωνο) Is Not Null And (Δοκιμαστικά.Τηλέφωνο) Like "69*"));

-- Campaign to Subscription Renewal
SELECT Customers.[Κωδικός Πελάτη], Customers.Επώνυμο, Customers.Όνομα, Customers.[Ημερομηνία Λήξης], Customers.Ανενεργοί, Customers.Πακέτο, Customers.[e-mail], Customers.[Κινητό τηλέφωνο]
FROM Customers
WHERE (((Customers.[Ημερομηνία Λήξης])<=Date()-150) AND ((Customers.Ανενεργοί)=No))
ORDER BY Customers.[Ημερομηνία Λήξης];

-- Subscriptions expire
SELECT Customers.[Κωδικός Πελάτη], Customers.Επώνυμο, Customers.Όνομα, Customers.[Κινητό τηλέφωνο], Customers.[Ημερομηνία Λήξης], Customers.Ανενεργοί, Customers.Blogger
FROM Customers
WHERE (((Customers.[Ημερομηνία Λήξης])<Date()+20) AND ((Customers.Blogger)=No))
ORDER BY Customers.[Ημερομηνία Λήξης];

-- Sales
SELECT Customers.Πακέτο, Count(Customers.Πακέτο) AS ΠλήθοςΤουΠακέτο, Customers.[Ημερομηνία Λήξης]
FROM Customers
GROUP BY Customers.Πακέτο, Customers.[Ημερομηνία Λήξης]
HAVING (((Customers.[Ημερομηνία Λήξης])>=#5/19/2018#));
