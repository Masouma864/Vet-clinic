/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species varchar(100),
);


CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY,
    full_name varchar(100),
    age integer
);

CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY,
    name varchar(100)
);

CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name varchar(100),
    age integer,
    date_of_graduation date
);

-- add species and owner to animal table,

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owners_id INT;

-- reference owner and species into animals

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id) REFERENCES owners(id);