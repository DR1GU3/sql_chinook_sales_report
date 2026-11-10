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

--4. Requête affichant uniquement les employés qui sont des Agents de Vente

select *
FROM Employee 
WHERE Title = "Sales Support Agent";

--5. Requête affichant une liste UNIQUE des pays de facturation présents dans la table Invoice

select DISTINCT BillingCountry
FROM Invoice;
