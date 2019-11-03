use publications;
## Challenge 1 - Most Profiting Authors
### Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
SELECT t.title_id,
a.au_id,
t.advance * ta.royaltyper / 100 as advance,
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id;

### Step 2: Aggregate the total royalties for each title and author
SELECT t.title_id,
a.au_id,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id;

### Step 3: Calculate the total profits of each author
SELECT a.au_id, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance * ta.royaltyper / 100 AS profits
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY a.au_id;

## Challenge 2 - Alternative Solution
# STEP 1
CREATE TEMPORARY TABLE RoyaltyCalc
SELECT t.title_id,
a.au_id,
t.advance * ta.royaltyper / 100 as advance,
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id;

SELECT * 
FROM RoyaltyCalc;

### Step 2: Aggregate the total royalties for each title and author
CREATE TEMPORARY TABLE AggRoy
SELECT t.title_id,
a.au_id,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id;

SELECT * FROM AggRoy;

### Step 3: Calculate the total profits of each author
CREATE TEMPORARY TABLE totalprof
SELECT a.au_id, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance * ta.royaltyper / 100 AS profits
FROM titles t
JOIN titleauthor ta on t.title_id = ta.title_id
JOIN sales s on t.title_id = s.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY a.au_id;

SELECT * FROM totalprof;

# CHALLENGE 3:
CREATE TABLE TopAuthors
SELECT *
FROM totalprof
ORDER BY profits DESC;

SELECT *
FROM TopAuthors;