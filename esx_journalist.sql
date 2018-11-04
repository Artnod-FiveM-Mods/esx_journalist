USE `essentialmode`;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('journalist', 'Weazel News', 0)
;
INSERT INTO `datastore` (name, label, shared) VALUES
	('society_weazel', 'Weasel News', 1)
;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_weazel', 'Weasel News', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_weazel', 'Weasel News', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('journalist', 0, 'interim', 'Livreur', 100, '{}', '{}'),
	('journalist', 1, 'journalist', 'Journaliste', 100, '{}', '{}'),
	('journalist', 2, 'reporter', 'Reporter', 100, '{}', '{}'),
	('journalist', 3, 'chief', 'RÃ©dacteur en chef', 100, '{}', '{}'),
	('journalist', 4, 'boss'  , 'Patron', 100, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('journal', 'Journal', 50, 0, 1),
	('journaux', 'Sac de Journaux', 5, 0, 1)
;
