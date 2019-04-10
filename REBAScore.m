 %REBA calculation
 %% User Inputs
 LoadWeight =input("Please the weight of the load in kg:");
 if LoadWeight <= 5
     LoadScore = 0;
 elseif (LoadWeight > 5) && (LoadWeight < 10)
     LoadScore = 1;
 elseif LoadWeight > 10
     LoadScore = 2;
 end
 
 CouplingScore = input("Please enter a coupling score (Refer to handout):");
 ActivityScore = input("Please enter an activity score(Refer to handout):");
 
 %% Neck Score
 NeckScore = zeros(length(NeckFlex),1);
 for i = 1:length(NeckFlex)
     % Neck Flexion and Extension
     if (0 < NeckFlex(i)) && (NeckFlex(i) < 20)
         NeckScore(i) = 1;
     else 
         NeckScore(i) = 2;
     end
     
     % Neck Twisting
     if (NeckTwist(i) > 10) || (NeckTwist(i) < -10)
         NeckScore(i) = NeckScore(i) + 1;
     else
         NeckScore(i) = NeckScore(i);
     end
     
     %Neck Side Bending
     if (NeckBend(i) > 10) || (NeckBend(i) < -10)
         NeckScore(i) = NeckScore(i) + 1;
     else
         NeckScore(i) = NeckScore(i);
     end
     
 end 
 %% Trunk Score
 
 TrunkScore = zeros(length(TrunkFlex),1);
 for i = 1:length(TrunkFlex)
     % Trunk Flexion and Extension
     if TrunkFlex(i)== 0
         TrunkScore(i) = 1;
     elseif (TrunkFlex(i) <= 20) && (TrunkFlex(i) ~= 0) 
         TrunkScore(i) = 2;
     elseif (TrunkFlex(i) > 20) && (TrunkFlex(i) <= 60)
         TrunkScore(i) = 3;
     else
         TrunkScore(i) = 4;
     end
     
     % Trunk Twisting
     if (TrunkTwist(i) > 2) || (TrunkTwist(i) < -2)
         TrunkScore(i) = TrunkScore(i) + 1;
     else
         TrunkScore(i) = TrunkScore(i);
     end
     
     %Trunk Side Bending
     if (TrunkBend(i) > 3) || (TrunkBend(i) < -3)
         TrunkScore(i) = TrunkScore(i) + 1;
     else
         TrunkScore(i) = TrunkScore(i);
     end
     
 end 
 %% Leg Score
 
 % Right Side
 RLegScore = zeros(length(RKneeFlex),1);
 for i = 1:length(RKneeFlex)
     if (RKneeFlex(i) <= 60) && (RKneeFlex(i) >=30)
         RLegScore(i) = 1;
     elseif RKneeFlex(i) < 30
         RLegScore(i) = 0;
     else
         RLegScore(i) = 2;
     end
 end
 % Left Side

 LLegScore = zeros(length(LKneeFlex),1);
  for i = 1:length(LKneeFlex)
     if (LKneeFlex(i) <= 60) && (LKneeFlex(i) >=30)
         LLegScore(i) = 1;
     elseif RKneeFlex(i) < 30
         LLegScore(i) = 0;
     else
         LLegScore(i) = 2;
     end
 end 
% Total Leg Score
LegScore = zeros(length(RKneeFlex),1);
for i = 1:length(RLegScore)
    if RLegScore(i) == LLegScore(i)
        LegScore(i) = RLegScore(i) + 1;
    else 
        if RLegScore(i) > LLegScore(i)
            LegScore(i) = RLegScore + 2;
        elseif RLegScore(i) < LLegScore(i)
            LegScore(i) = LLegScore(i) + 2;
        end
    end
end

%% Table A Score
TableA = [[1,2,3,4,1,2,3,5,3,3,5,6];[2,3,4,5,3,4,5,6,4,5,6,7];[2,4,5,6,4,5,6,7,5,6,7,8];[3,5,6,7,5,6,7,8,6,7,8,9];[4,6,7,8,6,7,8,9,7,8,9,9]];
ScoreA = zeros(length(LegScore),1);
TableAScore = zeros(length(LegScore),1);
for i = 1:length(LegScore)
    if NeckScore(i) == 1
        TableAScore(i) = TableA(TrunkScore(i),LegScore(i));
    elseif NeckScore(i) == 2
        TableAScore(i) = TableA(TrunkScore(i),LegScore(i) + 4);
    elseif NeckScore(i) == 3
        TableAScore(i) = TableA(TrunkScore(i),LegScore(i) + 8);
    else
        TableAScore(i) = 0;
    end
ScoreA(i) = TableAScore(i) + LoadScore; 
end


%% Upper Arm Score
RUpperArmScore = zeros(length(RShoulderFlex),1);
for i = 1:length(RShoulderFlex)
    if (RShoulderFlex(i) > -20) && (RShoulderFlex(i) < 20)
        RUpperArmScore(i) = 1;
    elseif (RShoulderFlex(i) < -20) || ((RShoulderFlex(i) >= 20) && (RShoulderFlex(i) <= 45))
        RUpperArmScore(i) = 2;
    elseif (RShoulderFlex(i) > 45) && (RShoulderFlex(i) <= 90)
        RUpperArmScore(i) = 3;
    elseif RShoulderFlex(i) > 90
        RUpperArmScore(i) = 4;
    else
        RUpperArmScore(i) = 0;
    end
    if RShoulderAbd(i) >=30
        RUpperArmScore(i) = RUpperArmScore(i) + 1;
    else
        RUpperArmScore(i) = RUpperArmScore(i);
    end
end
LUpperArmScore = zeros(length(LShoulderFlex),1);
for i = 1:length(LShoulderFlex)
    if (LShoulderFlex(i) > -20) && (LShoulderFlex(i) < 20)
        LUpperArmScore(i) = 1;
    elseif (LShoulderFlex(i) < -20) || ((LShoulderFlex(i) >= 20) && (LShoulderFlex(i) <= 45))
        LUpperArmScore(i) = 2;
    elseif (LShoulderFlex(i) > 45) && (LShoulderFlex(i) <= 90)
        LUpperArmScore(i) = 3;
    elseif LShoulderFlex(i) > 90
        LUpperArmScore(i) = 4;
    else
        LUpperArmScore(i) = 0;
    end
    if LShoulderAbd(i) >=30
        LUpperArmScore(i) = LUpperArmScore(i) + 1;
    else
        LUpperArmScore(i) = LUpperArmScore(i);
    end
end
%% Lower Arm Score
RLowerArmScore = zeros(length(RElbowFlex),1);
for i = 1:length(RElbowFlex)
    if (RElbowFlex(i) >= 100) || (RElbowFlex(i) <= 60)
        RLowerArmScore(i) = 2;
    else 
        RLowerArmScore(i) = 1;
    end
end
LLowerArmScore = zeros(length(LElbowFlex),1);
for i = 1:length(LElbowFlex)
    if (LElbowFlex(i) >= 100) || (LElbowFlex(i) <= 60)
        LLowerArmScore(i) = 2;
    else 
       LLowerArmScore(i) = 1;
    end
end
%% Wrist Score
RWristScore = zeros(length(RWristFlex),1);
for i = 1:length(RWristFlex)
    if (RWristFlex(i) >= 15) || (RWristFlex(i) <= -15)
        RWristScore(i) = 2;
    else
        RWristScore(i) = 1;
    end
    if (RWristTwist(i) >= 30) || (RWristTwist(i) <= -30)
        RWristScore(i) = RWristScore(i) + 1;
    else
        RWristScore(i) = RWristScore(i);
    end
end

LWristScore = zeros(length(LWristFlex),1);
for i = 1:length(LWristFlex)
    if (LWristFlex(i) >= 15) || (LWristFlex(i) <= -15)
        LWristScore(i) = 2;
    else
        LWristScore(i) = 1;
    end
    if (LWristTwist(i) >= 30) || (LWristTwist(i) <= -30)
        LWristScore(i) = LWristScore(i) + 1;
    else
        LWristScore(i) = LWristScore(i);
    end
end

%% Table B
TableB = [[1,2,2,1,2,3];[1,2,3,2,3,4];[3,4,5,4,5,5];[4,5,5,5,6,7];[6,7,8,7,8,8];[7,8,8,8,9,9]];
ScoreB = zeros(length(RWristScore),1);
TableBScoreR = zeros(length(RWristScore),1);
for i = 1:length(RWristScore)
    if RLowerArmScore(i) == 1
        TableBScoreR(i) = TableB(RUpperArmScore(i),RWristScore(i));
    elseif RLowerArmScore(i) == 2
        TableBScoreR(i) = TableB(RUpperArmScore(i),RWristScore(i) + 3);
    else
        TableBScoreR(i) = 0;
    end
end
TableBScoreL = zeros(length(LWristScore),1);
for i = 1:length(LWristScore)
    if LLowerArmScore(i) == 1
        TableBScoreL(i) = TableB(LUpperArmScore(i),LWristScore(i));
    elseif LLowerArmScore(i) == 2
        TableBScoreL(i) = TableB(LUpperArmScore(i),LWristScore(i) + 3);
    else
        TableBScoreL(i) = 0;
    end
end

TableBScore = zeros(length(TableBScoreL),1);
for i = 1:length(TableBScoreL)
    if TableBScoreL(i) > TableBScoreR(i)
        TableBScore(i) = TableBScoreL(i);
    elseif TableBScoreL(i) < TableBScoreR(i)
        TableBScore(i) = TableBScoreR(i);
    else
        TableBScore(i) = TableBScoreR(i);
    end
end
for i = 1:length(RWristScore)
    ScoreB(i) = TableBScore(i) + CouplingScore;
end

%% Table C Score
TableC = [[1,1,1,2,3,3,4,5,6,7,7,7];[1,2,2,3,4,4,5,6,6,7,7,8];[2,3,3,3,4,5,6,7,7,8,8,8];
    [3,4,4,4,5,6,7,8,8,9,9,9];[4,4,4,5,6,7,8,8,9,9,9,9];[6,6,6,7,8,8,9,9,10,10,10,10];
    [7,7,7,8,9,9,9,10,10,11,11,11];[8,8,8,9,10,10,10,10,10,11,11,11];[9,9,9,10,10,10,11,11,11,12,12,12];
    [10,10,10,11,11,11,11,12,12,12,12,12];[11,11,11,11,11,12,12,12,12,12,12,12];
    [12,12,12,12,12,12,12,12,12,12,12,12]];

TableCScore = zeros(length(ScoreB),1);
for i = 1:length(ScoreB)
    TableCScore(i) = TableC(ScoreA(i),ScoreB(i));
end
%% REBA Score
RebaScore = TableCScore + ActivityScore;
x = 1:length(RebaScore);
hold on
for i = 1:length(x)
    if RebaScore(i) == 1
        plot(x(i),RebaScore(i),'cs')
    elseif (RebaScore(i) == 3) || (RebaScore(i) == 2)
        plot(x(i),RebaScore(i),'gs')
    elseif (RebaScore(i) >= 4) && (RebaScore(i) <= 7)
        plot(x(i),RebaScore(i),'ys')
    elseif (RebaScore(i) >= 8) && (RebaScore(i) <= 10)
        plot(x(i),RebaScore(i),'rs')
    elseif RebaScore(i) >= 11
        plot(x(i),RebaScore(i),'ms')
    end
end
plot(RebaScore, 'k')
ylabel({'REBA Score'});
xlabel({'Frame'});
title({'REBA Score for Test IMU Trial'});
ylim([0,15]);



        

        