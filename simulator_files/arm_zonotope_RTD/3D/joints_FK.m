function X = joints_FK(in1)
%JOINTS_FK
%    X = JOINTS_FK(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    16-Aug-2019 16:33:41

q1 = in1(1,:);
q2 = in1(2,:);
q3 = in1(3,:);
q4 = in1(4,:);
q5 = in1(5,:);
q6 = in1(6,:);
t2 = cos(q2);
t3 = cos(q1);
t4 = t2.*t3.*(3.3e1./1.0e2);
t5 = sin(q1);
t6 = sin(q2);
t7 = t2.*t5.*(3.3e1./1.0e2);
t8 = sin(q4);
t9 = sin(q3);
t10 = cos(q3);
t11 = cos(q4);
t12 = t5.*t9;
t13 = t3.*t6.*t10;
t14 = t12+t13;
t15 = t2.*t3.*t11.*(3.3e1./1.0e2);
t16 = cos(q6);
t17 = t3.*t9;
t21 = t5.*t6.*t10;
t18 = t17-t21;
t19 = sin(q6);
t20 = cos(q5);
t22 = sin(q5);
t23 = t8.*t18.*(3.3e1./1.0e2);
t24 = t2.*t5.*t11.*(3.3e1./1.0e2);
X = [t4;t7;t6.*(-3.3e1./1.0e2);t4+t15-t8.*t14.*(3.3e1./1.0e2);t7+t23+t24;t6.*(-3.3e1./1.0e2)-t6.*t11.*(3.3e1./1.0e2)-t2.*t8.*t10.*(3.3e1./1.0e2);t4+t15-t16.*(t8.*t14-t2.*t3.*t11).*(3.3e1./1.0e2)-t8.*t14.*(3.3e1./1.0e2)-t19.*(t22.*(t5.*t10-t3.*t6.*t9)+t20.*(t11.*t14+t2.*t3.*t8)).*(3.3e1./1.0e2);t7+t23+t24+t16.*(t8.*t18+t2.*t5.*t11).*(3.3e1./1.0e2)+t19.*(t22.*(t3.*t10+t5.*t6.*t9)+t20.*(t11.*t18-t2.*t5.*t8)).*(3.3e1./1.0e2);t6.*(-3.3e1./1.0e2)+t19.*(t20.*(t6.*t8-t2.*t10.*t11)+t2.*t9.*t22).*(3.3e1./1.0e2)-t16.*(t6.*t11+t2.*t8.*t10).*(3.3e1./1.0e2)-t6.*t11.*(3.3e1./1.0e2)-t2.*t8.*t10.*(3.3e1./1.0e2)];
