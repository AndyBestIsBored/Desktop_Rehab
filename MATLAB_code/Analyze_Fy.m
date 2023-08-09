clear
clc


%% Read data

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";

%X025
T01_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T01.csv");
T10_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T10.csv");
T11_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T11.csv");
T0m1_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T0-1.csv");
Tm10_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T-10.csv");
Tm1m1_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/T-1-1.csv");



%% Smooth all

%X025
T01_025_smooth = smoothN(T01_025);
T10_025_smooth = smoothN(T10_025);   
T11_025_smooth = smoothN(T11_025);
T0m1_025_smooth = smoothP(T0m1_025);
Tm10_025_smooth = smoothP(Tm10_025);
Tm1m1_025_smooth = smoothP(Tm1m1_025);



%% Plots vs Time

figure()
sgtitle("T01 X025")

subplot(2,2,1)
plot(T01_025_smooth.Time, T01_025_smooth.Fy_Mea)
title("Fy Smooth Recorded")
subplot(2,2,2)
plot(T01_025_smooth.Time, T01_025_smooth.Fy_Mea)
title("Fy Smooth Recorded")

subplot(2,2,3)
plot(T01_025_smooth.Time, T01_025_smooth.Fy)
title("Fy Theory")
subplot(2,2,4)
plot(T01_025_smooth.Time, T01_025_smooth.Fy)
title("Fy Theory")





%% Plot vs Time New

%Fy
figure()
sgtitle("Fy X025")

subplot(2,3,1)
hold on
plot(T01_025_smooth.Time, T01_025_smooth.Fy_Mea)
plot(T01_025_smooth.Time, T01_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = 3 Nm")

subplot(2,3,2)
hold on
plot(T10_025_smooth.Time, T10_025_smooth.Fy_Mea)
plot(T10_025_smooth.Time, T10_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 0 Nm")

subplot(2,3,3)
hold on
plot(T11_025_smooth.Time, T11_025_smooth.Fy_Mea)
plot(T11_025_smooth.Time, T11_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 3 Nm")

subplot(2,3,4)
hold on
plot(T0m1_025_smooth.Time, T0m1_025_smooth.Fy_Mea)
plot(T0m1_025_smooth.Time, T0m1_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = -1 Nm")

subplot(2,3,5)
hold on
plot(Tm10_025_smooth.Time, Tm10_025_smooth.Fy_Mea)
plot(Tm10_025_smooth.Time, Tm10_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -1 Nm, T2 = 0 Nm")

subplot(2,3,6)
hold on
plot(Tm1m1_025_smooth.Time, Tm1m1_025_smooth.Fy_Mea)
plot(Tm1m1_025_smooth.Time, Tm1m1_025_smooth.Fy, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -1 Nm, T2 = -1 Nm")




%% Sort Y


%X025
T01_025_sortY = sortrows(T01_025_smooth, 'y');
T10_025_sortY = sortrows(T10_025_smooth, 'y');   
T11_025_sortY = sortrows(T11_025_smooth, 'y');
T0m1_025_sortY = sortrows(T0m1_025_smooth, 'y');
Tm10_025_sortY = sortrows(Tm10_025_smooth, 'y');
Tm1m1_025_sortY = sortrows(Tm1m1_025_smooth, 'y');



%% function


function y_table = smoothP(x)
    targetSampleRate = 50;
    [yy,ty] = resample([x.x, x.y, x.y_dot, x.Fx, x.Fy, x.Fx_Mea, x.Fy_Mea, x.q1, x.q2],x.Time,targetSampleRate,'linear');

    %vel
    yy(:,3) = smoothdata(yy(:,3),'movmean','SmoothingFactor',0.9,'SamplePoints',ty);

   
    %F_Mea
    yy(:,6) = smoothdata(-yy(:,6), 'movmean','SmoothingFactor',0.2,'SamplePoints',ty);
    yy(:,7) = smoothdata(-yy(:,7), 'movmean','SmoothingFactor',0.2,'SamplePoints',ty);
    

    %Scope
    ty = [0:1/targetSampleRate:4]';
    count = 1;
    for i = 1:length(yy)
        if yy(i,3) > 0
            y(count,:) = yy(i,:);
            count = count+1;
        end
    end

    y = y(150:350,:);

    y_table = table(ty, x.T1(1)*ones(length(ty),1), x.T2(1)*ones(length(ty),1), y(:,1), y(:,2), y(:,3), y(:,4), y(:,5), y(:,6), y(:,7), y(:,8), y(:,9), 'VariableNames', ["Time", "T1", "T2", "x", "y", "y_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea", "q1", "q2"]);

end

function y_table = smoothN(x)
    targetSampleRate = 50;
    [yy,ty] = resample([x.x, x.y, x.y_dot, x.Fx, x.Fy, x.Fx_Mea, x.Fy_Mea, x.q1, x.q2],x.Time,targetSampleRate,'linear');

    %vel
    yy(:,3) = smoothdata(yy(:,3),'movmean','SmoothingFactor',0.9,'SamplePoints',ty);

   
    %F_Mea
    yy(:,6) = smoothdata(-yy(:,6), 'movmean','SmoothingFactor',0.2,'SamplePoints',ty);
    yy(:,7) = smoothdata(-yy(:,7), 'movmean','SmoothingFactor',0.2,'SamplePoints',ty);
    

    %Scope
    ty = [0:1/targetSampleRate:4]';
    count = 1;
    for i = 1:length(yy)
        if yy(i,3) < 0
            y(count,:) = yy(i,:);
            count = count+1;
        end
    end

    y = y(150:350,:);

    y_table = table(ty, x.T1(1)*ones(length(ty),1), x.T2(1)*ones(length(ty),1), y(:,1), y(:,2), y(:,3), y(:,4), y(:,5), y(:,6), y(:,7), y(:,8), y(:,9), 'VariableNames', ["Time", "T1", "T2", "x", "y", "y_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea", "q1", "q2"]);

end



function y = findF(t1, t2, q1, q2, fun)
    for i = 1:length(q1)
        y(i) = fun(-1*t1,-1*t2,q1(i),q2(i));
    end
end



