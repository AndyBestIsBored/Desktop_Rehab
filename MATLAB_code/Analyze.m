clear
clc


%% X25

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";

%-----Read data-----%

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


%-----Average data-----%

%X25_Y10
X25_Y10_T02_avg = avg(X25_Y10_T02);
X25_Y10_T20_avg = avg(X25_Y10_T20);
X25_Y10_T22_avg = avg(X25_Y10_T22);
X25_Y10_T0m2_avg = avg(X25_Y10_T0m2);
X25_Y10_Tm20_avg = avg(X25_Y10_Tm20);
X25_Y10_Tm2m2_avg = avg(X25_Y10_Tm2m2);


%X25_Y13
X25_Y13_T02_avg = avg(X25_Y13_T02);
X25_Y13_T20_avg = avg(X25_Y13_T20);
X25_Y13_T22_avg = avg(X25_Y13_T22);
X25_Y13_T0m2_avg = avg(X25_Y13_T0m2);
X25_Y13_Tm20_avg = avg(X25_Y13_Tm20);
X25_Y13_Tm2m2_avg = avg(X25_Y13_Tm2m2);


%X25_Y16
X25_Y16_T02_avg = avg(X25_Y16_T02);
X25_Y16_T20_avg = avg(X25_Y16_T20);
X25_Y16_T22_avg = avg(X25_Y16_T22);
X25_Y16_T0m2_avg = avg(X25_Y16_T0m2);
X25_Y16_Tm20_avg = avg(X25_Y16_Tm20);
X25_Y16_Tm2m2_avg = avg(X25_Y16_Tm2m2);


%X25_Y19
X25_Y19_T02_avg = avg(X25_Y19_T02);
X25_Y19_T20_avg = avg(X25_Y19_T20);
X25_Y19_T22_avg = avg(X25_Y19_T22);
X25_Y19_T0m2_avg = avg(X25_Y19_T0m2);
X25_Y19_Tm20_avg = avg(X25_Y19_Tm20);
X25_Y19_Tm2m2_avg = avg(X25_Y19_Tm2m2);

%-----Stack-----%
%T20
X25_T20_Fx_avg = [X25_Y10_T20_avg.Fx,X25_Y13_T20_avg.Fx,X25_Y16_T20_avg.Fx,X25_Y19_T20_avg.Fx];
X25_T20_Fy_avg = [X25_Y10_T20_avg.Fy,X25_Y13_T20_avg.Fy,X25_Y16_T20_avg.Fy,X25_Y19_T20_avg.Fy];
X25_T20_Fx_Mea_avg = [X25_Y10_T20_avg.Fx_Mea,X25_Y13_T20_avg.Fx_Mea,X25_Y16_T20_avg.Fx_Mea,X25_Y19_T20_avg.Fx_Mea];
X25_T20_Fy_Mea_avg = [X25_Y10_T20_avg.Fy_Mea,X25_Y13_T20_avg.Fy_Mea,X25_Y16_T20_avg.Fy_Mea,X25_Y19_T20_avg.Fy_Mea];

%T02
X25_T02_Fx_avg = [X25_Y10_T02_avg.Fx,X25_Y13_T02_avg.Fx,X25_Y16_T02_avg.Fx,X25_Y19_T02_avg.Fx];
X25_T02_Fy_avg = [X25_Y10_T02_avg.Fy,X25_Y13_T02_avg.Fy,X25_Y16_T02_avg.Fy,X25_Y19_T02_avg.Fy];
X25_T02_Fx_Mea_avg = [X25_Y10_T02_avg.Fx_Mea,X25_Y13_T02_avg.Fx_Mea,X25_Y16_T02_avg.Fx_Mea,X25_Y19_T02_avg.Fx_Mea];
X25_T02_Fy_Mea_avg = [X25_Y10_T02_avg.Fy_Mea,X25_Y13_T02_avg.Fy_Mea,X25_Y16_T02_avg.Fy_Mea,X25_Y19_T02_avg.Fy_Mea];

%T22
X25_T22_Fx_avg = [X25_Y10_T22_avg.Fx,X25_Y13_T22_avg.Fx,X25_Y16_T22_avg.Fx,X25_Y19_T22_avg.Fx];
X25_T22_Fy_avg = [X25_Y10_T22_avg.Fy,X25_Y13_T22_avg.Fy,X25_Y16_T22_avg.Fy,X25_Y19_T22_avg.Fy];
X25_T22_Fx_Mea_avg = [X25_Y10_T22_avg.Fx_Mea,X25_Y13_T22_avg.Fx_Mea,X25_Y16_T22_avg.Fx_Mea,X25_Y19_T22_avg.Fx_Mea];
X25_T22_Fy_Mea_avg = [X25_Y10_T22_avg.Fy_Mea,X25_Y13_T22_avg.Fy_Mea,X25_Y16_T22_avg.Fy_Mea,X25_Y19_T22_avg.Fy_Mea];

%Tm20
X25_Tm20_Fx_avg = [X25_Y10_Tm20_avg.Fx,X25_Y13_Tm20_avg.Fx,X25_Y16_Tm20_avg.Fx,X25_Y19_Tm20_avg.Fx];
X25_Tm20_Fy_avg = [X25_Y10_Tm20_avg.Fy,X25_Y13_Tm20_avg.Fy,X25_Y16_Tm20_avg.Fy,X25_Y19_Tm20_avg.Fy];
X25_Tm20_Fx_Mea_avg = [X25_Y10_Tm20_avg.Fx_Mea,X25_Y13_Tm20_avg.Fx_Mea,X25_Y16_Tm20_avg.Fx_Mea,X25_Y19_Tm20_avg.Fx_Mea];
X25_Tm20_Fy_Mea_avg = [X25_Y10_Tm20_avg.Fy_Mea,X25_Y13_Tm20_avg.Fy_Mea,X25_Y16_Tm20_avg.Fy_Mea,X25_Y19_Tm20_avg.Fy_Mea];

%T0m2
X25_T0m2_Fx_avg = [X25_Y10_T0m2_avg.Fx,X25_Y13_T0m2_avg.Fx,X25_Y16_T0m2_avg.Fx,X25_Y19_T0m2_avg.Fx];
X25_T0m2_Fy_avg = [X25_Y10_T0m2_avg.Fy,X25_Y13_T0m2_avg.Fy,X25_Y16_T0m2_avg.Fy,X25_Y19_T0m2_avg.Fy];
X25_T0m2_Fx_Mea_avg = [X25_Y10_T0m2_avg.Fx_Mea,X25_Y13_T0m2_avg.Fx_Mea,X25_Y16_T0m2_avg.Fx_Mea,X25_Y19_T0m2_avg.Fx_Mea];
X25_T0m2_Fy_Mea_avg = [X25_Y10_T0m2_avg.Fy_Mea,X25_Y13_T0m2_avg.Fy_Mea,X25_Y16_T0m2_avg.Fy_Mea,X25_Y19_T0m2_avg.Fy_Mea];

%Tm2m2
X25_Tm2m2_Fx_avg = [X25_Y10_Tm2m2_avg.Fx,X25_Y13_Tm2m2_avg.Fx,X25_Y16_Tm2m2_avg.Fx,X25_Y19_Tm2m2_avg.Fx];
X25_Tm2m2_Fy_avg = [X25_Y10_Tm2m2_avg.Fy,X25_Y13_Tm2m2_avg.Fy,X25_Y16_Tm2m2_avg.Fy,X25_Y19_Tm2m2_avg.Fy];
X25_Tm2m2_Fx_Mea_avg = [X25_Y10_Tm2m2_avg.Fx_Mea,X25_Y13_Tm2m2_avg.Fx_Mea,X25_Y16_Tm2m2_avg.Fx_Mea,X25_Y19_Tm2m2_avg.Fx_Mea];
X25_Tm2m2_Fy_Mea_avg = [X25_Y10_Tm2m2_avg.Fy_Mea,X25_Y13_Tm2m2_avg.Fy_Mea,X25_Y16_Tm2m2_avg.Fy_Mea,X25_Y19_Tm2m2_avg.Fy_Mea];


%%Stack
X25_Fx_Stack_avg = [X25_T20_Fx_avg; X25_T02_Fx_avg; X25_T22_Fx_avg; X25_Tm20_Fx_avg; X25_T0m2_Fx_avg; X25_Tm2m2_Fx_avg];
X25_Fy_Stack_avg = [X25_T20_Fy_avg; X25_T02_Fy_avg; X25_T22_Fy_avg; X25_Tm20_Fy_avg; X25_T0m2_Fy_avg; X25_Tm2m2_Fy_avg];
X25_Fx_Mea_Stack_avg = [X25_T20_Fx_Mea_avg; X25_T02_Fx_Mea_avg; X25_T22_Fx_Mea_avg; X25_Tm20_Fx_Mea_avg; X25_T0m2_Fx_Mea_avg; X25_Tm2m2_Fx_Mea_avg];
X25_Fy_Mea_Stack_avg = [X25_T20_Fy_Mea_avg; X25_T02_Fy_Mea_avg; X25_T22_Fy_Mea_avg; X25_Tm20_Fy_Mea_avg; X25_T0m2_Fy_Mea_avg; X25_Tm2m2_Fy_Mea_avg];



%-----Plot-----%

X25_Y_avg = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X25")
for i = 1:length(X25_Fx_Stack_avg)
    subplot(2,3,i)
    hold on
    plot(X25_Y_avg,X25_Fx_Stack_avg(i,:))
    plot(X25_Y_avg,X25_Fx_Mea_Stack_avg(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X25")
for i = 1:length(X25_Fy_Stack_avg)
    subplot(2,3,i)
    hold on
    plot(X25_Y_avg,X25_Fy_Stack_avg(i,:))
    plot(X25_Y_avg,X25_Fy_Mea_Stack_avg(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end


%% X28

%-----Read data-----%
%X28_Y10
X28_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T02_Static.csv"));
X28_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T20_Static.csv"));
X28_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T22_Static.csv"));
X28_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T0-2_Static.csv"));
X28_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T-20_Static.csv"));
X28_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y10_T-2-2_Static.csv"));


%X28_Y13
X28_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T02_Static.csv"));
X28_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T20_Static.csv"));
X28_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T22_Static.csv"));
X28_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T0-2_Static.csv"));
X28_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T-20_Static.csv"));
X28_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y13_T-2-2_Static.csv"));


%X28_Y16
X28_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T02_Static.csv"));
X28_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T20_Static.csv"));
X28_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T22_Static.csv"));
X28_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T0-2_Static.csv"));
X28_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T-20_Static.csv"));
X28_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y16_T-2-2_Static.csv"));


%X28_Y19
X28_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T02_Static.csv"));
X28_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T20_Static.csv"));
X28_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T22_Static.csv"));
X28_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T0-2_Static.csv"));
X28_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T-20_Static.csv"));
X28_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X028/Y19_T-2-2_Static.csv"));


%-----Stack-----%
%T20
X28_T20_Fx = [X28_Y10_T20.Fx,X28_Y13_T20.Fx,X28_Y16_T20.Fx,X28_Y19_T20.Fx];
X28_T20_Fy = [X28_Y10_T20.Fy,X28_Y13_T20.Fy,X28_Y16_T20.Fy,X28_Y19_T20.Fy];
X28_T20_Fx_Mea = [X28_Y10_T20.Fx_Mea,X28_Y13_T20.Fx_Mea,X28_Y16_T20.Fx_Mea,X28_Y19_T20.Fx_Mea];
X28_T20_Fy_Mea = [X28_Y10_T20.Fy_Mea,X28_Y13_T20.Fy_Mea,X28_Y16_T20.Fy_Mea,X28_Y19_T20.Fy_Mea];

%T02
X28_T02_Fx = [X28_Y10_T02.Fx,X28_Y13_T02.Fx,X28_Y16_T02.Fx,X28_Y19_T02.Fx];
X28_T02_Fy = [X28_Y10_T02.Fy,X28_Y13_T02.Fy,X28_Y16_T02.Fy,X28_Y19_T02.Fy];
X28_T02_Fx_Mea = [X28_Y10_T02.Fx_Mea,X28_Y13_T02.Fx_Mea,X28_Y16_T02.Fx_Mea,X28_Y19_T02.Fx_Mea];
X28_T02_Fy_Mea = [X28_Y10_T02.Fy_Mea,X28_Y13_T02.Fy_Mea,X28_Y16_T02.Fy_Mea,X28_Y19_T02.Fy_Mea];

%T22
X28_T22_Fx = [X28_Y10_T22.Fx,X28_Y13_T22.Fx,X28_Y16_T22.Fx,X28_Y19_T22.Fx];
X28_T22_Fy = [X28_Y10_T22.Fy,X28_Y13_T22.Fy,X28_Y16_T22.Fy,X28_Y19_T22.Fy];
X28_T22_Fx_Mea = [X28_Y10_T22.Fx_Mea,X28_Y13_T22.Fx_Mea,X28_Y16_T22.Fx_Mea,X28_Y19_T22.Fx_Mea];
X28_T22_Fy_Mea = [X28_Y10_T22.Fy_Mea,X28_Y13_T22.Fy_Mea,X28_Y16_T22.Fy_Mea,X28_Y19_T22.Fy_Mea];

%Tm20
X28_Tm20_Fx = [X28_Y10_Tm20.Fx,X28_Y13_Tm20.Fx,X28_Y16_Tm20.Fx,X28_Y19_Tm20.Fx];
X28_Tm20_Fy = [X28_Y10_Tm20.Fy,X28_Y13_Tm20.Fy,X28_Y16_Tm20.Fy,X28_Y19_Tm20.Fy];
X28_Tm20_Fx_Mea = [X28_Y10_Tm20.Fx_Mea,X28_Y13_Tm20.Fx_Mea,X28_Y16_Tm20.Fx_Mea,X28_Y19_Tm20.Fx_Mea];
X28_Tm20_Fy_Mea = [X28_Y10_Tm20.Fy_Mea,X28_Y13_Tm20.Fy_Mea,X28_Y16_Tm20.Fy_Mea,X28_Y19_Tm20.Fy_Mea];

%T0m2
X28_T0m2_Fx = [X28_Y10_T0m2.Fx,X28_Y13_T0m2.Fx,X28_Y16_T0m2.Fx,X28_Y19_T0m2.Fx];
X28_T0m2_Fy = [X28_Y10_T0m2.Fy,X28_Y13_T0m2.Fy,X28_Y16_T0m2.Fy,X28_Y19_T0m2.Fy];
X28_T0m2_Fx_Mea = [X28_Y10_T0m2.Fx_Mea,X28_Y13_T0m2.Fx_Mea,X28_Y16_T0m2.Fx_Mea,X28_Y19_T0m2.Fx_Mea];
X28_T0m2_Fy_Mea = [X28_Y10_T0m2.Fy_Mea,X28_Y13_T0m2.Fy_Mea,X28_Y16_T0m2.Fy_Mea,X28_Y19_T0m2.Fy_Mea];

%Tm2m2
X28_Tm2m2_Fx = [X28_Y10_Tm2m2.Fx,X28_Y13_Tm2m2.Fx,X28_Y16_Tm2m2.Fx,X28_Y19_Tm2m2.Fx];
X28_Tm2m2_Fy = [X28_Y10_Tm2m2.Fy,X28_Y13_Tm2m2.Fy,X28_Y16_Tm2m2.Fy,X28_Y19_Tm2m2.Fy];
X28_Tm2m2_Fx_Mea = [X28_Y10_Tm2m2.Fx_Mea,X28_Y13_Tm2m2.Fx_Mea,X28_Y16_Tm2m2.Fx_Mea,X28_Y19_Tm2m2.Fx_Mea];
X28_Tm2m2_Fy_Mea = [X28_Y10_Tm2m2.Fy_Mea,X28_Y13_Tm2m2.Fy_Mea,X28_Y16_Tm2m2.Fy_Mea,X28_Y19_Tm2m2.Fy_Mea];


%%Stack
X28_Fx_Stack = [X28_T20_Fx;X28_T02_Fx;X28_T22_Fx;X28_Tm20_Fx;X28_T0m2_Fx;X28_Tm2m2_Fx];
X28_Fy_Stack = [X28_T20_Fy;X28_T02_Fy;X28_T22_Fy;X28_Tm20_Fy;X28_T0m2_Fy;X28_Tm2m2_Fy];
X28_Fx_Mea_Stack = [X28_T20_Fx_Mea;X28_T02_Fx_Mea;X28_T22_Fx_Mea;X28_Tm20_Fx_Mea;X28_T0m2_Fx_Mea;X28_Tm2m2_Fx_Mea];
X28_Fy_Mea_Stack = [X28_T20_Fy_Mea;X28_T02_Fy_Mea;X28_T22_Fy_Mea;X28_Tm20_Fy_Mea;X28_T0m2_Fy_Mea;X28_Tm2m2_Fy_Mea];


%-----Plot-----%
X28_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X28")
for i = 1:length(X28_Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X28_Y,X28_Fx_Stack(i,:))
    plot(X28_Y,X28_Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X28")
for i = 1:length(X28_Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X28_Y,X28_Fy_Stack(i,:))
    plot(X28_Y,X28_Fy_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end



%% X31

%-----Read data-----%
%X31_Y10
X31_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T02_Static.csv"));
X31_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T20_Static.csv"));
X31_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T22_Static.csv"));
X31_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T0-2_Static.csv"));
X31_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T-20_Static.csv"));
X31_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y10_T-2-2_Static.csv"));


%X31_Y13
X31_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T02_Static.csv"));
X31_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T20_Static.csv"));
X31_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T22_Static.csv"));
X31_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T0-2_Static.csv"));
X31_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T-20_Static.csv"));
X31_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y13_T-2-2_Static.csv"));


%X31_Y16
X31_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T02_Static.csv"));
X31_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T20_Static.csv"));
X31_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T22_Static.csv"));
X31_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T0-2_Static.csv"));
X31_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T-20_Static.csv"));
X31_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y16_T-2-2_Static.csv"));


%X31_Y19
X31_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T02_Static.csv"));
X31_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T20_Static.csv"));
X31_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T22_Static.csv"));
X31_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T0-2_Static.csv"));
X31_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T-20_Static.csv"));
X31_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X031/Y19_T-2-2_Static.csv"));



%-----Stack-----%
%T20
X31_T20_Fx = [X31_Y10_T20.Fx,X31_Y13_T20.Fx,X31_Y16_T20.Fx,X31_Y19_T20.Fx];
X31_T20_Fy = [X31_Y10_T20.Fy,X31_Y13_T20.Fy,X31_Y16_T20.Fy,X31_Y19_T20.Fy];
X31_T20_Fx_Mea = [X31_Y10_T20.Fx_Mea,X31_Y13_T20.Fx_Mea,X31_Y16_T20.Fx_Mea,X31_Y19_T20.Fx_Mea];
X31_T20_Fy_Mea = [X31_Y10_T20.Fy_Mea,X31_Y13_T20.Fy_Mea,X31_Y16_T20.Fy_Mea,X31_Y19_T20.Fy_Mea];

%T02
X31_T02_Fx = [X31_Y10_T02.Fx,X31_Y13_T02.Fx,X31_Y16_T02.Fx,X31_Y19_T02.Fx];
X31_T02_Fy = [X31_Y10_T02.Fy,X31_Y13_T02.Fy,X31_Y16_T02.Fy,X31_Y19_T02.Fy];
X31_T02_Fx_Mea = [X31_Y10_T02.Fx_Mea,X31_Y13_T02.Fx_Mea,X31_Y16_T02.Fx_Mea,X31_Y19_T02.Fx_Mea];
X31_T02_Fy_Mea = [X31_Y10_T02.Fy_Mea,X31_Y13_T02.Fy_Mea,X31_Y16_T02.Fy_Mea,X31_Y19_T02.Fy_Mea];

%T22
X31_T22_Fx = [X31_Y10_T22.Fx,X31_Y13_T22.Fx,X31_Y16_T22.Fx,X31_Y19_T22.Fx];
X31_T22_Fy = [X31_Y10_T22.Fy,X31_Y13_T22.Fy,X31_Y16_T22.Fy,X31_Y19_T22.Fy];
X31_T22_Fx_Mea = [X31_Y10_T22.Fx_Mea,X31_Y13_T22.Fx_Mea,X31_Y16_T22.Fx_Mea,X31_Y19_T22.Fx_Mea];
X31_T22_Fy_Mea = [X31_Y10_T22.Fy_Mea,X31_Y13_T22.Fy_Mea,X31_Y16_T22.Fy_Mea,X31_Y19_T22.Fy_Mea];

%Tm20
X31_Tm20_Fx = [X31_Y10_Tm20.Fx,X31_Y13_Tm20.Fx,X31_Y16_Tm20.Fx,X31_Y19_Tm20.Fx];
X31_Tm20_Fy = [X31_Y10_Tm20.Fy,X31_Y13_Tm20.Fy,X31_Y16_Tm20.Fy,X31_Y19_Tm20.Fy];
X31_Tm20_Fx_Mea = [X31_Y10_Tm20.Fx_Mea,X31_Y13_Tm20.Fx_Mea,X31_Y16_Tm20.Fx_Mea,X31_Y19_Tm20.Fx_Mea];
X31_Tm20_Fy_Mea = [X31_Y10_Tm20.Fy_Mea,X31_Y13_Tm20.Fy_Mea,X31_Y16_Tm20.Fy_Mea,X31_Y19_Tm20.Fy_Mea];

%T0m2
X31_T0m2_Fx = [X31_Y10_T0m2.Fx,X31_Y13_T0m2.Fx,X31_Y16_T0m2.Fx,X31_Y19_T0m2.Fx];
X31_T0m2_Fy = [X31_Y10_T0m2.Fy,X31_Y13_T0m2.Fy,X31_Y16_T0m2.Fy,X31_Y19_T0m2.Fy];
X31_T0m2_Fx_Mea = [X31_Y10_T0m2.Fx_Mea,X31_Y13_T0m2.Fx_Mea,X31_Y16_T0m2.Fx_Mea,X31_Y19_T0m2.Fx_Mea];
X31_T0m2_Fy_Mea = [X31_Y10_T0m2.Fy_Mea,X31_Y13_T0m2.Fy_Mea,X31_Y16_T0m2.Fy_Mea,X31_Y19_T0m2.Fy_Mea];

%Tm2m2
X31_Tm2m2_Fx = [X31_Y10_Tm2m2.Fx,X31_Y13_Tm2m2.Fx,X31_Y16_Tm2m2.Fx,X31_Y19_Tm2m2.Fx];
X31_Tm2m2_Fy = [X31_Y10_Tm2m2.Fy,X31_Y13_Tm2m2.Fy,X31_Y16_Tm2m2.Fy,X31_Y19_Tm2m2.Fy];
X31_Tm2m2_Fx_Mea = [X31_Y10_Tm2m2.Fx_Mea,X31_Y13_Tm2m2.Fx_Mea,X31_Y16_Tm2m2.Fx_Mea,X31_Y19_Tm2m2.Fx_Mea];
X31_Tm2m2_Fy_Mea = [X31_Y10_Tm2m2.Fy_Mea,X31_Y13_Tm2m2.Fy_Mea,X31_Y16_Tm2m2.Fy_Mea,X31_Y19_Tm2m2.Fy_Mea];


%%Stack
X31_Fx_Stack = [X31_T20_Fx;X31_T02_Fx;X31_T22_Fx;X31_Tm20_Fx;X31_T0m2_Fx;X31_Tm2m2_Fx];
X31_Fy_Stack = [X31_T20_Fy;X31_T02_Fy;X31_T22_Fy;X31_Tm20_Fy;X31_T0m2_Fy;X31_Tm2m2_Fy];
X31_Fx_Mea_Stack = [X31_T20_Fx_Mea;X31_T02_Fx_Mea;X31_T22_Fx_Mea;X31_Tm20_Fx_Mea;X31_T0m2_Fx_Mea;X31_Tm2m2_Fx_Mea];
X31_Fy_Mea_Stack = [X31_T20_Fy_Mea;X31_T02_Fy_Mea;X31_T22_Fy_Mea;X31_Tm20_Fy_Mea;X31_T0m2_Fy_Mea;X31_Tm2m2_Fy_Mea];


%-----Plot-----%
X31_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X31")
for i = 1:length(X31_Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X31_Y,X31_Fx_Stack(i,:))
    plot(X31_Y,X31_Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X31")
for i = 1:length(X31_Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X31_Y,X31_Fy_Stack(i,:))
    plot(X31_Y,X31_Fy_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end




%% X34

%-----Read data-----%
%X34_Y10
X34_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T02_Static.csv"));
X34_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T20_Static.csv"));
X34_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T22_Static.csv"));
X34_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T0-2_Static.csv"));
X34_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T-20_Static.csv"));
X34_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y10_T-2-2_Static.csv"));


%X34_Y13
X34_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T02_Static.csv"));
X34_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T20_Static.csv"));
X34_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T22_Static.csv"));
X34_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T0-2_Static.csv"));
X34_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T-20_Static.csv"));
X34_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y13_T-2-2_Static.csv"));


%X34_Y16
X34_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T02_Static.csv"));
X34_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T20_Static.csv"));
X34_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T22_Static.csv"));
X34_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T0-2_Static.csv"));
X34_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T-20_Static.csv"));
X34_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y16_T-2-2_Static.csv"));


%X34_Y19
X34_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T02_Static.csv"));
X34_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T20_Static.csv"));
X34_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T22_Static.csv"));
X34_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T0-2_Static.csv"));
X34_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T-20_Static.csv"));
X34_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X034/Y19_T-2-2_Static.csv"));


%-----Stack-----%
%T20
X34_T20_Fx = [X34_Y10_T20.Fx,X34_Y13_T20.Fx,X34_Y16_T20.Fx,X34_Y19_T20.Fx];
X34_T20_Fy = [X34_Y10_T20.Fy,X34_Y13_T20.Fy,X34_Y16_T20.Fy,X34_Y19_T20.Fy];
X34_T20_Fx_Mea = [X34_Y10_T20.Fx_Mea,X34_Y13_T20.Fx_Mea,X34_Y16_T20.Fx_Mea,X34_Y19_T20.Fx_Mea];
X34_T20_Fy_Mea = [X34_Y10_T20.Fy_Mea,X34_Y13_T20.Fy_Mea,X34_Y16_T20.Fy_Mea,X34_Y19_T20.Fy_Mea];

%T02
X34_T02_Fx = [X34_Y10_T02.Fx,X34_Y13_T02.Fx,X34_Y16_T02.Fx,X34_Y19_T02.Fx];
X34_T02_Fy = [X34_Y10_T02.Fy,X34_Y13_T02.Fy,X34_Y16_T02.Fy,X34_Y19_T02.Fy];
X34_T02_Fx_Mea = [X34_Y10_T02.Fx_Mea,X34_Y13_T02.Fx_Mea,X34_Y16_T02.Fx_Mea,X34_Y19_T02.Fx_Mea];
X34_T02_Fy_Mea = [X34_Y10_T02.Fy_Mea,X34_Y13_T02.Fy_Mea,X34_Y16_T02.Fy_Mea,X34_Y19_T02.Fy_Mea];

%T22
X34_T22_Fx = [X34_Y10_T22.Fx,X34_Y13_T22.Fx,X34_Y16_T22.Fx,X34_Y19_T22.Fx];
X34_T22_Fy = [X34_Y10_T22.Fy,X34_Y13_T22.Fy,X34_Y16_T22.Fy,X34_Y19_T22.Fy];
X34_T22_Fx_Mea = [X34_Y10_T22.Fx_Mea,X34_Y13_T22.Fx_Mea,X34_Y16_T22.Fx_Mea,X34_Y19_T22.Fx_Mea];
X34_T22_Fy_Mea = [X34_Y10_T22.Fy_Mea,X34_Y13_T22.Fy_Mea,X34_Y16_T22.Fy_Mea,X34_Y19_T22.Fy_Mea];

%Tm20
X34_Tm20_Fx = [X34_Y10_Tm20.Fx,X34_Y13_Tm20.Fx,X34_Y16_Tm20.Fx,X34_Y19_Tm20.Fx];
X34_Tm20_Fy = [X34_Y10_Tm20.Fy,X34_Y13_Tm20.Fy,X34_Y16_Tm20.Fy,X34_Y19_Tm20.Fy];
X34_Tm20_Fx_Mea = [X34_Y10_Tm20.Fx_Mea,X34_Y13_Tm20.Fx_Mea,X34_Y16_Tm20.Fx_Mea,X34_Y19_Tm20.Fx_Mea];
X34_Tm20_Fy_Mea = [X34_Y10_Tm20.Fy_Mea,X34_Y13_Tm20.Fy_Mea,X34_Y16_Tm20.Fy_Mea,X34_Y19_Tm20.Fy_Mea];

%T0m2
X34_T0m2_Fx = [X34_Y10_T0m2.Fx,X34_Y13_T0m2.Fx,X34_Y16_T0m2.Fx,X34_Y19_T0m2.Fx];
X34_T0m2_Fy = [X34_Y10_T0m2.Fy,X34_Y13_T0m2.Fy,X34_Y16_T0m2.Fy,X34_Y19_T0m2.Fy];
X34_T0m2_Fx_Mea = [X34_Y10_T0m2.Fx_Mea,X34_Y13_T0m2.Fx_Mea,X34_Y16_T0m2.Fx_Mea,X34_Y19_T0m2.Fx_Mea];
X34_T0m2_Fy_Mea = [X34_Y10_T0m2.Fy_Mea,X34_Y13_T0m2.Fy_Mea,X34_Y16_T0m2.Fy_Mea,X34_Y19_T0m2.Fy_Mea];

%Tm2m2
X34_Tm2m2_Fx = [X34_Y10_Tm2m2.Fx,X34_Y13_Tm2m2.Fx,X34_Y16_Tm2m2.Fx,X34_Y19_Tm2m2.Fx];
X34_Tm2m2_Fy = [X34_Y10_Tm2m2.Fy,X34_Y13_Tm2m2.Fy,X34_Y16_Tm2m2.Fy,X34_Y19_Tm2m2.Fy];
X34_Tm2m2_Fx_Mea = [X34_Y10_Tm2m2.Fx_Mea,X34_Y13_Tm2m2.Fx_Mea,X34_Y16_Tm2m2.Fx_Mea,X34_Y19_Tm2m2.Fx_Mea];
X34_Tm2m2_Fy_Mea = [X34_Y10_Tm2m2.Fy_Mea,X34_Y13_Tm2m2.Fy_Mea,X34_Y16_Tm2m2.Fy_Mea,X34_Y19_Tm2m2.Fy_Mea];


%%Stack
X34_Fx_Stack = [X34_T20_Fx;X34_T02_Fx;X34_T22_Fx;X34_Tm20_Fx;X34_T0m2_Fx;X34_Tm2m2_Fx];
X34_Fy_Stack = [X34_T20_Fy;X34_T02_Fy;X34_T22_Fy;X34_Tm20_Fy;X34_T0m2_Fy;X34_Tm2m2_Fy];
X34_Fx_Mea_Stack = [X34_T20_Fx_Mea;X34_T02_Fx_Mea;X34_T22_Fx_Mea;X34_Tm20_Fx_Mea;X34_T0m2_Fx_Mea;X34_Tm2m2_Fx_Mea];
X34_Fy_Mea_Stack = [X34_T20_Fy_Mea;X34_T02_Fy_Mea;X34_T22_Fy_Mea;X34_Tm20_Fy_Mea;X34_T0m2_Fy_Mea;X34_Tm2m2_Fy_Mea];


%-----Plot-----%
X34_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X34")
for i = 1:length(X34_Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X34_Y,X34_Fx_Stack(i,:))
    plot(X34_Y,X34_Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X34")
for i = 1:length(X34_Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X34_Y,X34_Fy_Stack(i,:))
    plot(X34_Y,X34_Fy_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end





%% X37

%-----Read data-----%
%X37_Y10
X37_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T02_Static.csv"));
X37_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T20_Static.csv"));
X37_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T22_Static.csv"));
X37_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T0-2_Static.csv"));
X37_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T-20_Static.csv"));
X37_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y10_T-2-2_Static.csv"));


%X37_Y13
X37_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T02_Static.csv"));
X37_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T20_Static.csv"));
X37_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T22_Static.csv"));
X37_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T0-2_Static.csv"));
X37_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T-20_Static.csv"));
X37_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y13_T-2-2_Static.csv"));


%X37_Y16
X37_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T02_Static.csv"));
X37_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T20_Static.csv"));
X37_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T22_Static.csv"));
X37_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T0-2_Static.csv"));
X37_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T-20_Static.csv"));
X37_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y16_T-2-2_Static.csv"));


%X37_Y19
X37_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T02_Static.csv"));
X37_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T20_Static.csv"));
X37_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T22_Static.csv"));
X37_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T0-2_Static.csv"));
X37_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T-20_Static.csv"));
X37_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X037/Y19_T-2-2_Static.csv"));


%-----Stack-----%
%T20
X37_T20_Fx = [X37_Y10_T20.Fx,X37_Y13_T20.Fx,X37_Y16_T20.Fx,X37_Y19_T20.Fx];
X37_T20_Fy = [X37_Y10_T20.Fy,X37_Y13_T20.Fy,X37_Y16_T20.Fy,X37_Y19_T20.Fy];
X37_T20_Fx_Mea = [X37_Y10_T20.Fx_Mea,X37_Y13_T20.Fx_Mea,X37_Y16_T20.Fx_Mea,X37_Y19_T20.Fx_Mea];
X37_T20_Fy_Mea = [X37_Y10_T20.Fy_Mea,X37_Y13_T20.Fy_Mea,X37_Y16_T20.Fy_Mea,X37_Y19_T20.Fy_Mea];

%T02
X37_T02_Fx = [X37_Y10_T02.Fx,X37_Y13_T02.Fx,X37_Y16_T02.Fx,X37_Y19_T02.Fx];
X37_T02_Fy = [X37_Y10_T02.Fy,X37_Y13_T02.Fy,X37_Y16_T02.Fy,X37_Y19_T02.Fy];
X37_T02_Fx_Mea = [X37_Y10_T02.Fx_Mea,X37_Y13_T02.Fx_Mea,X37_Y16_T02.Fx_Mea,X37_Y19_T02.Fx_Mea];
X37_T02_Fy_Mea = [X37_Y10_T02.Fy_Mea,X37_Y13_T02.Fy_Mea,X37_Y16_T02.Fy_Mea,X37_Y19_T02.Fy_Mea];

%T22
X37_T22_Fx = [X37_Y10_T22.Fx,X37_Y13_T22.Fx,X37_Y16_T22.Fx,X37_Y19_T22.Fx];
X37_T22_Fy = [X37_Y10_T22.Fy,X37_Y13_T22.Fy,X37_Y16_T22.Fy,X37_Y19_T22.Fy];
X37_T22_Fx_Mea = [X37_Y10_T22.Fx_Mea,X37_Y13_T22.Fx_Mea,X37_Y16_T22.Fx_Mea,X37_Y19_T22.Fx_Mea];
X37_T22_Fy_Mea = [X37_Y10_T22.Fy_Mea,X37_Y13_T22.Fy_Mea,X37_Y16_T22.Fy_Mea,X37_Y19_T22.Fy_Mea];

%Tm20
X37_Tm20_Fx = [X37_Y10_Tm20.Fx,X37_Y13_Tm20.Fx,X37_Y16_Tm20.Fx,X37_Y19_Tm20.Fx];
X37_Tm20_Fy = [X37_Y10_Tm20.Fy,X37_Y13_Tm20.Fy,X37_Y16_Tm20.Fy,X37_Y19_Tm20.Fy];
X37_Tm20_Fx_Mea = [X37_Y10_Tm20.Fx_Mea,X37_Y13_Tm20.Fx_Mea,X37_Y16_Tm20.Fx_Mea,X37_Y19_Tm20.Fx_Mea];
X37_Tm20_Fy_Mea = [X37_Y10_Tm20.Fy_Mea,X37_Y13_Tm20.Fy_Mea,X37_Y16_Tm20.Fy_Mea,X37_Y19_Tm20.Fy_Mea];

%T0m2
X37_T0m2_Fx = [X37_Y10_T0m2.Fx,X37_Y13_T0m2.Fx,X37_Y16_T0m2.Fx,X37_Y19_T0m2.Fx];
X37_T0m2_Fy = [X37_Y10_T0m2.Fy,X37_Y13_T0m2.Fy,X37_Y16_T0m2.Fy,X37_Y19_T0m2.Fy];
X37_T0m2_Fx_Mea = [X37_Y10_T0m2.Fx_Mea,X37_Y13_T0m2.Fx_Mea,X37_Y16_T0m2.Fx_Mea,X37_Y19_T0m2.Fx_Mea];
X37_T0m2_Fy_Mea = [X37_Y10_T0m2.Fy_Mea,X37_Y13_T0m2.Fy_Mea,X37_Y16_T0m2.Fy_Mea,X37_Y19_T0m2.Fy_Mea];

%Tm2m2
X37_Tm2m2_Fx = [X37_Y10_Tm2m2.Fx,X37_Y13_Tm2m2.Fx,X37_Y16_Tm2m2.Fx,X37_Y19_Tm2m2.Fx];
X37_Tm2m2_Fy = [X37_Y10_Tm2m2.Fy,X37_Y13_Tm2m2.Fy,X37_Y16_Tm2m2.Fy,X37_Y19_Tm2m2.Fy];
X37_Tm2m2_Fx_Mea = [X37_Y10_Tm2m2.Fx_Mea,X37_Y13_Tm2m2.Fx_Mea,X37_Y16_Tm2m2.Fx_Mea,X37_Y19_Tm2m2.Fx_Mea];
X37_Tm2m2_Fy_Mea = [X37_Y10_Tm2m2.Fy_Mea,X37_Y13_Tm2m2.Fy_Mea,X37_Y16_Tm2m2.Fy_Mea,X37_Y19_Tm2m2.Fy_Mea];


%%Stack
X37_Fx_Stack = [X37_T20_Fx;X37_T02_Fx;X37_T22_Fx;X37_Tm20_Fx;X37_T0m2_Fx;X37_Tm2m2_Fx];
X37_Fy_Stack = [X37_T20_Fy;X37_T02_Fy;X37_T22_Fy;X37_Tm20_Fy;X37_T0m2_Fy;X37_Tm2m2_Fy];
X37_Fx_Mea_Stack = [X37_T20_Fx_Mea;X37_T02_Fx_Mea;X37_T22_Fx_Mea;X37_Tm20_Fx_Mea;X37_T0m2_Fx_Mea;X37_Tm2m2_Fx_Mea];
X37_Fy_Mea_Stack = [X37_T20_Fy_Mea;X37_T02_Fy_Mea;X37_T22_Fy_Mea;X37_Tm20_Fy_Mea;X37_T0m2_Fy_Mea;X37_Tm2m2_Fy_Mea];


%-----Plot-----%
X37_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X37")
for i = 1:length(X37_Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X37_Y,X37_Fx_Stack(i,:))
    plot(X37_Y,X37_Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X37")
for i = 1:length(X37_Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X37_Y,X37_Fy_Stack(i,:))
    plot(X37_Y,X37_Fy_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
end





%% X40

%-----Read data-----%
%X40_Y10
X40_Y10_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T02_Static.csv"));
X40_Y10_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T20_Static.csv"));
X40_Y10_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T22_Static.csv"));
X40_Y10_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T0-2_Static.csv"));
X40_Y10_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T-20_Static.csv"));
X40_Y10_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y10_T-2-2_Static.csv"));


%X40_Y13
X40_Y13_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T02_Static.csv"));
X40_Y13_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T20_Static.csv"));
X40_Y13_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T22_Static.csv"));
X40_Y13_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T0-2_Static.csv"));
X40_Y13_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T-20_Static.csv"));
X40_Y13_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y13_T-2-2_Static.csv"));


%X40_Y16
X40_Y16_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T02_Static.csv"));
X40_Y16_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T20_Static.csv"));
X40_Y16_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T22_Static.csv"));
X40_Y16_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T0-2_Static.csv"));
X40_Y16_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T-20_Static.csv"));
X40_Y16_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y16_T-2-2_Static.csv"));


%X40_Y19
X40_Y19_T02 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T02_Static.csv"));
X40_Y19_T20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T20_Static.csv"));
X40_Y19_T22 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T22_Static.csv"));
X40_Y19_T0m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T0-2_Static.csv"));
X40_Y19_Tm20 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T-20_Static.csv"));
X40_Y19_Tm2m2 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/X040/Y19_T-2-2_Static.csv"));


%-----Stack-----%
%T20
X40_T20_Fx = [X40_Y10_T20.Fx,X40_Y13_T20.Fx,X40_Y16_T20.Fx,X40_Y19_T20.Fx];
X40_T20_Fy = [X40_Y10_T20.Fy,X40_Y13_T20.Fy,X40_Y16_T20.Fy,X40_Y19_T20.Fy];
X40_T20_Fx_Mea = [X40_Y10_T20.Fx_Mea,X40_Y13_T20.Fx_Mea,X40_Y16_T20.Fx_Mea,X40_Y19_T20.Fx_Mea];
X40_T20_Fy_Mea = [X40_Y10_T20.Fy_Mea,X40_Y13_T20.Fy_Mea,X40_Y16_T20.Fy_Mea,X40_Y19_T20.Fy_Mea];

%T02
X40_T02_Fx = [X40_Y10_T02.Fx,X40_Y13_T02.Fx,X40_Y16_T02.Fx,X40_Y19_T02.Fx];
X40_T02_Fy = [X40_Y10_T02.Fy,X40_Y13_T02.Fy,X40_Y16_T02.Fy,X40_Y19_T02.Fy];
X40_T02_Fx_Mea = [X40_Y10_T02.Fx_Mea,X40_Y13_T02.Fx_Mea,X40_Y16_T02.Fx_Mea,X40_Y19_T02.Fx_Mea];
X40_T02_Fy_Mea = [X40_Y10_T02.Fy_Mea,X40_Y13_T02.Fy_Mea,X40_Y16_T02.Fy_Mea,X40_Y19_T02.Fy_Mea];

%T22
X40_T22_Fx = [X40_Y10_T22.Fx,X40_Y13_T22.Fx,X40_Y16_T22.Fx,X40_Y19_T22.Fx];
X40_T22_Fy = [X40_Y10_T22.Fy,X40_Y13_T22.Fy,X40_Y16_T22.Fy,X40_Y19_T22.Fy];
X40_T22_Fx_Mea = [X40_Y10_T22.Fx_Mea,X40_Y13_T22.Fx_Mea,X40_Y16_T22.Fx_Mea,X40_Y19_T22.Fx_Mea];
X40_T22_Fy_Mea = [X40_Y10_T22.Fy_Mea,X40_Y13_T22.Fy_Mea,X40_Y16_T22.Fy_Mea,X40_Y19_T22.Fy_Mea];

%Tm20
X40_Tm20_Fx = [X40_Y10_Tm20.Fx,X40_Y13_Tm20.Fx,X40_Y16_Tm20.Fx,X40_Y19_Tm20.Fx];
X40_Tm20_Fy = [X40_Y10_Tm20.Fy,X40_Y13_Tm20.Fy,X40_Y16_Tm20.Fy,X40_Y19_Tm20.Fy];
X40_Tm20_Fx_Mea = [X40_Y10_Tm20.Fx_Mea,X40_Y13_Tm20.Fx_Mea,X40_Y16_Tm20.Fx_Mea,X40_Y19_Tm20.Fx_Mea];
X40_Tm20_Fy_Mea = [X40_Y10_Tm20.Fy_Mea,X40_Y13_Tm20.Fy_Mea,X40_Y16_Tm20.Fy_Mea,X40_Y19_Tm20.Fy_Mea];

%T0m2
X40_T0m2_Fx = [X40_Y10_T0m2.Fx,X40_Y13_T0m2.Fx,X40_Y16_T0m2.Fx,X40_Y19_T0m2.Fx];
X40_T0m2_Fy = [X40_Y10_T0m2.Fy,X40_Y13_T0m2.Fy,X40_Y16_T0m2.Fy,X40_Y19_T0m2.Fy];
X40_T0m2_Fx_Mea = [X40_Y10_T0m2.Fx_Mea,X40_Y13_T0m2.Fx_Mea,X40_Y16_T0m2.Fx_Mea,X40_Y19_T0m2.Fx_Mea];
X40_T0m2_Fy_Mea = [X40_Y10_T0m2.Fy_Mea,X40_Y13_T0m2.Fy_Mea,X40_Y16_T0m2.Fy_Mea,X40_Y19_T0m2.Fy_Mea];

%Tm2m2
X40_Tm2m2_Fx = [X40_Y10_Tm2m2.Fx,X40_Y13_Tm2m2.Fx,X40_Y16_Tm2m2.Fx,X40_Y19_Tm2m2.Fx];
X40_Tm2m2_Fy = [X40_Y10_Tm2m2.Fy,X40_Y13_Tm2m2.Fy,X40_Y16_Tm2m2.Fy,X40_Y19_Tm2m2.Fy];
X40_Tm2m2_Fx_Mea = [X40_Y10_Tm2m2.Fx_Mea,X40_Y13_Tm2m2.Fx_Mea,X40_Y16_Tm2m2.Fx_Mea,X40_Y19_Tm2m2.Fx_Mea];
X40_Tm2m2_Fy_Mea = [X40_Y10_Tm2m2.Fy_Mea,X40_Y13_Tm2m2.Fy_Mea,X40_Y16_Tm2m2.Fy_Mea,X40_Y19_Tm2m2.Fy_Mea];


%%Stack
X40_Fx_Stack = [X40_T20_Fx;X40_T02_Fx;X40_T22_Fx;X40_Tm20_Fx;X40_T0m2_Fx;X40_Tm2m2_Fx];
X40_Fy_Stack = [X40_T20_Fy;X40_T02_Fy;X40_T22_Fy;X40_Tm20_Fy;X40_T0m2_Fy;X40_Tm2m2_Fy];
X40_Fx_Mea_Stack = [X40_T20_Fx_Mea;X40_T02_Fx_Mea;X40_T22_Fx_Mea;X40_Tm20_Fx_Mea;X40_T0m2_Fx_Mea;X40_Tm2m2_Fx_Mea];
X40_Fy_Mea_Stack = [X40_T20_Fy_Mea;X40_T02_Fy_Mea;X40_T22_Fy_Mea;X40_Tm20_Fy_Mea;X40_T0m2_Fy_Mea;X40_Tm2m2_Fy_Mea];


%-----Plot-----%
X40_Y = [10,13,16,19];
T = ["T20","T02","T22","Tm20","T0m2","Ym2m2"];

%%Fx
figure()
sgtitle("Fx X40")
for i = 1:length(X40_Fx_Stack)
    subplot(2,3,i)
    hold on
    plot(X40_Y,X40_Fx_Stack(i,:))
    plot(X40_Y,X40_Fx_Mea_Stack(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
end


%%Fy
figure()
sgtitle("Fy X40")
for i = 1:length(X40_Fy_Stack)
    subplot(2,3,i)
    hold on
    plot(X40_Y,X40_Fy_Stack(i,:))
    plot(X40_Y,X40_Fy_Mea_Stack(i,:))
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

    y = x(10:end-10,3:end);

end

function y = avg(x)

    xx = mean(x{:,:});
    COLUMNS = ["T1", "T2", "t1", "t2", "q1", "q2", "x", "y", "x_dot", "y_dot", "Fx", "Fy", "Fx_Mea", "Fy_Mea"];
    y = array2table(xx,'VariableNames',COLUMNS);

end











