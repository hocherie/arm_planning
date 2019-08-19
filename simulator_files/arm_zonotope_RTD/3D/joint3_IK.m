function [E,J] = joint3_IK(in1,in2,in3)
%JOINT3_IK
%    [E,J] = JOINT3_IK(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    16-Aug-2019 16:45:03

q1 = in2(1,:);
q2 = in2(2,:);
q3 = in2(3,:);
q4 = in2(4,:);
q5 = in3(1,:);
q6 = in3(2,:);
x3 = in1(1,:);
y3 = in1(2,:);
z3 = in1(3,:);
t2 = cos(q1);
t3 = cos(q2);
t4 = cos(q4);
t5 = sin(q1);
t6 = sin(q3);
t7 = t5.*t6;
t8 = cos(q3);
t9 = sin(q2);
t10 = t2.*t8.*t9;
t11 = t7+t10;
t12 = sin(q4);
t13 = cos(q6);
t14 = sin(q6);
t15 = cos(q5);
t16 = t2.*t6;
t19 = t5.*t8.*t9;
t17 = t16-t19;
t18 = sin(q5);
t20 = t3.*t5.*(3.3e1./1.0e2);
t21 = t2.*t3.*(3.3e1./1.0e2);
E = [t21-x3-t13.*(t11.*t12-t2.*t3.*t4).*(3.3e1./1.0e2)-t11.*t12.*(3.3e1./1.0e2)-t14.*(t15.*(t4.*t11+t2.*t3.*t12)+t18.*(t5.*t8-t2.*t6.*t9)).*(3.3e1./1.0e2)+t2.*t3.*t4.*(3.3e1./1.0e2);t20-y3+t13.*(t12.*t17+t3.*t4.*t5).*(3.3e1./1.0e2)+t12.*t17.*(3.3e1./1.0e2)+t14.*(t18.*(t2.*t8+t5.*t6.*t9)+t15.*(t4.*t17-t3.*t5.*t12)).*(3.3e1./1.0e2)+t3.*t4.*t5.*(3.3e1./1.0e2);t9.*(-3.3e1./1.0e2)-z3+t14.*(t15.*(t9.*t12-t3.*t4.*t8)+t3.*t6.*t18).*(3.3e1./1.0e2)-t13.*(t4.*t9+t3.*t8.*t12).*(3.3e1./1.0e2)-t4.*t9.*(3.3e1./1.0e2)-t3.*t8.*t12.*(3.3e1./1.0e2)];
if nargout > 1
    J = reshape([-t20,t21,0.0,t2.*t9.*(-3.3e1./1.0e2),t5.*t9.*(-3.3e1./1.0e2),t3.*(-3.3e1./1.0e2)],[3,2]);
end
