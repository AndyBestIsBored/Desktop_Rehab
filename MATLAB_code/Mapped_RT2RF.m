clear
clc

%% Construct Equation


syms T2 l4 t2 l2 T1 t1 l1 Fx Fy F21x F21y
e1 = Fx-F21x+T2*l4*cos(t1) ==0
e2 = Fy+F21y+T2*l4*sin(t1)==0
e3 = Fx*l2*cos(t2)+Fy*l2*sin(t2)-T2*l4^2*cos(t1)*cos(t2)-T2*l4^2*sin(t1)*sin(t2)==0 
e4 = T1-F21x*l1*sin(t1)-F21y*l1*cos(t1)==0


sol = solve(e1,e2,e3,e4,Fx,Fy,F21x,F21y)

pretty(simplify(sol.Fx))
pretty(simplify(sol.Fy))


sol_inv = solve(e1,e2,e3,e4,T1,T2,F21x,F21y)
pretty(simplify(sol_inv.T1))
pretty(simplify(sol_inv.T2))

%% Validating

l1_val = 0.275;
l2_val = 0.24;
l4_val = 0.010;


T1_eq = matlabFunction(subs(sol_inv.T1,{l1,l2,l4},{l1_val,l2_val,l4_val}))
T2_eq = matlabFunction(subs(sol_inv.T2,{l1,l2,l4},{l1_val,l2_val,l4_val}))

