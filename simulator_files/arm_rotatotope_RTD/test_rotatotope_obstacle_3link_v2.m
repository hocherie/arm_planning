clear all; clc;

teston = 1;
% code for testing the constraint generation for a 3 link arm
figure(1); clf; hold on; axis equal;

% set FRS_options
FRS_options = struct();
FRS_options.t_plan = 0.01;
FRS_options.T = 1;
FRS_options.L = 0.33;
FRS_options.buffer_dist = 0;
FRS_options.combs = generate_combinations_upto(200);
FRS_options.maxcombs = 200;
% FRS_options.origin_shift = [-0.0326; 0; 0.7260];
FRS_options.origin_shift = zeros(3, 1);


% get current obstacles
obs_center = [0; 0; 0];
obs_width = [0.06];
O{1} = box_obstacle_zonotope('center', obs_center(:), 'side_lengths', [obs_width, obs_width, obs_width]);
obs_patch = plotFilled(O{1}.zono, [1, 3], 'r');
obs_patch.FaceAlpha = 0.2;
% plot(O{1});
% O = {};

% get current state of robot
% q_0 = 0*ones(6, 1) ;
q_0 = [0; 0; 0; pi/2 + 5*pi/48; 0; pi/2 + 5*pi/48];
% q_0 = [pi/6; pi/4; pi/6; -pi/4; pi/6; pi/4];
q_dot_0 = 0*ones(6, 1) ;
% good_k = -pi/6*ones(6, 1) ;
% bad_k = pi/6*ones(6, 1) - 0.001 ;
% bad_k = [pi/6 - 0.001; pi/6 - 0.001; pi/12; pi/24; -pi/36; pi/48];
% bad_k = [pi/6 - 0.001; -pi/6 + 0.001; pi/6 - 0.001; pi/6 - 0.001; -pi/6 + 0.001; pi/6 - 0.001];
% bad_k = [pi/6 - 0.001; -pi/6 + 0.001 ; pi/6 - 0.001 ; -pi/6 + 0.001; pi/6 - 0.001; pi/6 - 0.001];
% bad_k = -pi/6*ones(6, 1) + 0.001;
good_k = [0; 0; 0; -pi/6 + 0.001; 0; -pi/6 + 0.001];
bad_k = [0; 0; 0; pi/6 - 0.001; 0; pi/6 - 0.001];


% generate FRS
R = robot_arm_FRS_rotatotope_fetch(q_0, q_dot_0, FRS_options);
% R.plot(99, {'b', 'b', 'b'});
% R.plot_slice(good_k, 10, {'g', 'g', 'g'});
% R.plot_slice(bad_k, 10, {'r', 'r', 'r'});
% R.plot_slice_gensIncluded(bad_k, 10, {'r', 'r', 'r'});

% map obstacles to trajectory parameter space
R = R.generate_constraints(O);

% generate self intersection constraints
% R = R.generate_self_intersection_constraints();

% grid the k_4, k_6 constraint space
if teston
    idx1 = 1;
    idx2 = 3;
%     for idx2 = 1:100
            idx3 = 100;
        
        A_con = R.A_con{idx1}{idx2}{idx3};
        b_con = R.b_con{idx1}{idx2}{idx3};
        k_con = R.k_con{idx1}{idx2}{idx3};
        
        c_k = R.c_k;
        g_k = R.g_k;
        
        figure(2); clf; hold on;
        lims = [-g_k(4) -g_k(4) g_k(4) g_k(4) -g_k(4); -g_k(6) g_k(6) g_k(6) -g_k(6) -g_k(6)];
        plot(lims(1, :)', lims(2, :)', 'k--', 'LineWidth', 4);
        
        myk = linspace(-g_k(4), g_k(4), 50);
        [Xk, Yk] = meshgrid(myk, myk);
        % Zk = zeros(size(Xk));
        for i = 1:length(myk)
            for j = 1:length(myk)
                K = [0;0;0;Xk(i, j); 0;Yk(i, j)];
                lambda = (K - c_k)./g_k;
                lambdas_prod = k_con.*lambda;
                
                % dumb way to do this... want to multiply rows of lambdas
                % together, replacing zeros with ones
%                 lambdas_prod = lambdas_orig;
                lambdas_prod(~k_con) = 1;
                lambdas_prod = prod(lambdas_prod, 1)';
%                 lambdas_prod(~any(lambdas_orig)) = 0; % set lambdas corresponding to all zero columns equal to zero
                
                Zk = A_con*lambdas_prod - b_con;
                Zk = max(Zk);
                Zk = -Zk;
%                 disp(Zk);
                %             Zk = -Zk; % hmm i'm off by this extra negative sign somewhere
                if Zk >= 0
                    plot(Xk(i, j), Yk(i, j), 'r.', 'MarkerSize', 10, 'LineWidth', 6);
%                     pause;
                end
            end
%         end
    end
    
    xlabel('k_4', 'FontSize', 20);
    ylabel('k_6', 'FontSize', 20);
    plot(good_k(4), good_k(6), 'g.', 'MarkerSize', 20);
    plot(bad_k(4), bad_k(6), 'r.', 'MarkerSize', 20);
    
    disp('Click a point!');
    [p1, p2] = ginput(1);
    plot(p1, p2, 'kx', 'MarkerSize', 16, 'LineWidth', 6);
    
    figure(1);
    slice_pt = [0;0;0;p1;0;p2];
%     patch1 = plotFilled(R.link_FRS{1}{100}.slice(slice_pt(1:2)), [1, 3], 'k');
%     patch1.FaceAlpha = 0.2;
    patch2 = plotFilled(R.link_FRS{3}{100}.slice(slice_pt), [1, 3], 'k');
    patch2.FaceAlpha = 0.2;
    
    figure(3); clf; view(3); axis equal; hold on;
    R.plot_slice([0;0;0;p1;0;p2], 99, {'k', 'k', 'k'});
    plot(O{1});
    
end

    
    


% test one particular set of constraints
% A_con = R.A_con{1}{3}{97};
% b_con = R.b_con{1}{3}{97};
% k_con = R.k_con{1}{3}{97};
% c_param = R.c_k(R.link_joints{3});
% g_param = R.g_k(R.link_joints{3});
% 
% % for the bad_k
% k_param = bad_k(R.link_joints{3});
% lambda = c_param + (k_param./g_param);
% lambdas = k_con.*lambda;
% lambdas(~k_con) = 1;
% lambdas = prod(lambdas, 1)';
% c_obs = A_con*lambdas - b_con;
% c_obs_max = max(c_obs);
% bad_c_k = -(c_obs_max);
% 
% % for the good_k
% k_param = good_k(R.link_joints{3});
% lambda = c_param + (k_param./g_param);
% lambdas = k_con.*lambda;
% lambdas(~k_con) = 1;
% lambdas = prod(lambdas, 1)';
% c_obs = A_con*lambdas - b_con;
% c_obs_max = max(c_obs);
% good_c_k = -(c_obs_max);
% 
% % display
% disp('Good c_k value (should be -0.1518): ');
% disp(good_c_k);
% 
% disp('Bad c_k value (should be 0.0867): ');
% disp(bad_c_k);
% 
% %format plot
% xlim([-1, 1]);
% ylim([-1, 1]);
% zlim([-1, 1]);
% 
% box on;
% xlabel('X');