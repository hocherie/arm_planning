function dw = arm_dyn_toStop_3D(tdummy,in2,udummy)
%ARM_DYN_TOSTOP_3D
%    DW = ARM_DYN_TOSTOP_3D(TDUMMY,IN2,UDUMMY)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    15-Aug-2019 16:11:04

cph = in2(5,:);
phi_dot_pk = in2(8,:);
sph = in2(4,:);
t = in2(10,:);
theta_dot_pk = in2(9,:);
x = in2(1,:);
y = in2(2,:);
z = in2(3,:);
t2 = t-1.0./2.0;
t6 = phi_dot_pk.*t2.*2.0;
t3 = phi_dot_pk-t6;
t5 = t2.*theta_dot_pk.*2.0;
t4 = -t5+theta_dot_pk;
dw = [-t3.*y-cph.*t4.*z;t3.*x-sph.*t4.*z;t4.*(cph.*x+sph.*y);cph.*t3;-sph.*t3;0.0;0.0;0.0;0.0;1.0];
