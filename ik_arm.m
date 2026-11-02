function q = ik_arm(p, phi, sgn, P)    % [] neu ngoai tam voi
    x = p(1); y = p(2); z = p(3);
    q1 = atan2(y, x);  r = hypot(x, y);
    rw = r - P.a4*cos(phi);  zw = z - P.d1 - P.a4*sin(phi);
    c3 = (rw^2 + zw^2 - P.a2^2 - P.a3^2)/(2*P.a2*P.a3);
    if abs(c3) > 1, q = []; return; end
    s3 = sgn*sqrt(1 - c3^2);  q3 = atan2(s3, c3);
    q2 = atan2(zw, rw) - atan2(P.a3*s3, P.a2 + P.a3*c3);
    q  = [q1 q2 q3 phi-q2-q3];
end