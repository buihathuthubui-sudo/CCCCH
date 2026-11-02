%% CHAY TAT CA - dat file nay CUNG THU MUC voi cac file .m con lai roi bam Run (F5)
% Thu tu chay:
%   A. Phan ky hieu (can Symbolic Math Toolbox): bien_tham_so -> dong_hoc_thuan -> jacobi
%                                               -> dong_hoc_nghich -> mo_men -> xuat_latex
%   B. Phan so: thong_so -> work_space (muc 1) -> goc_khop_tu_the_quan_trong (muc 2)
%                        -> Toc_do_khop (muc 3) -> dong_luc_hoc_nghich (muc 4)
% Luu y: nhieu file con co lenh "clear", nen file nay khong giu bien nao giua cac buoc.
% Phan A phai chay TRUOC phan B (mo_men.m dung syms g, thong_so.m dat lai g = 9.81).
 
% --- Chuyen vao thu muc chua file nay de chay duoc tu bat ky noi nao ---
here = fileparts(mfilename('fullpath'));
if ~isempty(here), cd(here); addpath(here); end
 
% --- Kiem tra du file truoc khi chay ---
files = {'bien_tham_so','dong_hoc_thuan','jacobi','dong_hoc_nghich','mo_men','xuat_latex', ...
         'thong_so','work_space','goc_khop_tu_the_quan_trong','Toc_do_khop','dong_luc_hoc_nghich', ...
         'ik_arm','jac4','pos_k','dpos_k','ddt','yline_'};
missing = {};
for k = 1:numel(files)
    if exist(files{k}, 'file') ~= 2, missing{end+1} = files{k}; end %#ok<SAGROW>
end
if ~isempty(missing)
    error('Thieu file .m trong thu muc: %s', strjoin(missing, ', '));
end
has_sym = license('test','Symbolic_Toolbox') && ~isempty(which('syms'));
 
%% A. PHAN KY HIEU
fprintf('\n================ A. PHAN KY HIEU ================\n');
if has_sym
    try
        bien_tham_so;
        dong_hoc_thuan;
        jacobi;
        dong_hoc_nghich;
        mo_men;
        xuat_latex;
    catch err
        fprintf(2, 'LOI o phan ky hieu: %s\n', err.message);
    end
else
    fprintf('Bo qua phan A: may khong co Symbolic Math Toolbox.\n');
end
 
%% B. PHAN SO
fprintf('\n================ B. PHAN SO ================\n');
try
    thong_so;                      % dat thong so (co "clear")
    work_space;                    % muc 1: vung lam viec
    goc_khop_tu_the_quan_trong;    % muc 2: goc khop (tao names, Qk cho muc 3)
    Toc_do_khop;                   % muc 3: Jacobi toc do
    dong_luc_hoc_nghich;           % muc 4: dong luc hoc nghich, ve do thi
catch err
    fprintf(2, 'LOI o phan so: %s\n', err.message);
    fprintf(2, '  (file: %s, dong %d)\n', err.stack(1).name, err.stack(1).line);
end
fprintf('\nXong.\n');