function makeRobotPlot5(theta,L,p)
if length(p) ~=5
    disp('Works only with five points')
    return
end
r = sum(L);
h = figure;
THETA = cumsum(theta);
[joints,points] = size(theta);
q = zeros(joints+1,2);
for point = 1:6
    if point ~=6
        for i = 1:joints
            q(i+1,:) = q(i,:)+(L(i).*[cos(THETA(i,point));sin(THETA(i,point))])';
        end
    else
        for i = 1:joints
            q(i+1,:) = q(i,:)+(L(i).*[cos(THETA(i,1));sin(THETA(i,1))])';
        end
    end
    subplot(2,3,point)
    xlim([-r,r]);
    ylim([-r,r]); 
    hold on
    plot(q(:,1),q(:,2),'-o')
    names{1} = 'Robot arm';
    for i = 1:5
       plot(p(1,i),p(2,i),'*'); 
       names{i+1} = strcat('Point #', num2str(i));
    end
    legend(names);
    hold off
end
end