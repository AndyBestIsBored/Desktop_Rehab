clear
clc


%% Readdata

% mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding"; %MacBook
mainpath = "D:\python\"; %Hp


XX = string(25:3:40);
YY = string(100:15:196);
TT = ["02", "20", "22", "0-2", "-20", "-2-2"];

for i = XX
    for j = YY
        for k = TT
            filename = "Y" + j + "_T" + k + "_Static.csv";
            Tname = char(k);
            for l = 1:length(Tname)
                if Tname(l) == '-'
                    Tname(l) = 'm';
                end
            end
            varname = "X" + i + "_Y" + j + "_T" + Tname;
            data.(varname) = process(readtable(mainpath+"/Desktop_Rehab/Record_Data/T2/X" + i + "/" + filename));
        end
    end
end


for k = 1:length(TT)
    Tname = char(TT(k));
    for l = 1:length(Tname)
        if Tname(l) == '-'
            Tname(l) = 'm';
        end
    end
    TT_name(k) = "T" + Tname;
end


all_varnames = fieldnames(data);

for i = 1:length(all_varnames)
    data_avg.(all_varnames{i}) = avg(data.(all_varnames{i}));
end

clear i j k l Tname varname filename



%% Plot Fx

for i = XX
    figure()
    sgtitle("X" + i + " " + " Fx")
    for j = 1:length(TT_name)
        subplot(3,2,j)
        hold on
        for k = 1:length(YY)
            path = data.("X" + i + "_Y" + YY(k) + "_" + TT_name(j));
            path_avg = data_avg.("X" + i + "_Y" + YY(k) + "_" + TT_name(j));
            scatter(str2double(YY(k))*ones(1,length(path.y)),path.Fx_Mea, 'filled')
            Theory(k) = path_avg.Fx;
            Exp(k) = path_avg.Fx_Mea;
        end
     
        plot(str2double(YY), Theory)
        plot(str2double(YY), Exp)
        xlabel("Y [mm]")
        ylabel("Fx [N]")
        ylim([-12 12])
%         legend(["Theory", "Exp"])
        legend([YY,"Theory","Exp"])
        legend('Location','eastoutside')
        title("T" + TT(j))
        hold off
    end
end

clear i j k path_avg Theory Exp path




%% Plot Fy

for i = XX
    figure()
    sgtitle("X" + i + " " + " Fy")
    for j = 1:length(TT_name)
        subplot(3,2,j)
        hold on
        for k = 1:length(YY)
            path = data.("X" + i + "_Y" + YY(k) + "_" + TT_name(j));
            path_avg = data_avg.("X" + i + "_Y" + YY(k) + "_" + TT_name(j));
            scatter(str2double(YY(k))*ones(1,length(path.y)),path.Fy_Mea, 'filled')
            Theory(k) = path_avg.Fy;
            Exp(k) = path_avg.Fy_Mea;
        end
     
        plot(str2double(YY), Theory)
        plot(str2double(YY), Exp)
        xlabel("Y [mm]")
        ylabel("Fy [N]")
        ylim([-12 12])
%         legend(["Theory", "Exp"])
        legend([YY,"Theory","Exp"])
        title("T" + TT_name(j))
    end
end

clear i j k path_avg Theory Exp path


%% Plot 3D Fx

figure()
sgtitle("Fx")
for i = 1:length(TT_name) 
    subplot(3,2,i) 
    hold on
    for j = XX
        for k = 1:length(YY)
            path = data.("X" + j + "_Y" + YY(k) + "_" + TT_name(i));
            path_avg = data_avg.("X" + j + "_Y" + YY(k) + "_" + TT_name(i));
            scatter3(str2double(j)*10*ones(1,length(path.y)),str2double(YY(k))*ones(1,length(path.y)),path.Fx_Mea, 'filled')
            Theory(k,:) = [10*str2double(j), str2double(YY(k)), path_avg.Fx];
            Exp(k,:) = [10*str2double(j), str2double(YY(k)),path_avg.Fx_Mea];
        end
     
        plot3(Theory(:,1), Theory(:,2), Theory(:,3))
        plot3(Exp(:,1), Exp(:,2), Exp(:,3))
        xlabel("X [mm]")
        ylabel("Y [mm]")
        zlabel("Fx [N]")
        zlim([-12 12])
        view(3)
%         legend(["Theory", "Exp"])
%         legend([YY,"Theory","Exp"])
%         legend('Location','eastoutside')
%         title("T" + TT(j))
    end
end

clear i j k path_avg Theory Exp path


%% Plot 3D Fy

figure()
sgtitle("Fy")
for i = 1:length(TT_name) 
    subplot(3,2,i) 
    hold on
    for j = XX
        for k = 1:length(YY)
            path = data.("X" + j + "_Y" + YY(k) + "_" + TT_name(i));
            path_avg = data_avg.("X" + j + "_Y" + YY(k) + "_" + TT_name(i));
            scatter3(str2double(j)*10*ones(1,length(path.y)),str2double(YY(k))*ones(1,length(path.y)),path.Fy_Mea, 'filled')
            Theory(k,:) = [10*str2double(j), str2double(YY(k)), path_avg.Fy];
            Exp(k,:) = [10*str2double(j), str2double(YY(k)),path_avg.Fy_Mea];
        end
     
        plot3(Theory(:,1), Theory(:,2), Theory(:,3))
        plot3(Exp(:,1), Exp(:,2), Exp(:,3))
        xlabel("X [mm]")
        ylabel("Y [mm]")
        zlabel("Fy [N]")
        zlim([-12 12])
        view(3)
%         legend(["Theory", "Exp"])
%         legend([YY,"Theory","Exp"])
%         legend('Location','eastoutside')
%         title("T" + TT(j))
    end
end

clear i j k path_avg Theory Exp path


%% Surface Fx

figure()
sgtitle("Fx")
for i = 1:length(TT_name) 
    subplot(3,2,i) 
    hold on
    [X,Y] = meshgrid(10*str2double(XX),str2double(YY));
    for j = 1:length(XX)
        for k = 1:length(YY)
            path_avg = data_avg.("X" + XX(j) + "_Y" + YY(k) + "_" + TT_name(i));
            Theory(k,j) = path_avg.Fx;
            Exp(k,j) = path_avg.Fx_Mea;
        end  
    end
%     surf(X,Y,Theory,'EdgeColor','none', 'FaceAlpha', 0.5)
    surf(X,Y,Exp,'EdgeColor','none')
    xlabel("X [mm]")
    ylabel("Y [mm]")
    zlabel("Fx [N]")
    zlim([-12 12])
    title(TT_name(i))
    view(3)
    hold off
end

clear i j k path_avg Exp path X Y Theory


%% Surface Fy

figure()
sgtitle("Fy")
for i = 1:length(TT_name) 
    subplot(3,2,i) 
    hold on
    [X,Y] = meshgrid(10*str2double(XX),str2double(YY));
    for j = 1:length(XX)
        for k = 1:length(YY)
            path_avg = data_avg.("X" + XX(j) + "_Y" + YY(k) + "_" + TT_name(i));
            Theory(k,j) = path_avg.Fy;
            Exp(k,j) = path_avg.Fy_Mea;
        end  
    end
%     surf(X,Y,Theory,'EdgeColor','none', 'FaceAlpha', 0.5)
    surf(X,Y,Exp,'EdgeColor','none')
    xlabel("X [mm]")
    ylabel("Y [mm]")
    zlabel("Fy [N]")
    zlim([-12 12])
    title(TT_name(i))
    view(3)
    hold off
end

clear i j k path_avg Exp path X Y Theory


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
