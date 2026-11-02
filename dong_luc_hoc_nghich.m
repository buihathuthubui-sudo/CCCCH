%% 4. DONG LUC HOC NGHICH CHO MOT CHU TRINH GAP-THA
% tau_i = sum_k m_k * (dp_k/dq_i)' * (kappa*a_k + [0;0;g]),  a_k = d2 p_k / dt2
% (mo hinh khoi luong diem, quan tinh rieng gop vao kappa, khong tinh Coriolis rieng vi
%  a_k lay truc tiep tu quy dao)
v_free = 100;  v_app = 40;  a_tcp = 500;  t_dwell = 0.5;     % mm/s, mm/s, mm/s^2, s
W = struct('home',[110 0 60],'ph',[200 0 15],'pk',[200 0 0],'plh',[100 150 30],'pl',[100 150 0]);
% tu, den, toc do, co vat (1/0), dung doi (s)
S = { 'home','ph', v_free, 0, 0;  'ph','pk', v_app, 0, 0;  'pk','pk', 0, 0, t_dwell;
      'pk','ph', v_app, 1, 0;  'ph','plh', v_free, 1, 0;  'plh','pl', v_app, 1, 0;
      'pl','pl', 0, 1, t_dwell; 'pl','plh', v_app, 0, 0;  'plh','home', v_free, 0, 0 };
T = []; X = []; Fl = []; t0 = 0;
for s = 1:size(S,1)
    A = W.(S{s,1}); B = W.(S{s,2}); v = S{s,3}; pl = S{s,4}; td = S{s,5};
    if td > 0
        n = floor(td/dt);  t = t0 + (0:n-1)'*dt;
        T = [T; t]; X = [X; repmat(B,n,1)]; Fl = [Fl; pl*ones(n,1)]; t0 = t0 + n*dt;   %#ok<AGROW>
    else
        L = norm(B-A);  a = a_tcp;
        if L >= v^2/a, ta = v/a; tc = (L - v^2/a)/v; Ts = 2*ta + tc;
        else,           vp = sqrt(a*L); ta = vp/a; tc = 0; Ts = 2*ta; v = vp; end
        n = floor(Ts/dt) + 1;  tl = min((0:n-1)'*dt, Ts);  sp = zeros(n,1);
        i1 = tl < ta;  i2 = tl >= ta & tl < ta+tc;  i3 = tl >= ta+tc;
        sp(i1) = 0.5*a*tl(i1).^2;
        sp(i2) = 0.5*a*ta^2 + v*(tl(i2)-ta);
        sp(i3) = L - 0.5*a*(Ts - tl(i3)).^2;
        T = [T; t0 + (0:n-1)'*dt]; X = [X; A + (sp/L)*(B-A)]; Fl = [Fl; pl*ones(n,1)]; t0 = t0 + n*dt; %#ok<AGROW>
    end
end
N = numel(T);
Q = zeros(N,4);
for i = 1:N, Q(i,:) = ik_arm(X(i,:), phi_tool, -1, P); end
qd = ddt(Q, dt);                                  % rad/s
tau = zeros(N,5);
for k = 1:size(M,1)
    pk = zeros(N,3);
    for i = 1:N, pk(i,:) = pos_k(Q(i,:), M{k,2}, M{k,3}, P); end
    acc = ddt(ddt(pk, dt), dt);
    for i = 1:N
        if strcmp(M{k,2},'payload') && Fl(i) == 0, continue; end
        Jk = dpos_k(Q(i,:), M{k,2}, M{k,3}, P);
        tau(i,1:4) = tau(i,1:4) + M{k,1} * (Jk.' * (kappa*acc(i,:).' + [0;0;g])).';
    end
end
tau(:,5) = (0.014 + 0.05*Fl) * g * 0.007;         % J5: chi tinh (truc dau hut), tay don 7 mm
 
% Gioi han: J1 quy ve mam (0.086 N.m motor x 5 x 0.95), servo = 40% mo-men stall
lim_tau = [0.41 0.4316 0.4316 0.0784 0.0784];
KT = [NaN 0.4315 0.4315 0.228 0.228];  Rw = [NaN 2.4 2.4 6.98 6.98];   % N.m/A, ohm (6 V)
fprintf('\n4) Dong luc hoc nghich - chu trinh %.2f s (v_free=%d, v_app=%d mm/s, a=%d mm/s^2)\n', ...
    T(end), v_free, v_app, a_tcp);
fprintf('   Khop | dinh |tau| | %%gioi han | RMS tau | I_rms | P_Cu_tb | max |qdot| (do/s)\n');
qdmax = max(abs(rad2deg(qd)),[],1);
for j = 1:5
    pk_ = max(abs(tau(:,j)));  rm = sqrt(mean(tau(:,j).^2));
    if j >= 2, Irms = rm/KT(j); Pcu = Irms^2*Rw(j); else, Irms = NaN; Pcu = NaN; end
    qdj = qdmax(min(j,4));  if j == 5, qdj = NaN; end
    fprintf('   J%d   | %.3f | %5.1f%%    | %.3f   | %.2f A | %.2f W | %.0f\n', ...
        j, pk_, 100*pk_/lim_tau(j), rm, Irms, Pcu, qdj);
end
figure; plot(T, tau(:,1:3)); hold on; yline_(0.4316,'r--'); legend('J1','J2','J3','40% stall MG996R');
xlabel('t (s)'); ylabel('\tau (N.m)'); title('Mo-men khop trong mot chu trinh gap-tha'); grid on;
figure; plot(T, rad2deg(qd)); legend('q1','q2','q3','q4'); xlabel('t (s)'); ylabel('deg/s'); grid on;
title('Toc do khop (so voi omega\_max = 200 deg/s)');