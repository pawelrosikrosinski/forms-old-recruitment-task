CREATE ROLE admin  WITH LOGIN SUPERUSER PASSWORD 'password';

create table if not exists FormTemplates();

alter table FormTemplates add column if not exists id bigserial;

alter table FormTemplates add column if not exists name varchar(30);


create table if not exists FormTemplates_questions();

alter table FormTemplates_questions  add column if not exists id bigserial;

alter table FormTemplates_questions  add column if not exists FormTemplates_id bigint;

alter table FormTemplates_questions  add column if not exists question text;


create table if not exists FormTemplates_pollquestions()

alter table FormTemplates_pollquestions  add column if not exists id bigserial;

alter table FormTemplates_pollquestions  add column if not exists FormTemplates_id bigint;

alter table FormTemplates_pollquestions  add column if not exists pollquestion text;


create table if not exists FormTemplates_pollquestions_relations()

alter table FormTemplates_pollquestions_relations  add column if not exists id bigserial;

alter table FormTemplates_pollquestions_relations  add column if not exists pollquestions_id bigint;

alter table FormTemplates_pollquestions_relations  add column if not exists if varchar(10);

alter table FormTemplates_pollquestions_relations  add column if not exists "then" bigint;


