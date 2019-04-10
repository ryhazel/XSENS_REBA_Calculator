tree = load_mvnx('Test_Bobby-001');
% read some basic data from the file
mvnxVersion = tree;
fileComments = tree.subject.comment;
%read some basic properties of the subject;
frameRate = tree.subject.frameRate;
suitLabel = tree.subject.label;
originalFilename = tree.subject.originalFilename;
recDate = tree.subject.recDate;
segmentCount = tree.subject.segmentCount;
%retrieve sensor labels
%creates a struct with sensor data 
sensorData = tree.subject.sensors.sensor; 
%retrieve segment labels
%creates a struct with segment definitions 
segmentData = tree.subject.segments.segment; 