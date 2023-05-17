--SCHEMA DEFINITION (only PSQL compatible, will fix later)

CREATE ROLE admin  WITH LOGIN SUPERUSER PASSWORD 'password';

create table if not exists FormTemplates();

alter table FormTemplates add column if not exists id bigserial primary key;

alter table FormTemplates add column if not exists name varchar(30);


create table if not exists FormTemplates_questions();

alter table FormTemplates_questions  add column if not exists id bigserial primary key;

alter table FormTemplates_questions  add column if not exists FormTemplates_id bigint references FormTemplates(id);

alter table FormTemplates_questions  add column if not exists question text;





create table if not exists FormTemplates_pollquestions();

alter table FormTemplates_pollquestions  add column if not exists id bigserial primary key;

alter table FormTemplates_pollquestions  add column if not exists FormTemplates_id bigint references FormTemplates(id);

alter table FormTemplates_pollquestions  add column if not exists pollquestion text;


create table if not exists FormTemplates_pollquestions_relations();

alter table FormTemplates_pollquestions_relations  add column if not exists id bigserial primary key;

alter table FormTemplates_pollquestions_relations  add column if not exists pollquestions_id bigint references FormTemplates_pollquestions(id);

alter table FormTemplates_pollquestions_relations  add column if not exists if varchar(10);

alter table FormTemplates_pollquestions_relations  add column if not exists "then" bigint;


create table if not exists Forms();

alter table Forms  add column if not exists id bigserial primary key;

alter table Forms  add column if not exists FormTemplates_id bigint references FormTemplates(id);


create table if not exists Forms_answers();

alter table Forms_answers  add column if not exists id bigserial primary key;

alter table Forms_answers  add column if not exists Forms_id bigint references Forms(id);

alter table Forms_answers  add column if not exists questions_id bigint references FormTemplates_questions(id);

alter table Forms_answers  add column if not exists answer text;


create table if not exists Forms_pollanswers();

alter table Forms_pollanswers  add column if not exists id bigserial primary key;

alter table Forms_pollanswers  add column if not exists Forms_id bigint references Forms(id);

alter table Forms_pollanswers  add column if not exists pollquestions_id bigint references FormTemplates_pollquestions(id);

alter table Forms_pollanswers  add column if not exists answer text;


--MINIMAL DATA IMPORT (not strictly IDEMPOTENT, only PSQL compatible, will fix later)

insert into FormTemplates(id, name) values
(1, 'VehicleInsuranceDeal'),
(2, 'VehicleDeal')
ON CONFLICT (id) DO NOTHING;

insert into FormTemplates_questions(id, FormTemplates_id, question) values
(1, 1, 'name'),
(2, 1, 'duration'),
(3, 1, 'installmentCount'),
(4, 1, 'perInstallmentAmount'),
(5, 1, 'maximumCoverageAmount'),
(6, 1, 'vehicleClass'),
(7, 2, 'name'),
(8, 2, 'vin'),
(9, 2, 'isLease')
ON CONFLICT (id) DO NOTHING;

insert into FormTemplates_pollquestions(id, FormTemplates_id, pollquestion) values
(1, 1, 'isSatisfied?'),
(2, 1, 'WhySatisfied?'),
(3, 1, 'WhyNotSatisfied?'),
(4, 2, 'isSatisfied?'),
(5, 2, 'WhySatisfied?'),
(6, 2, 'WhyNotSatisfied?')
ON CONFLICT (id) DO NOTHING;

insert into FormTemplates_pollquestions_relations(id, pollquestions_id, if, "then") values
(1, 1, '=1', 2),
(2, 1, '=0', 3),
(3, 4, '=1', 5),
(4, 4, '=0', 6)
ON CONFLICT (id) DO NOTHING;


insert into Forms(id, FormTemplates_id) values
(1, 1)
ON CONFLICT (id) DO NOTHING;


insert into Forms_answers(id, Forms_id, questions_id, answer) values
(1, 1, 1, 'sameExampleName'),
(2, 1, 2, '5'),
(3, 1, 3, '2'),
(4, 1, 4, '3'),
(5, 1, 5, '10'),
(6, 1, 6, 'someExampleVehicleClass')
ON CONFLICT (id) DO NOTHING;

insert into Forms_pollanswers(id, Forms_id, pollquestions_id, answer) values
(1, 1, 1, '1'),
(2, 1, 2, 'SomeExampleReasonForSatisfaction')
ON CONFLICT (id) DO NOTHING;
