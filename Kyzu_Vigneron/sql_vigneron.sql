INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_vigneron','Vigneron',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_vigneron','Vigneron',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_vigneron', 'Vigneron', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('vigneron', 'Vigneron', 1);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('vigneron',0,'recrue','Vendangeur',400,'{}','{}'),
  ('vigneron',1,'gerant','Chef de rang',650,'{}','{}'),
  ('vigneron',2,'boss','Vigneron',800,'{}','{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
  ('raisin', 'Raisin', 1, 0, 1),
  ('vin', 'Vin', 1, 0, 1);