clear
clc


%% Read data

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";

%Y010
T03_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T03.csv");
T30_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T30.csv");
T33_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T33.csv");
T0m3_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T0-3.csv");
Tm30_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T-30.csv");
Tm3m3_010 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y010/T-3-3.csv");


%Y015
T03_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T03.csv");
T30_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T30.csv");
T33_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T33.csv");
T0m3_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T0-3.csv");
Tm30_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T-30.csv");
Tm3m3_015 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y015/T-3-3.csv");

%Y020
T03_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T03.csv");
T30_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T30.csv");
T33_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T33.csv");
T0m3_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T0-3.csv");
Tm30_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T-30.csv");
Tm3m3_020 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y020/T-3-3.csv");


%Y025
T03_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T03.csv");
T30_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T30.csv");
T33_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T33.csv");
T0m3_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T0-3.csv");
Tm30_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T-30.csv");
Tm3m3_025 = readtable(mainpath+"/Desktop_Rehab/Record_Data/Y025/T-3-3.csv");



%% Smooth all

%Y010
T03_010_smooth = smoothP(T03_010);
T30_010_smooth = smoothP(T30_010);   
T33_010_smooth = smoothP(T33_010);
T0m3_010_smooth = smoothN(T0m3_010);
Tm30_010_smooth = smoothN(Tm30_010);
Tm3m3_010_smooth = smoothN(Tm3m3_010);


%Y015
T03_015_smooth = smoothP(T03_015);
T30_015_smooth = smoothP(T30_015);
T33_015_smooth = smoothP(T33_015);
T0m3_015_smooth = smoothN(T0m3_015);
Tm30_015_smooth = smoothN(Tm30_015);
Tm3m3_015_smooth = smoothN(Tm3m3_015);


%Y020
T03_020_smooth = smoothP(T03_020);
T30_020_smooth = smoothP(T30_020);
T33_020_smooth = smoothP(T33_020);
T0m3_020_smooth = smoothN(T0m3_020);
Tm30_020_smooth = smoothN(Tm30_020);
Tm3m3_020_smooth = smoothN(Tm3m3_020);


%Y025
T03_025_smooth = smoothP(T03_025);
T30_025_smooth = smoothP(T30_025);
T33_025_smooth = smoothP(T33_025);
T0m3_025_smooth = smoothN(T0m3_025);
Tm30_025_smooth = smoothN(Tm30_025);
Tm3m3_025_smooth = smoothN(Tm3m3_025);

%% Plots vs Time

figure()
sgtitle("T03 Y010")

subplot(2,2,1)
plot(T03_010_smooth.Time, T03_010_smooth.Fx_Mea)
title("Fx Smooth Recorded")
subplot(2,2,2)
plot(T03_010_smooth.Time, T03_010_smooth.Fy_Mea)
title("Fy Smooth Recorded")

subplot(2,2,3)
plot(T03_010_smooth.Time, T03_010_smooth.Fx)
title("Fx Theory")
subplot(2,2,4)
plot(T03_010_smooth.Time, T03_010_smooth.Fy)
title("Fy Theory")



figure()
sgtitle("T03 Y015")

subplot(2,2,1)
plot(T03_015_smooth.Time, T03_015_smooth.Fx_Mea)
title("Fx Smooth Recorded")
subplot(2,2,2)
plot(T03_010_smooth.Time, T03_015_smooth.Fy_Mea)
title("Fy Smooth Recorded")

subplot(2,2,3)
plot(T03_015_smooth.Time, T03_015_smooth.Fx)
title("Fx Theory")
subplot(2,2,4)
plot(T03_010_smooth.Time, T03_015_smooth.Fy)
title("Fy Theory")



figure()
sgtitle("T03 Y020")

subplot(2,2,1)
plot(T03_020_smooth.Time, T03_020_smooth.Fx_Mea)
title("Fx Smooth Recorded")
subplot(2,2,2)
plot(T03_010_smooth.Time, T03_020_smooth.Fy_Mea)
title("Fy Smooth Recorded")

subplot(2,2,3)
plot(T03_020_smooth.Time, T03_020_smooth.Fx)
title("Fx Theory")
subplot(2,2,4)
plot(T03_010_smooth.Time, T03_020_smooth.Fy)
title("Fy Theory")


figure()
sgtitle("T03 Y025")

subplot(2,2,1)
plot(T03_025_smooth.Time, T03_025_smooth.Fx_Mea)
title("Fx Smooth Recorded")
subplot(2,2,2)
plot(T03_010_smooth.Time, T03_025_smooth.Fy_Mea)
title("Fy Smooth Recorded")

subplot(2,2,3)
plot(T03_025_smooth.Time, T03_025_smooth.Fx)
title("Fx Theory")
subplot(2,2,4)
plot(T03_010_smooth.Time, T03_025_smooth.Fy)
title("Fy Theory")




%% Plot vs Time New

%Fx
figure()
sgtitle("Fx Y010")

subplot(2,3,1)
hold on
plot(T03_010_smooth.Time, T03_010_smooth.Fx_Mea)
plot(T03_010_smooth.Time, T03_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = 3 Nm")

subplot(2,3,2)
hold on
plot(T30_010_smooth.Time, T30_010_smooth.Fx_Mea)
plot(T30_010_smooth.Time, T30_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 0 Nm")

subplot(2,3,3)
hold on
plot(T33_010_smooth.Time, T33_010_smooth.Fx_Mea)
plot(T33_010_smooth.Time, T33_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 3 Nm")

subplot(2,3,4)
hold on
plot(T0m3_010_smooth.Time, T0m3_010_smooth.Fx_Mea)
plot(T0m3_010_smooth.Time, T0m3_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = -3 Nm")

subplot(2,3,5)
hold on
plot(Tm30_010_smooth.Time, Tm30_010_smooth.Fx_Mea)
plot(Tm30_010_smooth.Time, Tm30_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = 0 Nm")

subplot(2,3,6)
hold on
plot(Tm3m3_010_smooth.Time, Tm3m3_010_smooth.Fx_Mea)
plot(Tm3m3_010_smooth.Time, Tm3m3_010_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = -3 Nm")



figure()
sgtitle("Fx Y015")

subplot(2,3,1)
hold on
plot(T03_015_smooth.Time, T03_015_smooth.Fx_Mea)
plot(T03_015_smooth.Time, T03_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = 3 Nm")

subplot(2,3,2)
hold on
plot(T30_015_smooth.Time, T30_015_smooth.Fx_Mea)
plot(T30_015_smooth.Time, T30_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 0 Nm")

subplot(2,3,3)
hold on
plot(T33_015_smooth.Time, T33_015_smooth.Fx_Mea)
plot(T33_015_smooth.Time, T33_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 3 Nm")

subplot(2,3,4)
hold on
plot(T0m3_015_smooth.Time, T0m3_015_smooth.Fx_Mea)
plot(T0m3_015_smooth.Time, T0m3_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = -3 Nm")

subplot(2,3,5)
hold on
plot(Tm30_015_smooth.Time, Tm30_015_smooth.Fx_Mea)
plot(Tm30_015_smooth.Time, Tm30_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = 0 Nm")

subplot(2,3,6)
hold on
plot(Tm3m3_015_smooth.Time, Tm3m3_015_smooth.Fx_Mea)
plot(Tm3m3_015_smooth.Time, Tm3m3_015_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = -3 Nm")


figure()
sgtitle("Fx Y020")

subplot(2,3,1)
hold on
plot(T03_020_smooth.Time, T03_020_smooth.Fx_Mea)
plot(T03_020_smooth.Time, T03_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = 3 Nm")

subplot(2,3,2)
hold on
plot(T30_020_smooth.Time, T30_020_smooth.Fx_Mea)
plot(T30_020_smooth.Time, T30_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 0 Nm")

subplot(2,3,3)
hold on
plot(T33_020_smooth.Time, T33_020_smooth.Fx_Mea)
plot(T33_020_smooth.Time, T33_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 3 Nm")

subplot(2,3,4)
hold on
plot(T0m3_020_smooth.Time, T0m3_020_smooth.Fx_Mea)
plot(T0m3_020_smooth.Time, T0m3_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = -3 Nm")

subplot(2,3,5)
hold on
plot(Tm30_020_smooth.Time, Tm30_020_smooth.Fx_Mea)
plot(Tm30_020_smooth.Time, Tm30_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = 0 Nm")

subplot(2,3,6)
hold on
plot(Tm3m3_020_smooth.Time, Tm3m3_020_smooth.Fx_Mea)
plot(Tm3m3_020_smooth.Time, Tm3m3_020_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = -3 Nm")


figure()
sgtitle("Fx Y025")

subplot(2,3,1)
hold on
plot(T03_025_smooth.Time, T03_025_smooth.Fx_Mea)
plot(T03_025_smooth.Time, T03_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = 3 Nm")

subplot(2,3,2)
hold on
plot(T30_025_smooth.Time, T30_025_smooth.Fx_Mea)
plot(T30_025_smooth.Time, T30_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 0 Nm")

subplot(2,3,3)
hold on
plot(T33_025_smooth.Time, T33_025_smooth.Fx_Mea)
plot(T33_025_smooth.Time, T33_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 3 Nm, T2 = 3 Nm")

subplot(2,3,4)
hold on
plot(T0m3_025_smooth.Time, T0m3_025_smooth.Fx_Mea)
plot(T0m3_025_smooth.Time, T0m3_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = 0 Nm, T2 = -3 Nm")

subplot(2,3,5)
hold on
plot(Tm30_025_smooth.Time, Tm30_025_smooth.Fx_Mea)
plot(Tm30_025_smooth.Time, Tm30_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = 0 Nm")

subplot(2,3,6)
hold on
plot(Tm3m3_025_smooth.Time, Tm3m3_025_smooth.Fx_Mea)
plot(Tm3m3_025_smooth.Time, Tm3m3_025_smooth.Fx, 'LineWidth', 2)
hold off
legend(["Experiment", "Theory"])
title("T1 = -3 Nm, T2 = -3 Nm")


%% Sort X


%Y010
T03_010_sortX = sortrows(T03_010_smooth, 'x');
T30_010_sortX = sortrows(T30_010_smooth, 'x');   
T33_010_sortX = sortrows(T33_010_smooth, 'x');
T0m3_010_sortX = sortrows(T0m3_010_smooth, 'x');
Tm30_010_sortX = sortrows(Tm30_010_smooth, 'x');
Tm3m3_010_sortX = sortrows(Tm3m3_010_smooth, 'x');


%Y015
T03_015_sortX = sortrows(T03_015_smooth, 'x');
T30_015_sortX = sortrows(T30_015_smooth, 'x');
T33_015_sortX = sortrows(T33_015_smooth, 'x');
T0m3_015_sortX = sortrows(T0m3_015_smooth, 'x');
Tm30_015_sortX = sortrows(Tm30_015_smooth, 'x');
Tm3m3_015_sortX = sortrows(Tm3m3_015_smooth, 'x');


%Y020
T03_020_sortX = sortrows(T03_020_smooth, 'x');
T30_020_sortX = sortrows(T30_020_smooth, 'x');
T33_020_sortX = sortrows(T33_020_smooth, 'x');
T0m3_020_sortX = sortrows(T0m3_020_smooth, 'x');
Tm30_020_sortX = sortrows(Tm30_020_smooth, 'x');
Tm3m3_020_sortX = sortrows(Tm3m3_020_smooth, 'x');


%Y025
T03_025_sortX = sortrows(T03_025_smooth, 'x');
T30_025_sortX = sortrows(T30_025_smooth, 'x');
T33_025_sortX = sortrows(T33_025_smooth, 'x');
T0m3_025_sortX = sortrows(T0m3_025_smooth, 'x');
Tm30_025_sortX = sortrows(Tm30_025_smooth, 'x');
Tm3m3_025_sortX = sortrows(Tm3m3_025_smooth, 'x');

%% Plot vs X 

step_fplot = 0.005;

x_min = 0.25;
x_max = 0.36;

Q1_010 = ik1(x_min:step_fplot:x_max,0.10);
Q2_010 = ik2(x_min:step_fplot:x_max,0.10);
Q1_015 = ik1(x_min:step_fplot:x_max,0.15);
Q2_015 = ik2(x_min:step_fplot:x_max,0.15);
Q1_020 = ik1(x_min:step_fplot:x_max,0.20);
Q2_020 = ik2(x_min:step_fplot:x_max,0.20);
Q1_025 = ik1(x_min:step_fplot:x_max,0.25);
Q2_025 = ik2(x_min:step_fplot:x_max,0.25);

Q1_stack = {Q1_010, Q1_015, Q1_020, Q1_025};
Q2_stack = {Q2_010, Q2_015, Q2_020, Q2_025};

pos_name = [" Y010" " Y015" " Y020" "Y025"];

%T03
T03_sortX_stack = {T03_010_sortX, T03_015_sortX, T03_020_sortX, T03_025_sortX};
for i = 1:length(T03_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(T03_sortX_stack{1,i}.x, T03_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(T03_sortX_stack{1,i}.x, T03_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(T03_sortX_stack{1,i}.x, T03_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(T03_sortX_stack{1,i}.x, T03_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(-0, 1, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(-0, 1, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T03"+pos_name(i))
end



%T30
T30_sortX_stack = {T30_010_sortX, T30_015_sortX, T30_020_sortX, T30_025_sortX};
for i = 1:length(T30_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(T30_sortX_stack{1,i}.x, T30_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(T30_sortX_stack{1,i}.x, T30_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(T30_sortX_stack{1,i}.x, T30_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(T30_sortX_stack{1,i}.x, T30_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(1, 0, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(1, 0, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T30"+pos_name(i))
end


%T33
T33_sortX_stack = {T33_010_sortX, T33_015_sortX, T33_020_sortX, T33_025_sortX};
for i = 1:length(T33_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(T33_sortX_stack{1,i}.x, T33_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(T33_sortX_stack{1,i}.x, T33_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(T33_sortX_stack{1,i}.x, T33_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(T33_sortX_stack{1,i}.x, T33_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(1, 1, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(1, 1, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T33"+pos_name(i))
end


%T0m3
T0m3_sortX_stack = {T0m3_010_sortX, T0m3_015_sortX, T0m3_020_sortX, T0m3_025_sortX};
for i = 1:length(T0m3_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(T0m3_sortX_stack{1,i}.x, T0m3_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(T0m3_sortX_stack{1,i}.x, T0m3_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(T0m3_sortX_stack{1,i}.x, T0m3_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(T0m3_sortX_stack{1,i}.x, T0m3_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(0, -1, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(0, -1, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T0-3"+pos_name(i))

end



%Tm30
Tm30_sortX_stack = {Tm30_010_sortX, Tm30_015_sortX, Tm30_020_sortX, Tm30_025_sortX};
for i = 1:length(Tm30_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(Tm30_sortX_stack{1,i}.x, Tm30_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(Tm30_sortX_stack{1,i}.x, Tm30_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(Tm30_sortX_stack{1,i}.x, Tm30_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(Tm30_sortX_stack{1,i}.x, Tm30_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(-1, 0, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(-1, 0, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T-30"+pos_name(i))
end



%Tm3m3
Tm3m3_sortX_stack = {Tm3m3_010_sortX, Tm3m3_015_sortX, Tm3m3_020_sortX, Tm3m3_025_sortX};
for i = 1:length(Tm3m3_sortX_stack)
    figure()
    subplot(2,2,1)
    hold on
    scatter(Tm3m3_sortX_stack{1,i}.x, Tm3m3_sortX_stack{1,i}.Fx_Mea, 'filled')
    fit_Fx = polyval(polyfit(Tm3m3_sortX_stack{1,i}.x, Tm3m3_sortX_stack{1,i}.Fx_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fx, 'LineWidth', 2)
    title("Fx sortX")
    
    subplot(2,2,2)
    hold on
    scatter(Tm3m3_sortX_stack{1,i}.x, Tm3m3_sortX_stack{1,i}.Fy_Mea, 'filled')
    fit_Fy = polyval(polyfit(Tm3m3_sortX_stack{1,i}.x, Tm3m3_sortX_stack{1,i}.Fy_Mea,2), x_min:step_fplot:x_max);
    plot(x_min:step_fplot:x_max, fit_Fy, 'LineWidth', 2)
    hold off
    title("Fy sortX")
    
    subplot(2,2,3)
    plot(x_min:step_fplot:x_max, findF(-1, -1, Q1_stack{1,i}, Q2_stack{1,i}, Fx), 'LineWidth', 2)
    title("Fx Theory")
    
    subplot(2,2,4)
    plot(x_min:step_fplot:x_max, findF(-1, -1, Q1_stack{1,i}, Q2_stack{1,i}, Fy), 'LineWidth', 2)
    title("Fy Theory")

    sgtitle("T-3-3"+pos_name(i))
end




%% function


function y_table = smoothP(x)
    targetSampleRate = 50;
    [yy,ty] = resample([x.x, x.y, x.x_dot, x.Fx, x.Fy, x.Fx_Mea, x.Fy_Mea, x.q1, x.q2],x.Time,targetSampleRate,'linear');

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

    y_table = table(ty, x.T1(1)*ones(length(ty),1), x.T2(1)*ones(length(ty),1), y(:,1), y(:,2), y(:,3), y(:,4), y(:,5), y(:,6), y(:,7), y(:,8), y(:,9), 'VariableNames', ["Time", "T1", "T2", "x", "y", "x_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea", "q1", "q2"]);

end

function y_table = smoothN(x)
    targetSampleRate = 50;
    [yy,ty] = resample([x.x, x.y, x.x_dot, x.Fx, x.Fy, x.Fx_Mea, x.Fy_Mea, x.q1, x.q2],x.Time,targetSampleRate,'linear');

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

    y_table = table(ty, x.T1(1)*ones(length(ty),1), x.T2(1)*ones(length(ty),1), y(:,1), y(:,2), y(:,3), y(:,4), y(:,5), y(:,6), y(:,7), y(:,8), y(:,9), 'VariableNames', ["Time", "T1", "T2", "x", "y", "x_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea", "q1", "q2"]);

end



function y = findF(t1, t2, q1, q2, fun)
    for i = 1:length(q1)
        y(i) = fun(-3*t1,-3*t2,q1(i),q2(i));
    end
end



