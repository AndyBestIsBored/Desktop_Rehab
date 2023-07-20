clear
clc

%% Mapping RT2RF


% syms q1 q2 

l1 = 0.275;
l2 = 0.24;
% l4_val = 0.010;
% q0_val = deg2rad(18);

T1 = @(Fx,Fy,q1,q2) Fx.*l1.*cos(q1) - Fy.*l1.*sin(q1);
T2 = @(Fx,Fy,q1,q2) -Fx.*l2.*sin(q2) - Fy.*l2.*cos(q2);

Fx = @(T1,T2,q1,q2) (T1.*l2.*cos(q2)-T2.*l1.*sin(q1))./(l1*l2.*cos(q1-q2));
Fy = @(T1,T2,q1,q2) (-T1.*l2.*sin(q2)-T2.*l1.*cos(q1))./(l1*l2.*cos(q1-q2));


%% Inverse Kinematics

syms q1 q2 x y

% l1_val = 0.275;
% l2_val = 0.24;
f1 = @(q1,q2) l1.*sin(q1)+l2.*cos(q2);
f2 = @(q1,q2) l1.*cos(q1)-l2.*sin(q2);


ikk = solve([f1 == x f2 == y],[q1 q2]);

ik1 = matlabFunction(simplify(ikk.q1(1)), 'Var', [x,y]);
ik2 = matlabFunction(simplify(ikk.q2(1)), 'Var', [x,y]);
ik = @(x,y) [ik1(x,y) ik2(x,y)]

% [X,Y] = meshgrid(0.24:0.005:0.3,0.12:0.005:0.22);
% theta1 = ik1(X,Y);
% theta2 = ik2(X,Y);

% [theta1, theta2] = meshgrid(0:0.1:deg2rad(60),0:0.1:deg2rad(45));
% X = f1(theta1,theta2);
% Y = f2(theta1,theta2);

% figure()
% sgtitle("Theta 1 and Theta 2")
% subplot(1,2,1)
% surf(X,Y,rad2deg(theta1),'EdgeColor','none')
% xlabel("X")
% ylabel("Y")
% zlabel("q1 (deg)")
% title("Theta1")
% colorbar
% 
% subplot(1,2,2)
% surf(X,Y,rad2deg(theta2),'EdgeColor','none')
% xlabel("X")
% ylabel("Y")
% zlabel("q2 (deg)")
% title("Theta2")
% % view([45 45 45])
% colorbar


%% Older design

%FK
x_old = l1*sin(q1) + l2*cos(q1+q2);
y_old = l1*cos(q1) - l2*sin(q1+q2);

%IK
f1_old = @(q1,q2) l1*sin(q1) + l2*cos(q1+q2);
f2_old = @(q1,q2) l1*cos(q1) - l2*sin(q1+q2);
ikk_old = solve([f1_old == x f2_old == y],[q1 q2]);
ik1_old = matlabFunction(simplify(ikk_old.q1(1)), 'Var', [x,y]);
ik2_old = matlabFunction(simplify(ikk_old.q2(1)), 'Var', [x,y]);


%Jacobian
J_old = jacobian([x_old,y_old],[q1,q2]);
JT_old = transpose(J_old);
JT_old_inv = simplify(inv(JT_old));
JT_old_eq = matlabFunction(JT_old, 'Var', [q1,q2]);
JT_old_inv_eq = matlabFunction(JT_old_inv, 'Var', [q1,q2]);


%Force
Fx_old = @(T1,T2,q1,q2) (T1.*l2.*cos(q1+q2)-T2.*(l1.*sin(q1)+l2.*cos(q1+q2)))./(l1.*l2.*cos(q2));
Fy_old = @(T1,T2,q1,q2) (-T1.*l2.*sin(q1+q2)-T2.*(l1.*cos(q1)-l2.*sin(q1+q2)))./(l1.*l2.*cos(q2));

%Torque
T1_old = @(Fx,Fy,q1,q2) Fx.*(l1.*cos(q1)-l2.*sin(q1+q2)) - Fy.*(l1.*sin(q1)+l2.*cos(q1+q2));
T2_old = @(Fx,Fy,q1,q2) -Fx.*l2.*sin(q1+q2) - Fy.*l2.*cos(q1+q2);



%% Find Workspace & Sensitivity


% assume(-0.852<Q1-Q2<1.291) %Limitation
% Q1_Range = -1.211:0.1:1.299; %Workspace of M1
% Q2_Range = -0.359:0.1:2.159; %Workspace of M2

Q_step = 0.05;

[Q1,Q2] = meshgrid(-1.211:Q_step:1.299,-0.359:Q_step:2.159); 

% Apply the assumption to the meshgrid
valid_points = eval(subs(Q1 - Q2 > -0.852 & Q1 - Q2 < 1.291));

Q1 = Q1.*valid_points;
Q2 = Q2.*valid_points;

for i = 1:length(Q1)
    for j = 1:length(Q1)
        if Q1(i,j) == 0
            Q1(i,j) = NaN;
        end
        if Q2(i,j) == 0
            Q2(i,j) = NaN;
        end
    end
end


figure()
% sgtitle("Sensitivity")

%New
subplot(2,1,1)
scatter(f1(Q1,Q2),f2(Q1,Q2),'filled','b', 'SizeData', 3)
xlabel("X (m)")
ylabel("Y (m)")
title("Planar Robotic Arm")
xlim([-0.6 0.6])

max_distance = 0;
n = length(Q1);
for i = 1:n-1
    for j = 1:n-1
        if ~isnan(Q1(i,j)) && ~isnan(Q1(i+1,j)) && ~isnan(Q1(i,j+1)) && ~isnan(Q1(i+1,j+1))
            distance1 = sqrt((f1(Q1(i,j),Q2(i,j)) - f1(Q1(i+1,j),Q2(i+1,j)))^2 + (f2(Q1(i,j),Q2(i,j)) - f2(Q1(i+1,j),Q2(i+1,j)))^2);
            distance2 = sqrt((f1(Q1(i,j),Q2(i,j)) - f1(Q1(i,j+1),Q2(i,j+1)))^2 + (f2(Q1(i,j),Q2(i,j)) - f2(Q1(i,j+1),Q2(i,j+1)))^2);
            distance3 = sqrt((f1(Q1(i,j),Q2(i,j)) - f1(Q1(i+1,j+1),Q2(i+1,j+1)))^2 + (f2(Q1(i,j),Q2(i,j)) - f2(Q1(i+1,j+1),Q2(i+1,j+1)))^2);
            max_distance = max([max_distance,distance1,distance2,distance3]);
        end

    end
end
Sensitivity = max_distance



%Old
[Q1_old,Q2_old] = meshgrid(-pi/2:Q_step:pi/2,-3*pi/2+Q_step:Q_step:pi/2-Q_step); 

subplot(2,1,2)
scatter(f1_old(Q1_old,Q2_old),f2_old(Q1_old,Q2_old),'filled','b', 'SizeData', 3)
xlabel("X (m)")
ylabel("Y (m)")
title("Traditional 2DOF Arm Robot ")

max_distance = 0;
n = length(Q1_old);
for i = 1:n-1
    for j = 1:length(Q1_old(1,:))-1
        if ~isnan(Q1_old(i,j)) && ~isnan(Q1_old(i+1,j)) && ~isnan(Q1_old(i,j+1)) && ~isnan(Q1_old(i+1,j+1))
            distance1 = sqrt((f1(Q1_old(i,j),Q2_old(i,j)) - f1(Q1_old(i+1,j),Q2_old(i+1,j)))^2 + (f2(Q1_old(i,j),Q2_old(i,j)) - f2(Q1_old(i+1,j),Q2_old(i+1,j)))^2);
            distance2 = sqrt((f1(Q1_old(i,j),Q2_old(i,j)) - f1(Q1_old(i,j+1),Q2_old(i,j+1)))^2 + (f2(Q1_old(i,j),Q2_old(i,j)) - f2(Q1_old(i,j+1),Q2_old(i,j+1)))^2);
            distance3 = sqrt((f1(Q1_old(i,j),Q2_old(i,j)) - f1(Q1_old(i+1,j+1),Q2_old(i+1,j+1)))^2 + (f2(Q1_old(i,j),Q2_old(i,j)) - f2(Q1_old(i+1,j+1),Q2_old(i+1,j+1)))^2);
            max_distance = max([max_distance,distance1,distance2,distance3]);
        end

    end
end
Sensitivity_old = max_distance


%% Recorded Data range

[X,Y] = meshgrid(0.25:0.01:0.4,0.10:0.01:0.25);
theta1 = ik1(X,Y);
theta2 = ik2(X,Y);

figure()
hold on
scatter(f1(Q1,Q2),f2(Q1,Q2),'filled','b', 'SizeData', 3)
scatter(X,Y,'filled','k')
hold off
xlabel("X (m)")
ylabel("Y (m)")
title("Planar Robotic Arm")


%% plot of Torque Required



% [X,Y] = meshgrid(0.2:0.005:0.3);
% theta1 = ik1(X,Y);
% theta2 = ik2(X,Y);

%Fx = 1, Fy = 0
T1_Fx = T1(1,0,theta1,theta2);
T2_Fx = T2(1,0,theta1,theta2);

T1_Fx_old = T1_old(1,0,theta1,theta2);
T2_Fx_old = T2_old(1,0,theta1,theta2);


figure()
sgtitle("Fx = 1 N, Fy = 0 N")
subplot(2,2,1)
surf(X,Y,T1_Fx,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1")
colorbar

subplot(2,2,2)
surf(X,Y,T2_Fx,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2")
colorbar

subplot(2,2,3)
surf(X,Y,T1_Fx_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1 Old")
colorbar

subplot(2,2,4)
surf(X,Y,T2_Fx_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2 Old")
colorbar



%Fx = 0, Fy = 1
T1_Fy = T1(0,1,theta1,theta2);
T2_Fy = T2(0,1,theta1,theta2);

T1_Fy_old = T1_old(0,1,theta1,theta2);
T2_Fy_old = T2_old(0,1,theta1,theta2);


figure()
sgtitle("Fx = 0 N, Fy = 1 N")
subplot(2,2,1)
surf(X,Y,T1_Fy,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1")
colorbar

subplot(2,2,2)
surf(X,Y,T2_Fy,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2")
colorbar

subplot(2,2,3)
surf(X,Y,T1_Fy_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1 Old")
colorbar

subplot(2,2,4)
surf(X,Y,T2_Fy_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2 Old")
colorbar



% %Fx = 1/sqrt(2), Fy = 1/sqrt(2)
% T1_Ft = T1(1/sqrt(2),1/sqrt(2),theta1,theta2);
% T2_Ft = T2(1/sqrt(2),1/sqrt(2),theta1,theta2);
% 
% T1_Ft_old = T1_old(1/sqrt(2),1/sqrt(2),theta1,theta2);
% T2_Ft_old= T2_old(1/sqrt(2),1/sqrt(2),theta1,theta2);
% 
% 
% 
% figure()
% sgtitle("Ft")
% subplot(2,2,1)
% surf(X,Y,T1_Ft)
% xlabel("X")
% ylabel("Y")
% zlabel("T1")
% title("T1")
% colorbar
% 
% subplot(2,2,2)
% surf(X,Y,T2_Ft)
% xlabel("X")
% ylabel("Y")
% zlabel("T2")
% title("T2")
% colorbar
% 
% subplot(2,2,3)
% surf(X,Y,T1_Ft_old)
% xlabel("X")
% ylabel("Y")
% zlabel("T1")
% title("T1 Old")
% colorbar
% 
% subplot(2,2,4)
% surf(X,Y,T2_Ft_old)
% xlabel("X")
% ylabel("Y")
% zlabel("T2")
% title("T2 Old")
% colorbar



%Fx = -1, Fy = 0
T1_mFx = T1(-1,0,theta1,theta2);
T2_mFx = T2(-1,0,theta1,theta2);

T1_mFx_old = T1_old(-1,0,theta1,theta2);
T2_mFx_old = T2_old(-1,0,theta1,theta2);


figure()
sgtitle("Fx = -1 N, Fy = 0 N")
subplot(2,2,1)
surf(X,Y,T1_mFx,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1")
colorbar

subplot(2,2,2)
surf(X,Y,T2_mFx,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2")
colorbar

subplot(2,2,3)
surf(X,Y,T1_mFx_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1 Old")
colorbar

subplot(2,2,4)
surf(X,Y,T2_mFx_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2 Old")
colorbar



%Fx = 0, Fy = -1
T1_mFy = T1(0,-1,theta1,theta2);
T2_mFy = T2(0,-1,theta1,theta2);

T1_mFy_old = T1_old(0,-1,theta1,theta2);
T2_mFy_old = T2_old(0,-1,theta1,theta2);


figure()
sgtitle("Fx = 0 N, Fy = -1 N")
subplot(2,2,1)
surf(X,Y,T1_mFy,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1")
colorbar

subplot(2,2,2)
surf(X,Y,T2_mFy,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2")
colorbar

subplot(2,2,3)
surf(X,Y,T1_mFy_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T1")
title("T1 Old")
colorbar

subplot(2,2,4)
surf(X,Y,T2_mFy_old,'EdgeColor','none')
xlabel("X (m)")
ylabel("Y (m)")
zlabel("T2")
title("T2 Old")
colorbar


Max_T1 = max(max(abs([T1_Fx, T1_Fy, T1_mFx, T1_mFy])));
Max_T2 = max(max(abs([T2_Fx, T2_Fy, T2_mFx, T2_mFy])));
Max_T1_old = max(max(abs([T1_Fx_old, T1_Fy_old, T1_mFx_old, T1_mFy_old])));
Max_T2_old = max(max(abs([T2_Fx_old, T2_Fy_old, T2_mFx_old, T2_mFy_old])));

table([Max_T1;Max_T1_old],[Max_T2;Max_T2_old], 'RowNames', {'Planar Robot', 'Conventional Robot'}, 'VariableNames', {'T1 Max', 'T2 Max'})


%% Fx&Fy

T_int = 3;

%---Fx---%

%T000_
figure()
subplot(2,3,1)
surf(X,Y,Fx(0,T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("T000"+string(T_int))
colorbar

%T0_00
subplot(2,3,2)
surf(X,Y,Fx(T_int,0,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("T0"+string(T_int)+"00")
colorbar

%T0_0_
subplot(2,3,3)
surf(X,Y,Fx(T_int,T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("T0"+string(T_int)+"0"+string(T_int))
colorbar


%T00m0_
subplot(2,3,4)
surf(X,Y,Fx(0,-T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("T00-0"+string(T_int))
colorbar

%T0_00
subplot(2,3,5)
surf(X,Y,Fx(-T_int,0,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("T-0"+string(T_int)+"00")
colorbar

%Tm0_m0_
subplot(2,3,6)
surf(X,Y,Fx(-T_int,-T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Tm0"+string(T_int)+"m0"+string(T_int))
colorbar


%---Fy---%

%T000_
figure()
subplot(2,3,1)
surf(X,Y,Fy(0,T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("T000"+string(T_int))
colorbar

%T0_00
subplot(2,3,2)
surf(X,Y,Fy(T_int,0,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("T0"+string(T_int)+"00")
colorbar

%T0_0_
subplot(2,3,3)
surf(X,Y,Fy(T_int,T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("T0"+string(T_int)+"0"+string(T_int))
colorbar


%T00m0_
subplot(2,3,4)
surf(X,Y,Fy(0,-T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("T00-0"+string(T_int))
colorbar

%T0_00
subplot(2,3,5)
surf(X,Y,Fy(-T_int,0,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("T-0"+string(T_int)+"00")
colorbar

%Tm0_m0_
subplot(2,3,6)
surf(X,Y,Fy(-T_int,-T_int,theta1,theta2),'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Tm0"+string(T_int)+"m0"+string(T_int))
colorbar


%% Plots of reaction force

%T1 = 1 Nm, T2 = 1 Nm
Fx_11Nm = Fx(1,1,theta1,theta2);
Fy_11Nm = Fy(1,1,theta1,theta2);

Fx_11Nm_old = Fx_old(1,1,theta1,theta2);
Fy_11Nm_old = Fy_old(1,1,theta1,theta2);

figure()
sgtitle("T1 = 1 Nm, T2 = 1 Nm")
subplot(2,2,1)
surf(X,Y,Fx_11Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx")
colorbar

subplot(2,2,2)
surf(X,Y,Fy_11Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy")
colorbar


subplot(2,2,3)
surf(X,Y,Fx_11Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx (Old Design)")
colorbar

subplot(2,2,4)
surf(X,Y,Fy_11Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy (Old Design)")
colorbar



%T1 = 1 Nm, T2 = -1 Nm
Fx_1m1Nm = Fx(1,-1,theta1,theta2);
Fy_1m1Nm = Fy(1,-1,theta1,theta2);

Fx_1m1Nm_old = Fx_old(1,-1,theta1,theta2);
Fy_1m1Nm_old = Fy_old(1,-1,theta1,theta2);

figure()
sgtitle("T1 = 1 Nm, T2 = -1 Nm")
subplot(2,2,1)
surf(X,Y,Fx_1m1Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx")
colorbar

subplot(2,2,2)
surf(X,Y,Fy_1m1Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy")
colorbar


subplot(2,2,3)
surf(X,Y,Fx_1m1Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx (Old Design)")
colorbar

subplot(2,2,4)
surf(X,Y,Fy_1m1Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy (Old Design)")
colorbar


%T1 = -1 Nm, T2 = 1 Nm
Fx_m11Nm = Fx(-1,1,theta1,theta2);
Fy_m11Nm = Fy(-1,1,theta1,theta2);

Fx_m11Nm_old = Fx_old(-1,1,theta1,theta2);
Fy_m11Nm_old = Fy_old(-1,1,theta1,theta2);

figure()
sgtitle("T1 = -1 Nm, T2 = 1 Nm")
subplot(2,2,1)
surf(X,Y,Fx_m11Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx")
colorbar

subplot(2,2,2)
surf(X,Y,Fy_m11Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy")
colorbar


subplot(2,2,3)
surf(X,Y,Fx_m11Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx (Old Design)")
colorbar

subplot(2,2,4)
surf(X,Y,Fy_m11Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy (Old Design)")
colorbar



%T1 = -1 Nm, T2 = -1 Nm
Fx_m1m1Nm = Fx(-1,-1,theta1,theta2);
Fy_m1m1Nm = Fy(-1,-1,theta1,theta2);

Fx_m1m1Nm_old = Fx_old(-1,-1,theta1,theta2);
Fy_m1m1Nm_old = Fy_old(-1,-1,theta1,theta2);

figure()
sgtitle("T1 = -1 Nm, T2 = -1 Nm")
subplot(2,2,1)
surf(X,Y,Fx_m1m1Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx")
colorbar

subplot(2,2,2)
surf(X,Y,Fy_m1m1Nm,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy")
colorbar


subplot(2,2,3)
surf(X,Y,Fx_m1m1Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fx (N)")
title("Fx (Old Design)")
colorbar

subplot(2,2,4)
surf(X,Y,Fy_m1m1Nm_old,'EdgeColor','none')
xlabel("X")
ylabel("Y")
zlabel("Fy (N)")
title("Fy (Old Design)")
colorbar




%% Paramters

I1 = 0.0430; %kg.m2
I2 = 0.234; %kg.m2
c1 = 0.5;
c2 = 0.5;
k1 = 2;
k2 = 2;

% sim("Joey_Control.slx")



