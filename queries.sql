SELECT * FROM contacts;
SELECT * FROM category;
SELECT * FROM subcategory;
SELECT * FROM campaign;
SELECT * FROM backers;

CREATE TABLE "backers" (
    "backer_id" varchar(5)   NOT NULL,
	"cf_id" int NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_backers" PRIMARY KEY (
        "backer_id"
     )
);

SELECT cmp.backers_count, cmp.cf_id, cmp.outcome
FROM campaign as cmp
WHERE (cmp.outcome = 'live')
ORDER BY cmp.backers_count DESC;

SELECT COUNT (bk.cf_id), bk.cf_id
FROM backers as bk
GROUP BY bk.cf_id
ORDER BY COUNT(bk.cf_id) DESC;

SELECT cn.first_name, cn.last_name, cn.email, (cmp.goal - cmp.pledged) as remaining_goal_amount 
INTO email_contacts_remaining_goal_amount
FROM campaign as cmp
INNER JOIN contacts as cn
ON (cmp.contact_id = cn.contact_id)
WHERE (cmp.outcome = 'live')
ORDER BY remaining_goal_amount DESC;

SELECT * 
FROM email_contacts_remaining_goal_amount;

SELECT bk.email, bk.first_name, bk.last_name, cmp.cf_id, cmp.company_name, cmp.description, (cmp.goal - cmp.pledged) as left_of_goal 
INTO email_backers_remaining_goal_amount
FROM campaign as cmp
INNER JOIN backers as bk
ON (cmp.cf_id = bk.cf_id)
WHERE (cmp.outcome = 'live')
ORDER BY bk.last_name, bk.email;

SELECT *
FROM email_backers_remaining_goal_amount;