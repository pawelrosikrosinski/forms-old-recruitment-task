--SCHEMA DEFINITION (only PSQL compatible, will fix later)

--DROP ROLE IF EXISTS admin;

--REATE ROLE admin  WITH LOGIN SUPERUSER PASSWORD 'password';

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



DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'pollquestion_type') THEN
        create type pollquestion_type AS ENUM ('text', 'boolean');
    END IF;
END
$$;


alter table FormTemplates_pollquestions  add column if not exists pollquestion_type pollquestion_type;


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

insert into FormTemplates_pollquestions(id, FormTemplates_id, pollquestion, pollquestion_type) values
(1, 1, 'isSatisfied?', 'boolean'),
(2, 1, 'WhySatisfied?', 'text'),
(3, 1, 'WhyNotSatisfied?', 'text'),
(4, 2, 'isSatisfied?', 'boolean'),
(5, 2, 'WhySatisfied?', 'text'),
(6, 2, 'WhyNotSatisfied?', 'text')
ON CONFLICT (id) do update set (FormTemplates_id, pollquestion, pollquestion_type) = (excluded.FormTemplates_id, excluded.pollquestion, excluded.pollquestion_type);

insert into FormTemplates_pollquestions_relations(id, pollquestions_id, if, "then") values
(1, 1, '=1', 2),
(2, 1, '=0', 3),
(3, 4, '=1', 5),
(4, 4, '=0', 6)
ON CONFLICT (id) do update set (pollquestions_id, if, "then") = (excluded.pollquestions_id, excluded.if, excluded."then");


insert into Forms(id, FormTemplates_id) values
(1, 1),
(2, 2)
ON CONFLICT (id) do update set FormTemplates_id = excluded.FormTemplates_id;


insert into Forms_answers(Forms_id, questions_id, answer) values
(1, 1, 'sameExampleName'),
(1, 2, '5'),
(1, 3, '2'),
(2, 4, '3'),
(2, 5, '10'),
(2, 6, 'someExampleVehicleClass')
ON CONFLICT (Forms_id, questions_id) do update set (Forms_id, questions_id, answer) = (excluded.Forms_id, excluded.questions_id, excluded.answer);

insert into Forms_pollanswers(Forms_id, pollquestions_id, answer) values
(1, 1, '1'),
(1, 2, 'SomeExampleReasonForSatisfaction')
ON CONFLICT (Forms_id, pollquestions_id) do update set (Forms_id, pollquestions_id, answer) = (excluded.Forms_id, excluded.pollquestions_id, excluded.answer);

insert into Searches(id, searchData) values
(1, '{"forms_answers": {"answer": "someExample"}}')
ON CONFLICT (id) do update set searchData = excluded.searchData;


SELECT setval('forms_id_seq', (select max(id) from forms), true);

--sanitized i/o



prepare get_forms_list as select json_agg(json_build_object('forms_id', forms.id, 'formtemplates_id', formtemplates_id, 'formtemplates_name', formtemplates.name) order by forms.id desc)::text from forms left join formtemplates on forms.formtemplates_id = formtemplates.id;

prepare get_form_qa (integer) as select json_agg(json_build_object('question_id', formtemplates_questions.id, 'question', "question", 'answer', a.answer) order by formtemplates_questions.id)  from formtemplates_questions left  join (select * from forms_answers where forms_id = $1) a  on formtemplates_questions.id = a.questions_id where formtemplates_questions.formtemplates_id = (select formtemplates_id from forms where id = $1);


prepare get_form_poll (integer) as select json_agg(json_build_object('pollquestion_id', formtemplates_pollquestions.id, 'pollquestion', "pollquestion", 'pollquestion_type', pollquestion_type ,'answer', forms_pollanswers.answer, 'relations', (select json_build_object('if', "if", 'pollquestion_id', "pollquestions_id") from formtemplates_pollquestions_relations where formtemplates_pollquestions_relations."then" =  formtemplates_pollquestions.id)) ORDER BY formtemplates_pollquestions.id )   from formtemplates_pollquestions left  join forms_pollanswers on formtemplates_pollquestions.id = forms_pollanswers.pollquestions_id and forms_id = $1 where formtemplates_pollquestions.formtemplates_id = (select formtemplates_id from forms where id = $1);

prepare get_searches as select json_object_agg(id, searchData) from searches;

prepare get_formtemplates as select json_agg(json_build_object('formtemplate_id', id, 'formtemplate_name', name)) from formtemplates;


prepare create_new_form (integer) as insert into forms (formtemplates_id) values ($1) returning id::integer;


prepare post_form_qa (jsonb, integer) as insert into forms_answers (forms_id, questions_id, answer)   (select $2,  (value->'question_id')::integer, (value->>'answer') from jsonb_array_elements($1)) on conflict (forms_id, questions_id) do update set answer = excluded.answer;

prepare post_form_poll (jsonb, integer) as insert into forms_pollanswers (forms_id, pollquestions_id, answer)   (select $2,  (value->'pollquestion_id')::integer, (value->>'answer') from jsonb_array_elements($1)) on conflict (forms_id, pollquestions_id) do update set answer = excluded.answer;
 
