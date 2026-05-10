-- Create database
CREATE DATABASE gtm_project;

-- Use database
USE gtm_project;

-- Create leads table
CREATE TABLE leads (
lead_id INT PRIMARY KEY,
company_name VARCHAR(100),
lead_source VARCHAR(50),
industry VARCHAR(50),
status VARCHAR(50)
);

-- Insert lead data
INSERT INTO leads VALUES
(1, 'Tesla', 'Apollo', 'Automotive', 'Qualified'),
(2, 'Nvidia', 'Clay', 'Technology', 'Qualified'),
(3, 'Pauls Pizza', 'Trade Show', 'Food', 'Unqualified'),
(4, 'Walmart', 'Zoominfo', 'Retail', 'Qualified'),
(5, 'Lowes', 'Clay', 'Retail', 'Qualified'),
(6, 'Nicks Nachos', 'Referral', 'Retail', 'Unqualified');

-- View all leads
SELECT *
FROM leads;

-- Count leads by lead source
SELECT lead_source, COUNT(*) AS total_leads
FROM leads
GROUP BY lead_source
ORDER BY total_leads DESC;

-- Create deals table
CREATE TABLE deals(
deal_id INT PRIMARY KEY,
lead_id INT,
amount DECIMAL (10,2),
stage VARCHAR(50),
close_date DATE
);

-- Insert deal data
INSERT INTO deals VALUES
(1, 4, 15000, 'Proposal', '2026-06-17'),
(2, 5, 12050, 'Closed Won', '2026-04-22'),
(3, 2, 30000, 'Discovery', '2026-07-24'),
(4, 1, 19000, 'Closed Won', '2026-04-28');

-- Select companies and their deal amounts
SELECT l.company_name, d.amount, d.stage FROM leads l
JOIN deals d
ON l.lead_id = d.lead_id;

-- Revenue by stage
SELECT stage, SUM(amount) AS total_revenue
FROM deals
GROUP BY stage
ORDER BY total_revenue DESC;

-- Leads with no deals
SELECT l.company_name,
l.lead_source,
l.status
FROM leads l
LEFT JOIN deals d
ON l.lead_id = d.lead_id
WHERE d.deal_id IS NULL;

-- Revenue by lead source
SELECT l.lead_source, SUM(d.amount) AS total_revenue
FROM leads l
JOIN deals d
ON l.lead_id = d.lead_id
GROUP BY l.lead_source
ORDER BY total_revenue DESC;

-- Average deal size by stage
SELECT stage, AVG(amount) AS avg_deal_size
FROM deals
GROUP BY stage
ORDER BY avg_deal_size DESC;

-- Count deals by stage
SELECT stage, COUNT(*) AS total_deals
FROM deals
GROUP BY stage
ORDER BY total_deals DESC;