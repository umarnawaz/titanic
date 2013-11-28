echo 'PassengerId,Survived' >submission.csv
paste test.id model.predictions | awk '{if ($2 < 0.5) print $1",0"; else print $1",1"}' >>submission.csv


