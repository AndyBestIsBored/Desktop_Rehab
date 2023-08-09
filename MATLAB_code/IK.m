clear
clc

syms q1 q2 x y
l1 = 0.275;
l2 = 0.24;
f1 = @(q1,q2) l1*cosd(q1)-l2*sind(q2);
f2 = @(q1,q2) l1*sind(q1)+l2*cosd(q2);
ikk = solve([f1 == x f2 == y],[q1 q2]);

ik1 = matlabFunction(simplify(ikk.q1(1)), 'Var', [x,y]);
ik2 = matlabFunction(simplify(ikk.q2(1)), 'Var', [x,y]);
ik = @(x,y) [ik1(x,y); ik2(x,y)]



