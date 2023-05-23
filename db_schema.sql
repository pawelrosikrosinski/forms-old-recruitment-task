--schema definition (only psql compatible, will fix later)

--drop role if exists admin;

--reate role admin  with login superuser password 'password';

create table if not exists formtemplates();





alter table formtemplates add column if not exists id bigserial primary key;

alter table formtemplates add column if not exists name varchar(30);


create table if not exists formtemplates_questions();

alter table formtemplates_questions  add column if not exists id bigserial primary key;

alter table formtemplates_questions  add column if not exists formtemplates_id bigint references formtemplates(id);

alter table formtemplates_questions  add column if not exists question text;





create table if not exists formtemplates_pollquestions();

alter table formtemplates_pollquestions  add column if not exists id bigserial primary key;

alter table formtemplates_pollquestions  add column if not exists formtemplates_id bigint references formtemplates(id);

alter table formtemplates_pollquestions  add column if not exists pollquestion text;



do $$
begin
    if not exists (select 1 from pg_type where typname = 'pollquestion_type') then
        create type pollquestion_type as enum ('text', 'boolean');
    end if;
end
$$;


alter table formtemplates_pollquestions  add column if not exists pollquestion_type pollquestion_type;


create table if not exists formtemplates_pollquestions_relations();

alter table formtemplates_pollquestions_relations  add column if not exists id bigserial primary key;

alter table formtemplates_pollquestions_relations  add column if not exists pollquestions_id bigint references formtemplates_pollquestions(id);

alter table formtemplates_pollquestions_relations  add column if not exists if varchar(10);

alter table formtemplates_pollquestions_relations  add column if not exists "then" bigint;


create table if not exists forms();

alter table forms  add column if not exists id bigserial primary key;

alter table forms  add column if not exists formtemplates_id bigint references formtemplates(id);


create table if not exists forms_answers();

--alter table forms_answers  add column if not exists id bigserial primary key;

alter table forms_answers  add column if not exists forms_id bigint references forms(id);

alter table forms_answers  add column if not exists questions_id bigint references formtemplates_questions(id);

alter table forms_answers  add column if not exists answer text;

alter table forms_answers drop constraint if exists uniq_forms_answers;

alter table forms_answers add constraint uniq_forms_answers unique (forms_id, questions_id);



create table if not exists forms_pollanswers();

--alter table forms_pollanswers  add column if not exists id bigserial primary key;

alter table forms_pollanswers  add column if not exists forms_id bigint references forms(id);

alter table forms_pollanswers  add column if not exists pollquestions_id bigint references formtemplates_pollquestions(id);

alter table forms_pollanswers  add column if not exists answer text;

alter table forms_pollanswers drop constraint if exists uniq_forms_pollanswers;

alter table forms_pollanswers add constraint uniq_forms_pollanswers unique (forms_id, pollquestions_id);


create table if not exists searches();

alter table searches add column if not exists id bigserial primary key;

alter table searches add column if not exists searchdata jsonb;



--minimal data import (not strictly idempotent, only psql compatible, will fix later)

insert into formtemplates(id, name) values
(1, 'vehicleinsurancedeal'),
(2, 'vehicledeal')
on conflict (id) do update set name = excluded.name;

insert into formtemplates_questions(id, formtemplates_id, question) values
(1, 1, 'name'),
(2, 1, 'duration'),
(3, 1, 'installmentcount'),
(4, 1, 'perinstallmentamount'),
(5, 1, 'maximumcoverageamount'),
(6, 1, 'vehicleclass'),
(7, 2, 'name'),
(8, 2, 'vin'),
(9, 2, 'islease')
on conflict (id) do update set (formtemplates_id, question) = (excluded.formtemplates_id, excluded.question);

insert into formtemplates_pollquestions(id, formtemplates_id, pollquestion, pollquestion_type) values
(1, 1, 'issatisfied?', 'boolean'),
(2, 1, 'whysatisfied?', 'text'),
(3, 1, 'whynotsatisfied?', 'text'),
(4, 2, 'issatisfied?', 'boolean'),
(5, 2, 'whysatisfied?', 'text'),
(6, 2, 'whynotsatisfied?', 'text')
on conflict (id) do update set (formtemplates_id, pollquestion, pollquestion_type) = (excluded.formtemplates_id, excluded.pollquestion, excluded.pollquestion_type);

insert into formtemplates_pollquestions_relations(id, pollquestions_id, if, "then") values
(1, 1, '=1', 2),
(2, 1, '=0', 3),
(3, 4, '=1', 5),
(4, 4, '=0', 6)
on conflict (id) do update set (pollquestions_id, if, "then") = (excluded.pollquestions_id, excluded.if, excluded."then");


insert into forms(id, formtemplates_id) values
(1, 1),
(2, 2)
on conflict (id) do update set formtemplates_id = excluded.formtemplates_id;


insert into forms_answers(forms_id, questions_id, answer) values
(1, 1, 'sameexamplename'),
(1, 2, '5'),
(1, 3, '2'),
(2, 4, '3'),
(2, 5, '10'),
(2, 6, 'someexamplevehicleclass')
on conflict (forms_id, questions_id) do update set (forms_id, questions_id, answer) = (excluded.forms_id, excluded.questions_id, excluded.answer);

insert into forms_pollanswers(forms_id, pollquestions_id, answer) values
(1, 1, '1'),
(1, 2, 'someexamplereasonforsatisfaction')
on conflict (forms_id, pollquestions_id) do update set (forms_id, pollquestions_id, answer) = (excluded.forms_id, excluded.pollquestions_id, excluded.answer);

insert into searches(id, searchdata) values
(1, '{"forms_answers": {"answer": "someexample"}}')
on conflict (id) do update set searchdata = excluded.searchdata;

--sanitized i/o



prepare get_forms_list as select json_agg(json_build_object('forms_id', forms.id, 'formtemplates_id', formtemplates_id, 'formtemplates_name', formtemplates.name))::text from forms left join formtemplates on forms.formtemplates_id = formtemplates.id;

prepare get_form_qa (integer) as select json_agg(json_build_object('question_id', formtemplates_questions.id, 'question', "question", 'answer', a.answer))  from formtemplates_questions left  join (select * from forms_answers where forms_id = $1) a  on formtemplates_questions.id = a.questions_id where formtemplates_questions.formtemplates_id = (select formtemplates_id from forms where id = $1);


prepare get_form_poll (integer) as select json_agg(json_build_object('pollquestion_id', formtemplates_pollquestions.id, 'pollquestion', "pollquestion", 'pollquestion_type', pollquestion_type ,'answer', forms_pollanswers.answer, 'relations', (select json_build_object('if', "if", 'pollquestion_id', "pollquestions_id") from formtemplates_pollquestions_relations where formtemplates_pollquestions_relations."then" =  formtemplates_pollquestions.id)) order by formtemplates_pollquestions.id )   from formtemplates_pollquestions left  join forms_pollanswers on formtemplates_pollquestions.id = forms_pollanswers.pollquestions_id  where formtemplates_pollquestions.formtemplates_id = (select formtemplates_id from forms where id = $1);

prepare get_searches as select json_object_agg(id, searchdata) from searches;

prepare get_formtemplates as select json_agg(json_build_object('formtemplate_id', id, 'formtemplate_name', name)) from formtemplates;


prepare create_new_form (integer) as insert into forms (formtemplates_id) values ($1) returning id::integer;


prepare post_form_qa (jsonb, integer) as insert into forms_answers (forms_id, questions_id, answer)   (select $2,  (value->'question_id')::integer, (value->>'answer') from jsonb_array_elements($1)) on conflict (forms_id, questions_id) do update set answer = excluded.answer;

prepare post_form_poll (jsonb, integer) as insert into forms_pollanswers (forms_id, pollquestions_id, answer)   (select $2,  (value->'pollquestion_id')::integer, (value->>'answer') from jsonb_array_elements($1)) on conflict (forms_id, pollquestions_id) do update set answer = excluded.answer;
 
