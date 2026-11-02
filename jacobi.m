%% 3. JACOBI
Jv  = simplify(jacobian(p, [q1 q2 q3 q4]));      % 3x4 (van toc dai)
J   = [Jv; 0 1 1 1];                             % them hang phi = q2+q3+q4 -> 4x4
detJ = simplify(det(J));
disp('Jv ='); pretty(Jv)
disp('det(J) ='); pretty(detJ)
% det(J) = -r * a2 * a3 * sin(q3),  r = a2*c2 + a3*c23 + a4*c234
% Ky di khi: r = 0 hoac sin(q3) = 0
 
% Jacobi van toc goc (cho 3 khop quay, truc z cua tung khung):
z0 = [0;0;1];
T01 = A1; T02 = simplify(A1*A2); T03 = simplify(T02*A3);
z1 = T01(1:3,3); z2 = T02(1:3,3); z3 = T03(1:3,3);
Jw = simplify([z0, z1, z2, z3]);                 % 3x4
Jfull = [Jv; Jw];                                % 6x4 (Jacobi hinh hoc)