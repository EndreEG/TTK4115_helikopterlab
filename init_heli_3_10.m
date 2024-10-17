
% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]
e_offset= 0.5;
k_f = 0.1345;
vs_0 = 8;
k_1 = k_f/(2*m_p*l_p);
lambda_1= -5;
lambda_2= -5;
k_p = (lambda_1*lambda_2)/k_1;
k_d = (-lambda_1-lambda_2)/k_1;
A=[0,1,0,0,0;0,0,0,0,0;0,0,0,0,0;-1,0,0,0,0;0,0,-1,0,0];
l_1=k_f*l_p;
l_2=g*(m_c*l_c-2*m_p*l_h);
l_3=l_h*k_f;
l_4=k_f*l_h;
j_e=m_c*l_c^2+2*m_p*l_h^2;
k_1=l_1/(2*m_p*l_p^2);
k_2=l_3/j_e;
k_3=(l_4*(l_2/l_3))/(m_c*l_c^2+2*m_p*(l_h^2+l_p^2));
B=[0,0;0,k_1;k_2,0;0,0;0,0];
q_1=50;
q_2=25;
q_3=30;
q_4=20;
q_5=10;
Q_LQR=[q_1,0,0,0,0;0,q_2,0,0,0;0,0,q_3,0,0;0,0,0,q_4,0;0,0,0,0,q_5];
r_1=1;
r_2=1;
R_LQR=[r_1,0;0,r_2];
K=lqr(A,B,Q_LQR,R_LQR);
F=[K(1,1),K(1,3);K(2,1),K(2,3)];
A_lue=[0,1,0,0,0;0,0,0,0,0;0,0,0,1,0;0,0,0,0,0;k_3,0,0,0,0];
PORT=5;
B_lue=[0,0;0,k_1;0,0;k_2,0;0,0];
C=diag([1 1 1 1 1]);
p=[-2,-2.5,-3,-3.5,-4];
L=place(A_lue',C',3*p)';
