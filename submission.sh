echo 'PassengerId,Survived' >submission.csv
paste test.id model.predictions | tr '\t' ',' >>submission.csv


