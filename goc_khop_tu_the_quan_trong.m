%% 2. GOC KHOP CAC TU THE QUAN TRONG
names = {'home','pick_hover','pick','place_hover','place'};
xyz   = [110 0 60; 200 0 15; 200 0 0; 100 150 30; 100 150 0];
Qk = nan(numel(names),4);
fprintf('\n2) Goc khop (do) o cac tu the (dau hut chi xuong):\n');
for k = 1:numel(names)
    q = ik_arm(xyz(k,:), phi_tool, -1, P);
    if isempty(q), fprintf('   %-12s KHONG TOI DUOC\n', names{k}); continue; end
    Qk(k,:) = q;
    ok = all(q >= lim(:,1).'-1e-9) && all(q <= lim(:,2).'+1e-9);
    fprintf('   %-12s q = [%7.1f %7.1f %7.1f %7.1f]  trong gioi han: %d\n', names{k}, rad2deg(q), ok);
end
qmin = min(Qk,[],1); qmax = max(Qk,[],1);
fprintf('   Khoang can cua cac tu the tren (do): q2 [%.1f %.1f], q3 [%.1f %.1f], q4 [%.1f %.1f]\n', ...
    rad2deg([qmin(2) qmax(2) qmin(3) qmax(3) qmin(4) qmax(4)]));
% Khoang goc can cho TOAN vung r = 60..200, z = 0..100 (de chon gioi han lap rap)
mn = inf(1,4); mx = -inf(1,4);
for r = 60:5:200
    for z = 0:10:100
        q = ik_arm([r 0 z], phi_tool, -1, P);
        if ~isempty(q), mn = min(mn,q); mx = max(mx,q); end
    end
end
fprintf('   Toan vung: q2 [%.1f %.1f], q3 [%.1f %.1f], q4 [%.1f %.1f] (hanh trinh moi servo toi da ~180)\n', ...
    rad2deg([mn(2) mx(2) mn(3) mx(3) mn(4) mx(4)]));