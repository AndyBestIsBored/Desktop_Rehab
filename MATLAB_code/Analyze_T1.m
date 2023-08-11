clear
clc


%% X25

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";

%-----Read data-----%

%X25_Y10
X25_Y10_T01 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T01_Static.csv"));
X25_Y10_T10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T10_Static.csv"));
X25_Y10_T11 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T11_Static.csv"));
X25_Y10_T0m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T0-1_Static.csv"));
X25_Y10_Tm10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T-10_Static.csv"));
X25_Y10_Tm1m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y10_T-1-1_Static.csv"));


%X25_Y13
X25_Y13_T01 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T01_Static.csv"));
X25_Y13_T10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T10_Static.csv"));
X25_Y13_T11 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T11_Static.csv"));
X25_Y13_T0m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T0-1_Static.csv"));
X25_Y13_Tm10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T-10_Static.csv"));
X25_Y13_Tm1m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y13_T-1-1_Static.csv"));


%X25_Y16
X25_Y16_T01 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T01_Static.csv"));
X25_Y16_T10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T10_Static.csv"));
X25_Y16_T11 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T11_Static.csv"));
X25_Y16_T0m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T0-1_Static.csv"));
X25_Y16_Tm10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T-10_Static.csv"));
X25_Y16_Tm1m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y16_T-1-1_Static.csv"));


%X25_Y19
X25_Y19_T01 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T01_Static.csv"));
X25_Y19_T10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T10_Static.csv"));
X25_Y19_T11 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T11_Static.csv"));
X25_Y19_T0m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T0-1_Static.csv"));
X25_Y19_Tm10 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T-10_Static.csv"));
X25_Y19_Tm1m1 = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T1/X25/Y19_T-1-1_Static.csv"));






%-----Average data-----%

%X25_Y10
X25_Y10_T01_avg = avg(X25_Y10_T01);
X25_Y10_T10_avg = avg(X25_Y10_T10);
X25_Y10_T11_avg = avg(X25_Y10_T11);
X25_Y10_T0m1_avg = avg(X25_Y10_T0m1);
X25_Y10_Tm10_avg = avg(X25_Y10_Tm10);
X25_Y10_Tm1m1_avg = avg(X25_Y10_Tm1m1);


%X25_Y13
X25_Y13_T01_avg = avg(X25_Y13_T01);
X25_Y13_T10_avg = avg(X25_Y13_T10);
X25_Y13_T11_avg = avg(X25_Y13_T11);
X25_Y13_T0m1_avg = avg(X25_Y13_T0m1);
X25_Y13_Tm10_avg = avg(X25_Y13_Tm10);
X25_Y13_Tm1m1_avg = avg(X25_Y13_Tm1m1);


%X25_Y16
X25_Y16_T01_avg = avg(X25_Y16_T01);
X25_Y16_T10_avg = avg(X25_Y16_T10);
X25_Y16_T11_avg = avg(X25_Y16_T11);
X25_Y16_T0m1_avg = avg(X25_Y16_T0m1);
X25_Y16_Tm10_avg = avg(X25_Y16_Tm10);
X25_Y16_Tm1m1_avg = avg(X25_Y16_Tm1m1);


%X25_Y19
X25_Y19_T01_avg = avg(X25_Y19_T01);
X25_Y19_T10_avg = avg(X25_Y19_T10);
X25_Y19_T11_avg = avg(X25_Y19_T11);
X25_Y19_T0m1_avg = avg(X25_Y19_T0m1);
X25_Y19_Tm10_avg = avg(X25_Y19_Tm10);
X25_Y19_Tm1m1_avg = avg(X25_Y19_Tm1m1);


%-----Stack-----%
%T10
X25_T10_Fx_avg = [X25_Y10_T10_avg.Fx,X25_Y13_T10_avg.Fx,X25_Y16_T10_avg.Fx,X25_Y19_T10_avg.Fx];
X25_T10_Fy_avg = [X25_Y10_T10_avg.Fy,X25_Y13_T10_avg.Fy,X25_Y16_T10_avg.Fy,X25_Y19_T10_avg.Fy];
X25_T10_Fx_Mea_avg = [X25_Y10_T10_avg.Fx_Mea,X25_Y13_T10_avg.Fx_Mea,X25_Y16_T10_avg.Fx_Mea,X25_Y19_T10_avg.Fx_Mea];
X25_T10_Fy_Mea_avg = [X25_Y10_T10_avg.Fy_Mea,X25_Y13_T10_avg.Fy_Mea,X25_Y16_T10_avg.Fy_Mea,X25_Y19_T10_avg.Fy_Mea];

%T01
X25_T01_Fx_avg = [X25_Y10_T01_avg.Fx,X25_Y13_T01_avg.Fx,X25_Y16_T01_avg.Fx,X25_Y19_T01_avg.Fx];
X25_T01_Fy_avg = [X25_Y10_T01_avg.Fy,X25_Y13_T01_avg.Fy,X25_Y16_T01_avg.Fy,X25_Y19_T01_avg.Fy];
X25_T01_Fx_Mea_avg = [X25_Y10_T01_avg.Fx_Mea,X25_Y13_T01_avg.Fx_Mea,X25_Y16_T01_avg.Fx_Mea,X25_Y19_T01_avg.Fx_Mea];
X25_T01_Fy_Mea_avg = [X25_Y10_T01_avg.Fy_Mea,X25_Y13_T01_avg.Fy_Mea,X25_Y16_T01_avg.Fy_Mea,X25_Y19_T01_avg.Fy_Mea];

%T11
X25_T11_Fx_avg = [X25_Y10_T11_avg.Fx,X25_Y13_T11_avg.Fx,X25_Y16_T11_avg.Fx,X25_Y19_T11_avg.Fx];
X25_T11_Fy_avg = [X25_Y10_T11_avg.Fy,X25_Y13_T11_avg.Fy,X25_Y16_T11_avg.Fy,X25_Y19_T11_avg.Fy];
X25_T11_Fx_Mea_avg = [X25_Y10_T11_avg.Fx_Mea,X25_Y13_T11_avg.Fx_Mea,X25_Y16_T11_avg.Fx_Mea,X25_Y19_T11_avg.Fx_Mea];
X25_T11_Fy_Mea_avg = [X25_Y10_T11_avg.Fy_Mea,X25_Y13_T11_avg.Fy_Mea,X25_Y16_T11_avg.Fy_Mea,X25_Y19_T11_avg.Fy_Mea];

%Tm10
X25_Tm10_Fx_avg = [X25_Y10_Tm10_avg.Fx,X25_Y13_Tm10_avg.Fx,X25_Y16_Tm10_avg.Fx,X25_Y19_Tm10_avg.Fx];
X25_Tm10_Fy_avg = [X25_Y10_Tm10_avg.Fy,X25_Y13_Tm10_avg.Fy,X25_Y16_Tm10_avg.Fy,X25_Y19_Tm10_avg.Fy];
X25_Tm10_Fx_Mea_avg = [X25_Y10_Tm10_avg.Fx_Mea,X25_Y13_Tm10_avg.Fx_Mea,X25_Y16_Tm10_avg.Fx_Mea,X25_Y19_Tm10_avg.Fx_Mea];
X25_Tm10_Fy_Mea_avg = [X25_Y10_Tm10_avg.Fy_Mea,X25_Y13_Tm10_avg.Fy_Mea,X25_Y16_Tm10_avg.Fy_Mea,X25_Y19_Tm10_avg.Fy_Mea];

%T0m1
X25_T0m1_Fx_avg = [X25_Y10_T0m1_avg.Fx,X25_Y13_T0m1_avg.Fx,X25_Y16_T0m1_avg.Fx,X25_Y19_T0m1_avg.Fx];
X25_T0m1_Fy_avg = [X25_Y10_T0m1_avg.Fy,X25_Y13_T0m1_avg.Fy,X25_Y16_T0m1_avg.Fy,X25_Y19_T0m1_avg.Fy];
X25_T0m1_Fx_Mea_avg = [X25_Y10_T0m1_avg.Fx_Mea,X25_Y13_T0m1_avg.Fx_Mea,X25_Y16_T0m1_avg.Fx_Mea,X25_Y19_T0m1_avg.Fx_Mea];
X25_T0m1_Fy_Mea_avg = [X25_Y10_T0m1_avg.Fy_Mea,X25_Y13_T0m1_avg.Fy_Mea,X25_Y16_T0m1_avg.Fy_Mea,X25_Y19_T0m1_avg.Fy_Mea];

%Tm1m1
X25_Tm1m1_Fx_avg = [X25_Y10_Tm1m1_avg.Fx,X25_Y13_Tm1m1_avg.Fx,X25_Y16_Tm1m1_avg.Fx,X25_Y19_Tm1m1_avg.Fx];
X25_Tm1m1_Fy_avg = [X25_Y10_Tm1m1_avg.Fy,X25_Y13_Tm1m1_avg.Fy,X25_Y16_Tm1m1_avg.Fy,X25_Y19_Tm1m1_avg.Fy];
X25_Tm1m1_Fx_Mea_avg = [X25_Y10_Tm1m1_avg.Fx_Mea,X25_Y13_Tm1m1_avg.Fx_Mea,X25_Y16_Tm1m1_avg.Fx_Mea,X25_Y19_Tm1m1_avg.Fx_Mea];
X25_Tm1m1_Fy_Mea_avg = [X25_Y10_Tm1m1_avg.Fy_Mea,X25_Y13_Tm1m1_avg.Fy_Mea,X25_Y16_Tm1m1_avg.Fy_Mea,X25_Y19_Tm1m1_avg.Fy_Mea];


%%Stack
X25_Fx_Stack_avg = [X25_T10_Fx_avg; X25_T01_Fx_avg; X25_T11_Fx_avg; X25_Tm10_Fx_avg; X25_T0m1_Fx_avg; X25_Tm1m1_Fx_avg];
X25_Fy_Stack_avg = [X25_T10_Fy_avg; X25_T01_Fy_avg; X25_T11_Fy_avg; X25_Tm10_Fy_avg; X25_T0m1_Fy_avg; X25_Tm1m1_Fy_avg];
X25_Fx_Mea_Stack_avg = [X25_T10_Fx_Mea_avg; X25_T01_Fx_Mea_avg; X25_T11_Fx_Mea_avg; X25_Tm10_Fx_Mea_avg; X25_T0m1_Fx_Mea_avg; X25_Tm1m1_Fx_Mea_avg];
X25_Fy_Mea_Stack_avg = [X25_T10_Fy_Mea_avg; X25_T01_Fy_Mea_avg; X25_T11_Fy_Mea_avg; X25_Tm10_Fy_Mea_avg; X25_T0m1_Fy_Mea_avg; X25_Tm1m1_Fy_Mea_avg];



%-----Scatter Plot-----%
T = ["T10","T01","T11","Tm10","T0m1","Tm1m1"];
Y = ["Y10","Y13","Y16","Y19"];
X25_Y_avg = [0.10,0.13,0.16,0.19];

%%Fx
figure()
sgtitle("Fx X25")
for i = 1:length(T)
    subplot(2,3,i)
    hold on
    for k = 1:length(Y)
        name = "X25_" + Y{k} + "_" + T{i}
        data = eval(name);
        scatter(data.y,data.Fx_Mea,'filled')
    end
    hold off
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
    ylim([-9,9])
end



%%Fy
figure()
sgtitle("Fy X25")
for i = 1:length(T)
    subplot(2,3,i)
    hold on
    for k = 1:length(Y)
        name = "X25_" + Y{k} + "_" + T{j};
        data = eval(name);
        scatter(data.y,data.Fy_Mea,'filled')
    end
    hold off
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
    ylim([-9,9])
end



%-----Plot-----%



%%Fx
figure()
sgtitle("Fx X25")
for i = 1:6
    subplot(2,3,i)
    hold on
    plot(X25_Y_avg,X25_Fx_Stack_avg(i,:))
    plot(X25_Y_avg,X25_Fx_Mea_Stack_avg(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fx [N]")
    ylim([-9,9])
end


%%Fy
figure()
sgtitle("Fy X25")
for i = 1:6
    subplot(2,3,i)
    hold on
    plot(X25_Y_avg,X25_Fy_Stack_avg(i,:))
    plot(X25_Y_avg,X25_Fy_Mea_Stack_avg(i,:))
    hold off
    legend(["Theory","Experiment"])
    title(T(i))
    xlabel("Y [cm]")
    ylabel("Fy [N]")
    ylim([-9,9])
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


