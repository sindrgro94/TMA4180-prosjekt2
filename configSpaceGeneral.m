function configSpaceGeneral(L,c)
% This function plots the set of all reachable points for a robot with
% segments lengths L = [l1,l2,....,ln] and with angles -c to c.
angles=linspace(-c,c,30);
n=length(angles);
arms = length(L);
points=zeros(2,n^arms);
theta = ones(1,arms);
theta=theta*(-c);
dtheta=angles(2)-angles(1);
count=0;
joint = 1;
tic
[points,~,~] = getConfigSpace(L,dtheta,theta,count,points,n,joint,arms,c);
toc
plot(points(1,:),points(2,:),'b*')
hold on
plot(0,0,'r*')
axis([min(points(1,:))-1,max(points(1,:))+1,min(points(2,:))-1,max(points(2,:))+1])
title('The set of all reachable points')
end

function [points,count,theta] = getConfigSpace(L,dtheta,theta,count,points,n,joint,arms,c)
    for i=1:n
        if joint<arms
            [points,count,theta] = getConfigSpace(L,dtheta,theta,count,points,n,joint+1,arms,c);
        end
        if joint == arms
            THETA = cumsum(theta);
            x = dot(L,cos(THETA));
            y = dot(L,sin(THETA));
            count = count+1;
            points(1,count)=x;
            points(2,count)=y;
        end
        theta(joint) = theta(joint)+dtheta;
    end
    theta(joint) = -c;
end