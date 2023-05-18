--SCHEMA DEFINITION (only PSQL compatible, will fix later)

--CREATE ROLE admin  WITH LOGIN SUPERUSER PASSWORD 'password';

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

--alter table Forms_answers  add column if not exists id bigserial primary key;

alter table Forms_answers  add column if not exists Forms_id bigint references Forms(id);

alter table Forms_answers  add column if not exists questions_id bigint references FormTemplates_questions(id);

alter table Forms_answers  add column if not exists answer text;

alter table Forms_answers drop constraint if exists uniq_forms_answers;

alter table Forms_answers add constraint uniq_forms_answers unique (forms_id, questions_id);



create table if not exists Forms_pollanswers();

--alter table Forms_pollanswers  add column if not exists id bigserial primary key;

alter table Forms_pollanswers  add column if not exists Forms_id bigint references Forms(id);

alter table Forms_pollanswers  add column if not exists pollquestions_id bigint references FormTemplates_pollquestions(id);

alter table Forms_pollanswers  add column if not exists answer text;

alter table Forms_pollanswers drop constraint if exists uniq_forms_pollanswers;

alter table Forms_pollanswers add constraint uniq_forms_pollanswers unique (forms_id, pollquestions_id);


create table if not exists Searches();

alter table Searches add column if not exists id bigserial primary key;

alter table Searches add column if not exists searchData jsonb;



--MINIMAL DATA IMPORT (not strictly IDEMPOTENT, only PSQL compatible, will fix later)

insert into FormTemplates(id, name) values
(1, 'VehicleInsuranceDeal'),
(2, 'VehicleDeal')
ON CONFLICT (id) do update set name = excluded.name;

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
ON CONFLICT (id) do update set (FormTemplates_id, question) = (excluded.FormTemplates_id, excluded.question);

insert into FormTemplates_pollquestions(id, FormTemplates_id, pollquestion) values
(1, 1, 'isSatisfied?'),
(2, 1, 'WhySatisfied?'),
(3, 1, 'WhyNotSatisfied?'),
(4, 2, 'isSatisfied?'),
(5, 2, 'WhySatisfied?'),
(6, 2, 'WhyNotSatisfied?')
ON CONFLICT (id) do update set (FormTemplates_id, pollquestion) = (excluded.FormTemplates_id, excluded.pollquestion);

insert into FormTemplates_pollquestions_relations(id, pollquestions_id, if, "then") values
(1, 1, '=yes', 2),
(2, 1, '=no', 3),
(3, 4, '=yes', 5),
(4, 4, '=no', 6)
ON CONFLICT (id) do update set (pollquestions_id, if, "then") = (excluded.pollquestions_id, excluded.if, excluded."then");


insert into Forms(id, FormTemplates_id) values
(1, 1)
ON CONFLICT (id) do update set FormTemplates_id = excluded.FormTemplates_id;


insert into Forms_answers(id, Forms_id, questions_id, answer) values
(1, 1, 1, 'sameExampleName'),
(2, 1, 2, '5'),
(3, 1, 3, '2'),
(4, 1, 4, '3'),
(5, 1, 5, '10'),
(6, 1, 6, 'someExampleVehicleClass')
ON CONFLICT (id) do update set (Forms_id, questions_id, answer) = (excluded.Forms_id, excluded.questions_id, excluded.answer);

insert into Forms_pollanswers(id, Forms_id, pollquestions_id, answer) values
(1, 1, 1, '1'),
(2, 1, 2, 'SomeExampleReasonForSatisfaction')
ON CONFLICT (id) do update set (Forms_id, pollquestions_id, answer) = (excluded.Forms_id, excluded.pollquestions_id, excluded.answer);

insert into Searches(id, searchData) values
(1, '{"forms_answers": {"answer": "someExample"}}')
ON CONFLICT (id) do update set searchData = excluded.searchData;

--sanitized i/o



prepare get_forms_list as select forms.id,  formtemplates.name from forms left join formtemplates on forms.formtemplates_id = formtemplates.id;

prepare get_form_qa (integer) as select json_object_agg(formtemplates_questions.id, json_build_object('question', "question", 'answer', forms_answers.answer))  from formtemplates_questions left  join forms_answers on formtemplates_questions.id = forms_answers.questions_id where forms_answers.forms_id = $1;

prepare get_form_poll (integer) as select json_object_agg(formtemplates_pollquestions.id, json_build_object('pollquestion', "pollquestion", 'answer', forms_pollanswers.answer, 'if', if, 'then', "then"))  from formtemplates_pollquestions left  join forms_pollanswers on formtemplates_pollquestions.id = forms_pollanswers.pollquestions_id left join formtemplates_pollquestions_relations on formtemplates_pollquestions.id = formtemplates_pollquestions_relations.pollquestions_id  where forms_pollanswers.forms_id = $1;

prepare get_searches as select json_object_agg(id, searchData) from searches;



prepare create_new_form (integer) as insert into forms (formtemplates_id) values ($1) returning id;


prepare post_form_qa (jsonb) as insert into forms_answers (forms_id, questions_id, answer) values ((select "key" from jsonb_each($1))::integer, ((select "value" from jsonb_each($1))  -> 'question_id')::integer, ((select "value" from jsonb_each($1))  -> 'answer')::text) on conflict (forms_id, questions_id) do update set answer = excluded.answer;

prepare post_form_poll (jsonb) as insert into forms_pollanswers (forms_id, pollquestions_id, answer) values ((select "key" from jsonb_each($1))::integer, ((select "value" from jsonb_each($1))  -> 'pollquestion_id')::integer, ((select "value" from jsonb_each($1))  -> 'answer')::text) on conflict (forms_id, pollquestions_id) do update set answer = excluded.answer;
