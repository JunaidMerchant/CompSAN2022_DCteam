# Code I used to extract/annotate features from the first episode of FNL

Amazon Rekognition provides a powerful set of tools that can be leveraged for automatic annotation of video data for naturalizing neuroimaging approaches. Better yet, despite carrying a hefty price for industry like use-cases, the relatively lighter computational needs of neuroimaging researchers enabled us to get everything we needed simply using the free-tier option!
Of interest for our project, we were able extract: 

- The time-stamp of when each character was on the screen using the celebrity-recognition which is able to identify any actor that has an IMDB page.
-- Confidence rating in the label
-- Bounding box size and location of the actor’s face
-- Facial landmark (i.e., eye, nose mouth) locations
-- Gender
-- Brightness/Sharpness of the face
-- Pose of the face using pitch/roll/yaw


## Getting started

Getting set up on aws takes a bit of work, but here are some links to help you get started:

General documentation:
https://aws.amazon.com/rekognition/
https://docs.aws.amazon.com/rekognition/latest/dg/getting-started.html

Configuring for rekognition: https://docs.aws.amazon.com/rekognition/latest/dg/api-video-roles.html

Examples: https://docs.aws.amazon.com/rekognition/latest/dg/video-analyzing-with-sqs.html

Example python code for celebrity rekognition: https://docs.aws.amazon.com/rekognition/latest/dg/celebrities-video-sqs.html

CLI: https://docs.aws.amazon.com/rekognition/latest/dg/video-cli-commands.html

Add these things to bash profile for ease of use: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

## Celebrity Rekognition

Once you’ve set up your account, IAM user details, installed the CLI and SDK, there are a couple of ways you can annotate videos with time stamps of people. In our case, because these were known actors, the celebrity recognition functions were the most efficient to use. Here are the pages on running the celebrity recognition function, and the 2nd gets you the output all through command line: 

https://docs.aws.amazon.com/cli/latest/reference/rekognition/start-celebrity-recognition.html

https://docs.aws.amazon.com/cli/latest/reference/rekognition/get-celebrity-recognition.html


For example, this is the command for starting the celebrity detection function:

```
aws rekognition start-celebrity-recognition --video "S3Object={Bucket=compsan,Name=MD5E-s6843119325--2d459faf2911fb6e982691bc5ba483f4.mp4}"

```

Once the process has finished recognizing all the celebrities, you use a different function to retrieve the results. The default is that it will print the results in json format straight into terminal, but you can pipe this to print to file. For example: 

```
aws rekognition get-celebrity-recognition --job-id 07f2873664018186589f922990f4969817004a79d853412d4c42a424491def74 > CelebrityOutputTest.json
```

It is possible to sort by time-stamp also:

```
aws rekognition get-celebrity-recognition --job-id 07f2873664018186589f922990f4969817004a79d853412d4c42a424491def74 --sort-by TIMESTAMP > CelebrityOutput_TimeSorted.json
```

One challenge is that it only prints 1000 results on the call, and if there are more results, you have to page through the results. This can be a pain if you are wanting to get everything. Here is a solution I came up to page through the results and write to file. This is also included in aws_rekognition_page_results.sh script:

```
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
```
