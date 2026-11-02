%% ROBOT ARM - PHAN TICH: VUNG LAM VIEC, GOC KHOP, TOC DO (JACOBI), DONG LUC HOC NGHICH
% Don vi: mm, rad (hien thi do), N.m. Dau hut luon chi xuong (phi = -90 do).
% Chay: robot_arm_phan_tich   (MATLAB R2016b tro len, khong can toolbox)
% Cac so lieu LA GIA DINH / SUY RA - sua o muc 0 cho dung CAD:
%   d1 = 50 mm (cao truc vai so voi mat ban) la so mau, CHUA lay tu CAD.
clear; clc; close all;
 
%% 0. THONG SO
P.d1 = 50;  P.a2 = 119;  P.a3 = 113;  P.a4 = 150;
phi_tool  = -pi/2;                       % dau hut chi xuong
omega_max = 200;                         % deg/s - gioi han bo gioi han chuyen dong
lim = deg2rad([-90 90; 0 120; -135 0; -150 -30]);   % q1..q4 (SUA theo lap rap that)
g = 9.81;  kappa = 1.1;  dt = 0.005;     % kappa: +10% quan tinh rieng cac khau
 
% Khoi luong diem (kg), kieu, tham so [mm] - dung lai theo bang tai khop + dau hut 14 g
%  l1: khau 1 (trong tam cach J2 59.5 mm) | l2: khau 2 (cach J3 45.2 mm)
%  wr: khoi co tay tai J4 | tool: dau hut (100 mm duoi J4, lech 6 mm)
%  tubeend: ong khi doan cuoi | payload: vat 50 g (150.6 mm duoi J4, lech 6 mm)
M = { 0.05256,'l1',59.5; 0.11048,'l2',45.2; 0.0371,'wr',0; 0.014,'tool',100;
      0.00196,'tubeend',75; 0.050,'payload',150.6 };
 