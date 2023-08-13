clear
clc


%% Readdata

mainpath = "/Users/khemwutapornpipatsakul/Documents/VS_coding";


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


all_varnames = fieldnames(data);

for i = 1:length(all_varnames)
    data_avg.(all_varnames{i}) = avg(data.(all_varnames{i}));
end

clear i j k l Tname varname filename

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
