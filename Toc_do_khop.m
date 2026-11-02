%% 3. JACOBI: TOC DO DAU HUT -> TOC DO KHOP
axn = 'xyz';
fprintf('\n3) Toc do khop (do/s) khi dau hut di 100/150/200 mm/s theo x, y, z (phi giu nguyen):\n');
for k = 1:numel(names)
    q = Qk(k,:);  if any(isnan(q)), continue; end
    J = jac4(q, P);
    fprintf('   %-12s cond(J) = %.0f\n', names{k}, cond(J));
    for v = [100 150 200]
        fprintf('     v = %3d: ', v);
        for dir = 1:3
            e = zeros(4,1); e(dir) = v;
            qd = abs(rad2deg(J \ e));
            fprintf('%s: max %6.1f (J%d)  ', axn(dir), max(qd), find(qd==max(qd),1));
        end
        fprintf('\n');
    end
    % Toc do dau hut cho phep theo tung huong de khong vuot omega_max
    for dir = 1:3
        e = zeros(4,1); e(dir) = 1;
        qd1 = abs(rad2deg(J \ e));                % deg/s tren 1 mm/s
        fprintf('     v_cho_phep_%s = %6.1f mm/s\n', axn(dir), omega_max/max(qd1));
    end
end