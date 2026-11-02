%% 4. DONG HOC NGHICH DANG KY HIEU
syms px py pz phi real
sgn = -1;                                         % -1: khuyu len, +1: khuyu xuong
q1_ik = atan2(py, px);
r_    = sqrt(px^2 + py^2);
rw    = r_ - a4*cos(phi);
zw    = pz - d1 - a4*sin(phi);
c3    = (rw^2 + zw^2 - a2^2 - a3^2) / (2*a2*a3);
s3    = sgn*sqrt(1 - c3^2);
q3_ik = atan2(s3, c3);
q2_ik = atan2(zw, rw) - atan2(a3*s3, a2 + a3*c3);
q4_ik = phi - q2_ik - q3_ik;
disp('q1 = '); pretty(q1_ik); disp('c3 = '); pretty(c3);
disp('q2 = '); pretty(q2_ik); disp('q4 = '); pretty(q4_ik);