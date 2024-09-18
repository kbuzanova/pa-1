create database Practical_assignment_1

use Practical_assignment_1



create table owners 
(
	owner_id int auto_increment primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	phone varchar(15),
	email varchar(50)
);

create table patients
( 
	pet_id int auto_increment primary key,
	pet_name varchar(50) not null, 
	pet_species varchar(50) not null,
	breed varchar(50),
	age int not null,
	owner_id int, 
	foreign key (owner_id) references owners (owner_id)
);

create table vets 
(
	vet_id int auto_increment primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null 
);

create table appointments
(
	appointment_id int auto_increment primary key,
	pet_id int,
	vet_id int,
	appointment_date date,
	diagnosis text,
	foreign key (pet_id) references patients (pet_id),
	foreign key (vet_id) references vets (vet_id)
);

create table treatment 
(
	treatment_id int auto_increment primary key,
	appointment_id int,
	treatment_name varchar(100),
	cost decimal(5, 2),
	notes text,
	foreign key (appointment_id) references appointments (appointment_id)
);



INSERT INTO owners (first_name, last_name, phone, email)
VALUES
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
    ('Emily', 'Smith', '234-567-8901', 'emily.smith@example.com'),
    ('Michael', 'Johnson', '345-678-9012', 'michael.johnson@example.com'),
    ('Laura', 'Williams', '456-789-0123', 'laura.williams@example.com'),
    ('David', 'Brown', '567-890-1234', 'david.brown@example.com');

INSERT INTO patients (pet_name, pet_species, breed, age, owner_id)
VALUES
    ('Buddy', 'Dog', 'Golden Retriever', 3, 1),
    ('Whiskers', 'Cat', 'Persian', 5, 2),
    ('Max', 'Dog', 'Beagle', 2, 3),
    ('Bella', 'Dog', 'Labrador', 4, 4),
    ('Milo', 'Cat', 'Siamese', 1, 5);

   
   
INSERT INTO vets (first_name, last_name)
VALUES
    ('Sarah', 'Connor'),
    ('James', 'Miller'),
    ('Emma', 'Davis');

   
   
INSERT INTO appointments (pet_id, vet_id, appointment_date, diagnosis)
VALUES
    (1, 1, '2024-08-01', 'Ear infection'),
    (2, 2, '2024-08-02', 'Fever and dehydration'),
    (3, 3, '2024-08-03', 'Dental issue'),
    (4, 1, '2024-08-04', 'Skin allergy'),
    (5, 2, '2024-08-05', 'Eye infection');

   
   
   
INSERT INTO treatment (appointment_id, treatment_name, cost, notes)
VALUES
    (1, 'Antibiotic treatment', 50.00, 'Prescribed antibiotics for 10 days.'),
    (2, 'IV fluids', 75.00, 'Rehydration with IV fluids.'),
    (3, 'Dental cleaning', 100.00, 'Full dental cleaning with sedation.'),
    (4, 'Antihistamines', 40.00, 'Antihistamines prescribed for allergies.'),
    (5, 'Eye drops', 30.00, 'Prescribed eye drops for daily use.');
   
   
   
select 
	o.first_name as owner_first_name,
    	o.last_name as owner_last_name,
    	p.pet_name,
    	v.first_name as vet_first_name,
    	v.last_name as vet_last_name,
    	a.appointment_date,
    	t.treatment_name,
    	t.cost
from
    patients p 
join
    owners o on p.owner_id = o.owner_id
join 
    appointments a on p.pet_id = a.pet_id
join 
    vets v on a.vet_id = v.vet_id
join 
    treatment t on a.appointment_id = t.appointment_id
where
    t.cost > 50
group by
    o.first_name, o.last_name, p.pet_name, v.first_name, v.last_name, a.appointment_date, t.treatment_name, t.cost
order by
    a.appointment_date asc, t.cost asc;

   

   
   
with AppointmentDetails as (
    select
        o.first_name as owner_first_name,
        o.last_name as owner_last_name,
        p.pet_name,
        v.first_name as vet_first_name,
        v.last_name as vet_last_name,
        a.appointment_date,
        t.treatment_name,
        t.cost
    from
        patients p
    join
        owners o on p.owner_id = o.owner_id
    join 
        appointments a on p.pet_id = a.pet_id
    join 
        vets v on a.vet_id = v.vet_id
    join 
        treatment t on a.appointment_id = t.appointment_id
    where
        t.cost > 50
)
select *
from AppointmentDetails
group by
    owner_first_name, owner_last_name, pet_name, vet_first_name, vet_last_name, appointment_date, treatment_name, cost
order by
    appointment_date asc, cost asc;
   
create table old_patients
( 
	pet_id int auto_increment primary key,
	pet_name varchar(50) not null, 
	pet_species varchar(50) not null,
	breed varchar(50),
	age int not null,
	owner_id int, 
	foreign key (owner_id) references owners (owner_id)
);



INSERT INTO old_patients (pet_name, pet_species, breed, age, owner_id)
VALUES
    ('Buddy', 'Dog', 'Golden Retriever', 3, 1),
    ('Whiskers', 'Cat', 'Persian', 5, 2),
    ('Max', 'Dog', 'Beagle', 2, 3),
    ('Bella', 'Dog', 'Labrador', 4, 4),
    ('Milo', 'Cat', 'Siamese', 1, 5);
   
   
INSERT INTO old_patients (pet_name, pet_species, breed, age, owner_id)
VALUES
    ('Luna', 'Cat', 'Maine Coon', 2, 1),
    ('Charlie', 'Dog', 'Bulldog', 4, 2),
    ('Daisy', 'Rabbit', 'Lop', 3, 3),
    ('Oscar', 'Dog', 'Poodle', 6, 4),
    ('Coco', 'Parrot', 'African Grey', 7, 5),
    ('Max', 'Dog', 'German Shepherd', 5, 1),
    ('Nala', 'Cat', 'Bengal', 1, 2),
    ('Buddy', 'Dog', 'Cocker Spaniel', 3, 3),
    ('Simba', 'Cat', 'Sphynx', 4, 4),
    ('Bella', 'Dog', 'Shih Tzu', 2, 5);
   
   
select pet_name 
from patients 
union all
select pet_name 
from old_patients
   
