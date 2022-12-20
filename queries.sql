-- Find all animals whose name ends in "mon".

SELECT * from animals where name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals where escape_attempts < 3 AND neutered =true;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals where name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals where neutered =true;

-- Find all animals not named Gabumon..
SELECT * from animals where name!='Gabumon.' ;

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals where weight_kg>=10.4 AND weight_kg<=17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT species FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL ;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;


-- delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. 
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals SET weight_kg = -weight_kg WHERE weight_kg < 0;
COMMIT;  -- Commit transaction

-- How many animals are there?
SELECT * FROM animals;

-- How many animals have never tried to escape?
SELECT * FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;


-- Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT MAX(weight_kg) FROM animals;
SELECT MIN(weight_kg) FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31';


-- Write queries (using JOIN) to answer the following questions

SELECT name, full_name FROM animals INNER JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name, animals.name, species.name FROM animals INNER JOIN owners ON animals.id = owners_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = '0';

SELECT owners.full_name, COUNT(*) FROM animals INNER JOIN owners ON animals.id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;

--day 4
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = '1' ORDER BY visits.date_of_visit desc limit 1;
SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vet_id = '2';
SELECT vets.name, specializations.vet_id, specializations.species_id FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id;
SELECT animals.name , visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vet_id = '3';
SELECT animals.name, COUNT(animal_id) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(animal_id) desc limit 1;
SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = '2'ORDER BY visits.date_of_visit ASC LIMIT '1';
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);
 SELECT *, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);
SELECT COUNT(visits.animal_id) FROM visits JOIN vets ON vets.id = visits.vet_id WHERE vet_id = '2';
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Vet Maisy Smith' GROUP BY species.name ORDER BY COUNT(animals.species_id) desc limit 1;
SELECT full_name, COUNT(owner_id) FROM owners JOIN animals on owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT (owner_id) desc limit 1;

-----------------------------------------------------------------------


explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

explain analyse SELECT * FROM visits where vet_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';