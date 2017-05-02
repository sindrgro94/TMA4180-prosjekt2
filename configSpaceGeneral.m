function configSpaceGeneral(L,c)
% This function plots the set of all reachable points for a robot with
% segments lengths L = [l1,l2,....,ln] and with angles -c to c.
% For robot arms with 4 arms the function uses approximately 1 minute.
angles=linspace(-c,c,50);
n=length(angles);
arms = length(L);
points=zeros(2,n^arms);
theta = ones(1,arms);
theta=theta*(-c);
dtheta=angles(2)-angles(1);
count=0;
joint = arms;
tic
notFinished = true;
while notFinished
    if joint==arms
        for i=1:n
            THETA = cumsum(theta);
            x = dot(L,cos(THETA));
            y = dot(L,sin(THETA));
            count = count+1;
            points(1,count)=x;
            points(2,count)=y;
            theta(arms) = theta(arms)+dtheta;
        end
        theta(arms) = -c;
        joint = joint-1;
    end
    theta(joint) = theta(joint)+dtheta;
    if theta(joint)>c
        if joint == 1
            notFinished = false;
        end
        theta(joint) = -c;
        joint = joint-1;
    else
        joint = joint + 1;
    end
end
toc
plot(points(1,:),points(2,:),'b*')
hold on
plot(0,0,'r*')
axis([min(points(1,:))-1,max(points(1,:))+1,min(points(2,:))-1,max(points(2,:))+1])
title('The set of all reachable points')
end