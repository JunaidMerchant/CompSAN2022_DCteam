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

The default is that it will print the results in json format straight into terminal, but you can pipe this to print to file. For example: 

```
aws rekognition get-celebrity-recognition --job-id 07f2873664018186589f922990f4969817004a79d853412d4c42a424491def74 > CelebrityOutputTest.json
```

It is possible to sort by time-stamp also:

```
aws rekognition get-celebrity-recognition --job-id 07f2873664018186589f922990f4969817004a79d853412d4c42a424491def74 --sort-by TIMESTAMP > CelebrityOutput_TimeSorted.json
```

