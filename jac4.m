function J = jac4(q, P)    % d[x y z phi]/d[q1..q4]
    q1=q(1); q2=q(2); q3=q(3); q4=q(4);
    s2=sin(q2); s23=sin(q2+q3); s234=sin(q2+q3+q4);
    c2=cos(q2); c23=cos(q2+q3); c234=cos(q2+q3+q4);
    r  = P.a2*c2 + P.a3*c23 + P.a4*c234;
    dr = [0, -(P.a2*s2+P.a3*s23+P.a4*s234), -(P.a3*s23+P.a4*s234), -P.a4*s234];
    dz = [0,  P.a2*c2+P.a3*c23+P.a4*c234,    P.a3*c23+P.a4*c234,    P.a4*c234];
    x = r*cos(q1); y = r*sin(q1);
    J = [ -y, dr(2)*cos(q1), dr(3)*cos(q1), dr(4)*cos(q1);
           x, dr(2)*sin(q1), dr(3)*sin(q1), dr(4)*sin(q1);
           0, dz(2),         dz(3),         dz(4);
           0, 1,             1,             1 ];
end
 