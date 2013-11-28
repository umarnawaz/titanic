set search_path to kaggle_titanic;

drop view train_test cascade;

create view train_test as
select 'train' as tt,
passenger_id,pclass,name,sex,age,sibsp,parch,ticket,fare,cabin,embarked
from raw_train
union all
select 'test' as tt,
passenger_id,pclass,name,sex,age,sibsp,parch,ticket,fare,cabin,embarked
from raw_test;

create view features as
select tt,passenger_id,
' | n ' 
|| regexp_replace(coalesce(pclass,'n/a'),'^','pclass==') || ' '
|| regexp_replace(coalesce(name,'n/a'),':','_') || ' ' 
|| regexp_replace(coalesce(sex,'n/a'),'^','sex==') || ' ' 
|| regexp_replace(coalesce(age,'n/a'),'^','age==') || ' '
|| regexp_replace(coalesce(sibsp,'n/a'),'^','sibsp==') || ' '
|| regexp_replace(coalesce(parch,'n/a'),'^','parch==') || ' '
|| regexp_replace(regexp_replace(coalesce(ticket),' ','_'),'^','ticket==') || ' '
|| regexp_replace(cast(floor(cast(fare as float)) as text),'^','fare==') || ' '
|| regexp_replace(cast(coalesce(cabin,'n/a') as text),'^','cabin==') || ' '
|| regexp_replace(coalesce(embarked),'^','embarked==')
as features
from train_test order by passenger_id asc;

create view train as
select raw_train.survived || features.features as features
from raw_train,features
where raw_train.passenger_id = features.passenger_id
and features.tt = 'train' order by raw_train.passenger_id asc;

\copy (select features from train) to 'train.vw'
\copy (select features from features where tt = 'test') to 'test.vw'
