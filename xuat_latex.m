%% 6. XUAT RA HAM SO / LATEX / THAY SO
% 6a. Doi ra ham MATLAB chay nhanh de dung tiep (khong con ky hieu)
fk_fun = matlabFunction(T04, 'Vars', {[q1 q2 q3 q4], [d1 a2 a3 a4]});
J_fun  = matlabFunction(J,   'Vars', {[q1 q2 q3 q4], [d1 a2 a3 a4]});
% Dung: T = fk_fun(deg2rad([30 40 -60 -20]), [50 119 113 150]);
 
% 6b. Thay so khi can (giu nguyen bieu thuc ky hieu o tren):
% subs(p, [q1 q2 q3 q4 d1 a2 a3 a4], [pi/6 2*pi/9 -pi/3 -pi/9 50 119 113 150])
 
% 6c. Ma LaTeX de dan vao bao cao:
% latex(T04)    latex(Jv)    latex(detJ)