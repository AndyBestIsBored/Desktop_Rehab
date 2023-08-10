clear
clc


%% Read data

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";

%X25_Y10
X25_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T02_Static.csv"));
X25_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T20_Static.csv"));
X25_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T22_Static.csv"));
X25_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T0-2_Static.csv"));
X25_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T-20_Static.csv"));
X25_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y10_T-2-2_Static.csv"));


%X25_Y13
X25_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T02_Static.csv"));
X25_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T20_Static.csv"));
X25_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T22_Static.csv"));
X25_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T0-2_Static.csv"));
X25_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T-20_Static.csv"));
X25_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y13_T-2-2_Static.csv"));


%X25_Y16
X25_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T02_Static.csv"));
X25_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T20_Static.csv"));
X25_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T22_Static.csv"));
X25_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T0-2_Static.csv"));
X25_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T-20_Static.csv"));
X25_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y16_T-2-2_Static.csv"));


%X25_Y19
X25_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T02_Static.csv"));
X25_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T20_Static.csv"));
X25_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T22_Static.csv"));
X25_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T0-2_Static.csv"));
X25_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T-20_Static.csv"));
X25_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X025/Y19_T-2-2_Static.csv"));



%% Stack


%T20
X25_T20_Fx = [X25_Y10_T20.Fx,X25_Y13_T20.Fx,X25_Y16_T20.Fx,X25_Y19_T20.Fx];
X25_T20_Fy = [X25_Y10_T20.Fy,X25_Y13_T20.Fy,X25_Y16_T20.Fy,X25_Y19_T20.Fy];
X25_T20_Fx_Mea = [X25_Y10_T20.Fx_Mea,X25_Y13_T20.Fx_Mea,X25_Y16_T20.Fx_Mea,X25_Y19_T20.Fx_Mea];
X25_T20_Fy_Mea = [X25_Y10_T20.Fy_Mea,X25_Y13_T20.Fy_Mea,X25_Y16_T20.Fy_Mea,X25_Y19_T20.Fy_Mea];

%T02
X25_T02_Fx = [X25_Y10_T02.Fx,X25_Y13_T02.Fx,X25_Y16_T02.Fx,X25_Y19_T02.Fx];
X25_T02_Fy = [X25_Y10_T02.Fy,X25_Y13_T02.Fy,X25_Y16_T02.Fy,X25_Y19_T02.Fy];
X25_T02_Fx_Mea = [X25_Y10_T02.Fx_Mea,X25_Y13_T02.Fx_Mea,X25_Y16_T02.Fx_Mea,X25_Y19_T02.Fx_Mea];
X25_T02_Fy_Mea = [X25_Y10_T02.Fy_Mea,X25_Y13_T02.Fy_Mea,X25_Y16_T02.Fy_Mea,X25_Y19_T02.Fy_Mea];

%T22
X25_T22_Fx = [X25_Y10_T22.Fx,X25_Y13_T22.Fx,X25_Y16_T22.Fx,X25_Y19_T22.Fx];
X25_T22_Fy = [X25_Y10_T22.Fy,X25_Y13_T22.Fy,X25_Y16_T22.Fy,X25_Y19_T22.Fy];
X25_T22_Fx_Mea = [X25_Y10_T22.Fx_Mea,X25_Y13_T22.Fx_Mea,X25_Y16_T22.Fx_Mea,X25_Y19_T22.Fx_Mea];
X25_T22_Fy_Mea = [X25_Y10_T22.Fy_Mea,X25_Y13_T22.Fy_Mea,X25_Y16_T22.Fy_Mea,X25_Y19_T22.Fy_Mea];

%Tm20
X25_Tm20_Fx = [X25_Y10_Tm20.Fx,X25_Y13_Tm20.Fx,X25_Y16_Tm20.Fx,X25_Y19_Tm20.Fx];
X25_Tm20_Fy = [X25_Y10_Tm20.Fy,X25_Y13_Tm20.Fy,X25_Y16_Tm20.Fy,X25_Y19_Tm20.Fy];
X25_Tm20_Fx_Mea = [X25_Y10_Tm20.Fx_Mea,X25_Y13_Tm20.Fx_Mea,X25_Y16_Tm20.Fx_Mea,X25_Y19_Tm20.Fx_Mea];
X25_Tm20_Fy_Mea = [X25_Y10_Tm20.Fy_Mea,X25_Y13_Tm20.Fy_Mea,X25_Y16_Tm20.Fy_Mea,X25_Y19_Tm20.Fy_Mea];

%T0m2
X25_T0m2_Fx = [X25_Y10_T0m2.Fx,X25_Y13_T0m2.Fx,X25_Y16_T0m2.Fx,X25_Y19_T0m2.Fx];
X25_T0m2_Fy = [X25_Y10_T0m2.Fy,X25_Y13_T0m2.Fy,X25_Y16_T0m2.Fy,X25_Y19_T0m2.Fy];
X25_T0m2_Fx_Mea = [X25_Y10_T0m2.Fx_Mea,X25_Y13_T0m2.Fx_Mea,X25_Y16_T0m2.Fx_Mea,X25_Y19_T0m2.Fx_Mea];
X25_T0m2_Fy_Mea = [X25_Y10_T0m2.Fy_Mea,X25_Y13_T0m2.Fy_Mea,X25_Y16_T0m2.Fy_Mea,X25_Y19_T0m2.Fy_Mea];

%Tm2m2
X25_Tm2m2_Fx = [X25_Y10_Tm2m2.Fx,X25_Y13_Tm2m2.Fx,X25_Y16_Tm2m2.Fx,X25_Y19_Tm2m2.Fx];
X25_Tm2m2_Fy = [X25_Y10_Tm2m2.Fy,X25_Y13_Tm2m2.Fy,X25_Y16_Tm2m2.Fy,X25_Y19_Tm2m2.Fy];
X25_Tm2m2_Fx_Mea = [X25_Y10_Tm2m2.Fx_Mea,X25_Y13_Tm2m2.Fx_Mea,X25_Y16_Tm2m2.Fx_Mea,X25_Y19_Tm2m2.Fx_Mea];
X25_Tm2m2_Fy_Mea = [X25_Y10_Tm2m2.Fy_Mea,X25_Y13_Tm2m2.Fy_Mea,X25_Y16_Tm2m2.Fy_Mea,X25_Y19_Tm2m2.Fy_Mea];


%%Stack
Fx_Stack = [X25_T20_Fx;X25_T02_Fx;X25_T22_Fx;X25_Tm20_Fx;X25_T0m2_Fx;X25_Tm2m2_Fx];
Fy_Stack = [X25_T20_Fy;X25_T02_Fy;X25_T22_Fy;X25_Tm20_Fy;X25_T0m2_Fy;X25_Tm2m2_Fy];
Fx_Mea_Stack = [X25_T20_Fx_Mea;X25_T02_Fx_Mea;X25_T22_Fx_Mea;X25_Tm20_Fx_Mea;X25_T0m2_Fx_Mea;X25_Tm2m2_Fx_Mea];
Fy_Mea_Stack = [X25_T20_Fy_Mea;X25_T02_Fy_Mea;X25_T22_Fy_Mea;X25_Tm20_Fy_Mea;X25_T0m2_Fy_Mea;X25_Tm2m2_Fy_Mea];


%% Plot

X25_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx")
for i = 1:length(Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X25_Y,Fx_Stack(i,:))
    plot(X25_Y,Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy")
for i = 1:length(Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X25_Y,Fy_Stack(i,:))
    plot(X25_Y,Fy_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end








%% Function

function y = process(x)
    Fx_real = x.Fy_Mea;
    Fy_real = -x.Fx_Mea;

    x.Fx_Mea = Fx_real;
    x.Fy_Mea = Fy_real;

    x = x(10:end-10,3:end);
    xx = mean(x{:,:});
    COLUMNS = ["T1", "T2", "t1", "t2", "q1", "q2", "x", "y", "x_dot", "y_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea"];
    y = array2table(xx,'VariableNames',COLUMNS);

end











