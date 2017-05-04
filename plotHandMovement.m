function plotHandMovement(theta,L,p)
% input parameters are:
% theta = mxn matrix where each column are all the angles to reach a point 
% and each row are the angle at each joint.
% L = vector with all the robot arm lengths
% p = 2xn matrix that contains all the n points the robot arm reaches.
% first row is x-value, second is y-value.
r = sum(L);
r = r*1.5;
figure
xlim([-r,r]);
ylim([-r,r]); 
[joints,points] = size(theta);
steps = 20;
q = zeros(points,joints,2,steps);
THETA = zeros(joints,steps);
for point = 1:points
    for joint = 1:joints
        if point<points
            THETA(joint,:) = linspace(theta(joint,point),theta(joint,point+1),steps);
        else 
            THETA(joint,:) = linspace(theta(joint,point),theta(joint,1),steps);
        end
    end
    THETA = cumsum(THETA);
    for step = 1:steps
        for joint = 1:joints
            q(point,joint+1,1:2,step) = squeeze(q(point,joint,1:2,step))+L(joint).*[cos(THETA(joint,step));sin(THETA(joint,step))];
        end
    end
end
for point = 1:points
    for step = 1:steps
        plot(squeeze(q(point,:,1,step)),squeeze(q(point,:,2,step)),'-or')
        hold on
        xlim([-r,r]);
        ylim([-r,r]);
        names{1} = 'Robot arm';
        for i = 1:length(p)
           plot(p(1,i),p(2,i),'*'); 
           names{i+1} = strcat('Point #', num2str(i));
        end
        legend(names);
        pause(0.0001);
        hold off
    end
end
end