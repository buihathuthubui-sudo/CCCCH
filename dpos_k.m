function J = dpos_k(q, kind, s, P)  % Jacobi so cua vi tri khoi, 3x4 (m/rad)
    J = zeros(3,4); e = 1e-6;
    for i = 1:4
        qp = q; qm = q; qp(i) = qp(i)+e; qm(i) = qm(i)-e;
        J(:,i) = ((pos_k(qp,kind,s,P) - pos_k(qm,kind,s,P))/(2*e)).';
    end
end