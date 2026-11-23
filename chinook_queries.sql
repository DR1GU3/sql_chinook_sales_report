-- Projet SQL Chinnok : requêtes

--1.  Requête affichant les clients (leurs noms complets, ID client et pays)  non originaires des USA

select FirstName || ' ' || LastName AS FullName,
	   CustomerId,
       Country
FROM Customer 
WHERE Country != "USA";

--2. Requête affichant uniquement les clients originaire du Brésil

select *
FROM Customer 
WHERE Country = "Brazil";

--3. Requête affichant les factures des clients originaires du Brésil
--3.1. Ma réponse qui marche très bien

select FirstName, LastName, InvoiceId, InvoiceDate, BillingCountry
FROM Customer, Invoice
WHERE Customer.CustomerId == Invoice.CustomerId AND Country == "Brazil";

--3.2. Une requête mieux adaptée (INNER JOIN) après correction

select FirstName || ' ' || LastName AS FullName, 
       InvoiceId, 
	   InvoiceDate, 
	   BillingCountry
FROM Customer
INNER JOIN Invoice
ON Customer.CustomerId == Invoice.CustomerId
WHERE Country == "Brazil";

--4. Requête affichant uniquement les employés qui sont des Agents de Vente

select *
FROM Employee 
WHERE Title = "Sales Support Agent";

--5. Requête affichant une liste UNIQUE des pays de facturation présents dans la table Invoice

select DISTINCT BillingCountry
FROM Invoice;

--6. Requête affichant les factures associées à chaque agent de vente.

SELECT Employee.FirstName || ' ' || Employee.LastName AS FullName,
	   Invoice.*
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId;

--7. Requête affichant le total de chaque facture, le nom du client, le pays et le nom de l'agent de vente

SELECT Customer.FirstName || ' ' || Customer.LastName AS Customer_FullName,
	   Customer.Country,
	   Employee.FirstName || ' ' || Employee.LastName AS SalesSuppAgent_FullName,
	   Invoice.Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId;

--8. Requête affichant le nombre de factures en 2021 et 2023 et les montants totaux des ventes pour chacune de ces années

SELECT strftime('%Y', InvoiceDate) AS Year,
       COUNT(*) AS NbInvoice,
	   SUM(Invoice.Total) AS TotalSales
FROM Invoice 
WHERE strftime('%Y', InvoiceDate) IN ('2021' , '2023')
GROUP BY Year;

--9. Requête affichant le nombre nombre d'articles (line items) pour l'ID de facture 37

SELECT COUNT(*) AS NbLinesItem
FROM InvoiceLine
WHERE InvoiceId = 37;

--10. Requête affichant le nombre d'articles (line items) pour chaque facture

SELECT 	InvoiceId,
        COUNT(*) AS NbLinesItem
FROM InvoiceLine
GROUP BY InvoiceId;

--11. Requête incluant le nom du morceau pour chaque ligne de facture

SELECT 	InvoiceLine.*,
		Track.Name AS NomMorceau
FROM InvoiceLine
INNER JOIN Track ON InvoiceLine.TrackId = Track.TrackId;
