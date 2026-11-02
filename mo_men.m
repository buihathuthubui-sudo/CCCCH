%% 5. MO-MEN TINH DANG KY HIEU: tau = Jv' * F
syms m g real
F   = [0; 0; -m*g];
tau = simplify(Jv.' * F);                         % N.mm neu J tinh theo mm
disp('tau = Jv'' * F ='); pretty(tau)