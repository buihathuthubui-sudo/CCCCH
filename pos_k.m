function p = pos_k(q, kind, s, P)   % vi tri khoi (m)
    q1=q(1); q2=q(2); q3=q(3); q4=q(4); ph = q2+q3+q4;
    j3 = [P.a2*cos(q2), P.d1+P.a2*sin(q2)];
    j4 = j3 + P.a3*[cos(q2+q3), sin(q2+q3)];
    u = [cos(ph) sin(ph)];  n = [-sin(ph) cos(ph)];
    switch kind
        case 'l1',      rz = s*[cos(q2) sin(q2)] + [0 P.d1];
        case 'l2',      rz = j3 + s*[cos(q2+q3) sin(q2+q3)];
        case 'wr',      rz = j4;
        case 'tool',    rz = j4 + s*u + 6*n;
        case 'tubeend', rz = j4 + s*u;
        case 'payload', rz = j4 + s*u + 6*n;
    end
    p = [rz(1)*cos(q1) rz(1)*sin(q1) rz(2)] * 1e-3;
end