%% 1. VUNG LAM VIEC (dau hut chi xuong)
zw0 = -P.d1 - P.a4*sin(phi_tool);        % cao co tay J4 so voi vai khi dau hut cham ban (z=0)
reach_max = sqrt((P.a2+P.a3)^2 - zw0^2);
fprintf('1) Tam voi toi da khi dau hut chi xuong, cham ban: %.1f mm (muc tieu 200 mm, du %.1f%%)\n', ...
    reach_max, (reach_max/200-1)*100);
for d1v = [50 75 100 150]                % anh huong do cao truc vai
    fprintf('   d1 = %3d mm -> tam voi toi da = %.1f mm\n', d1v, sqrt((P.a2+P.a3)^2-(P.a4-d1v)^2));
end
zmax_at200 = sqrt((P.a2+P.a3)^2 - 200^2) + P.d1 - P.a4;
fprintf('   Tai r = 200 mm, dau hut chi nang duoc toi da z = %.1f mm so voi mat ban\n', zmax_at200);
 
rv = 0:2:260;  zv = -20:2:200;  okmap = false(numel(zv), numel(rv));
for i = 1:numel(zv)
    for j = 1:numel(rv)
        q = ik_arm([rv(j) 0 zv(i)], phi_tool, -1, P);
        okmap(i,j) = ~isempty(q) && all(q >= lim(:,1).'-1e-9) && all(q <= lim(:,2).'+1e-9);
    end
end
figure; imagesc(rv, zv, okmap); axis xy equal tight; colormap([1 1 1; 0.6 0.85 0.7]); hold on;
plot([0 260],[0 0],'r-'); plot([200 200],[-20 200],'k--');
xlabel('r (mm)'); ylabel('z (mm)'); title('Vung dat duoc khi dau hut chi xuong (xanh); do = mat ban, net dut = r 200 mm');