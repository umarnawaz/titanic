set search_path to kaggle_titanic;

drop table raw_train cascade;
drop table raw_test cascade;

create table raw_train(
passenger_id text,
survived text,
pclass text,
name text,
sex text,
age text,
sibsp text,
parch text,
ticket text,
fare text,
cabin text,
embarked text
);

create table raw_test(
passenger_id text,
pclass text,
name text,
sex text,
age text,
sibsp text,
parch text,
ticket text,
fare text,
cabin text,
embarked text
);

\copy raw_train from 'backup/train.csv' csv header
\copy raw_test from 'backup/test.csv' csv header
