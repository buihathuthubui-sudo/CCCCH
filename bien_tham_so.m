%% ROBOT ARM - DONG HOC DANG KY HIEU (can Symbolic Math Toolbox)
% Ket qua la ma tran / ham theo bien q1..q4 va tham so d1,a2,a3,a4, KHONG thay so.
clear; clc;
 
%% 1. KHAI BAO BIEN VA THAM SO
syms q1 q2 q3 q4 real
syms d1 a2 a3 a4 positive
 
dh = @(th,d,a,al) [cos(th) -sin(th)*cos(al)  sin(th)*sin(al) a*cos(th);
                   sin(th)  cos(th)*cos(al) -cos(th)*sin(al) a*sin(th);
                   0        sin(al)          cos(al)         d;
                   0        0                0               1];
 
A1 = dh(q1, d1, 0,  sym(pi)/2);
A2 = dh(q2, 0,  a2, 0);
A3 = dh(q3, 0,  a3, 0);
A4 = dh(q4, 0,  a4, 0);