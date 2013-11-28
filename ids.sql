set search_path to kaggle_titanic;

\copy (select passenger_id from raw_train order by id asc) to 'train.id'
\copy (select passenger_id from raw_test order by id asc) to 'test.id'
