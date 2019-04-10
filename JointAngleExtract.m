%extract joint angles from .mvnx file (see main_mvnx.m)
nSamples = length(tree.subject.frames.frame);
for i=[3:nSamples]
    joint_angles(i,:)=tree.subject.frames.frame(i).jointAngle;
end
%% 

% indexing important variables
% X = Abduct/Adduct, 
% Y = Rotation, 
% Z = flex/extend

%C1HeadZ+
NeckFlex= joint_angles(:,18);

%C1HeadY 
NeckTwist= joint_angles(:,17);

%C1HeadX
NeckBend = joint_angles(:,16);
%%trunk Angle:

p_Segment1 = zeros(nSamples,3); 
for i=[1:nSamples]
    p_Segment1(i,:)=tree.subject.frames.frame(i).position(1:3);
end
p_Segment2 = zeros(nSamples,3);
for i=[1:nSamples]
    p_Segment2(i,:)=tree.subject.frames.frame(i).position(16:18);
end

% trunk vector setup
% we want the angle between the trunk angle and a vector originating at the
% pelvis and parallel with the y axis. The sagittal plane would not
% accurately represent the angle between the trunk and the lower body.
trunk_vector = p_Segment2 - p_Segment1;
y_axis = [zeros(nSamples,1),zeros(nSamples,1),ones(nSamples,1)];
y_point = p_Segment1 + y_axis;
y_vector = p_Segment1 - y_point;

% %visualize trunk vectors
%  lines = length(p_Segment1);
%  for i=[1:lines]
%      hold on
%      plot3([p_Segment1(i,1),p_Segment2(i,1)],[p_Segment1(i,2),p_Segment2(i,2)],[p_Segment1(i,3),p_Segment2(i,3)], '-b')
%      plot3([p_Segment1(i,1),y_point(i,1)],[p_Segment1(i,2),y_point(i,2)],[p_Segment1(i,3),y_point(i,3)], '-r')
%  end

% Calculate trunk Angle:
TrunkFlex = zeros(1,nSamples);
for i = 1:nSamples

%TrunkFlex(1,i) =acosd(dot(trunk_vector(i,1:3) ,y_vector(i,1:3))/(dot(norm(trunk_vector(i,1:3)),norm(y_vector(i,1:3)))));
TrunkFlex(1,i) = atan2d(norm(cross(trunk_vector(i,:),y_vector(1,:))),dot(trunk_vector(1,:),y_vector(1,:)));
end
%correct for trig
TrunkFlex = abs(TrunkFlex - 180);

%L1T12Y -- greater than 2 degrees.
TrunkTwist = joint_angles(:,8);
%L1T12X -- need to calibrate degree amount
TrunkBend = joint_angles(:,7);
%RKneeZ
RKneeFlex = joint_angles(:,48);
%LKneeZ
LKneeFlex = joint_angles(:,60);
%RShoulderZ
RShoulderFlex = joint_angles(:,24);
%RShoulderX
RShoulderAbd = joint_angles(:,22);
%LShoulderZ 
LShoulderFlex = joint_angles(:,36);
%LShoulderX
LShoulderAbd = joint_angles(:,34);
%RElbowZ 
RElbowFlex = joint_angles(:,27);
%LElbowZ 
LElbowFlex = joint_angles(:,39);
%RWristZ -- can use absolute value 
RWristFlex = joint_angles(:,30);
%LWristZ
LWristFlex = joint_angles(:,42);
%RWristY
RWristTwist = joint_angles(:,29);
%LWristY 
LWristTwist = joint_angles(:,41);