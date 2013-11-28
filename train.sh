rm *.cache
paste train.labels train.vw | vw -f model.model -c --passes 2
