CREATE ROLE admin  WITH LOGIN SUPERUSER PASSWORD 'password';

create table if not exists FormTemplates();

alter table FormTemplates add column if not exists id bigserial primary key;

alter table FormTemplates add column if not exists name varchar(30);


create table if not exists FormTemplates_questions();

alter table FormTemplates_questions  add column if not exists id bigserial primary key;

alter table FormTemplates_questions  add column if not exists FormTemplates_id bigint references FormTemplates(id);




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

alter table Forms  add column if not exists FormsTemplates_id bigint references FormTemplates(id);


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

