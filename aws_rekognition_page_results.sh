#!/bin/bash

# change into clean directory
cd /Users/junaid/Desktop/Spring2022/CompSAN/AWS/Faces

# start counter
x=1

# Define job ID
JOBID="f57a4cd35a8938116a655007028fe50677ff2ad92c0fd56fb918b63bcbc6d397"

# Get first page of results
aws rekognition get-face-detection --job-id $JOBID > FaceDefault_${x}.json

# Get next token
NEXTOKEN=$(grep "NextToken" FaceDefault_${x}.json)
# remove double quotes
NEXTOKEN=$(echo ${NEXTOKEN} | xargs)
# remove "NextToken"
NEXTOKEN=$(echo ${NEXTOKEN#"NextToken: "})
# remove trailing comma
NEXTOKEN=$(echo ${NEXTOKEN%","})

# Start while loop that continues until there are no more next tokens
while [ ${#NEXTOKEN} -gt 0 ]; do
# echo x so we can see how many files are being created
echo $x
# echo token to check against
echo $NEXTOKEN
# add to counter
x=`expr $x + 1`
# print new file
aws rekognition get-face-detection --job-id $JOBID --next-token $NEXTOKEN > FaceDefault_${x}.json 
# assign next toke
NEXTOKEN=$(grep "NextToken" FaceDefault_${x}.json)
# remove double quotes
NEXTOKEN=$(echo ${NEXTOKEN} | xargs)
# remove "NextToken"
NEXTOKEN=$(echo ${NEXTOKEN#"NextToken: "})
# remove trailing comma
NEXTOKEN=$(echo ${NEXTOKEN%","})
done



