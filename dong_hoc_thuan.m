%% 2. DONG HOC THUAN
% Nhom 3 khop phang truoc de co sin/cos cua tong goc
A24 = simplify(combine(A2*A3*A4, 'sincos'));
T04 = simplify(A1 * A24);
disp('T04 = '); pretty(T04)
 
p = T04(1:3,4);                 % vi tri dau hut: x, y, z
R = T04(1:3,1:3);               % huong
disp('x ='); pretty(p(1)); disp('y ='); pretty(p(2)); disp('z ='); pretty(p(3));
 
% KET QUA MONG DOI (de doi chieu), voi c234 = cos(q2+q3+q4), s234 = sin(q2+q3+q4):
%   T04 = [ c1*c234  -c1*s234   s1   c1*(a2*c2 + a3*c23 + a4*c234)
%           s1*c234  -s1*s234  -c1   s1*(a2*c2 + a3*c23 + a4*c234)
%           s234      c234      0    d1 + a2*s2 + a3*s23 + a4*s234
%           0         0         0    1 ]