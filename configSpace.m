% This script plots the set of all reachable points for a robot with
% segment lengths (3,2,2), with angles between -pi/2 and pi/2


tic
c=pi/2;
robot=[3,2,2];
angles=linspace(-c,c);
n=length(angles);
points=zeros(2,n^3);
theta=[-c,-c,-c];
dtheta=angles(2)-angles(1);
count=0;


for i=1:n
    for j=1:n
        for k=1:n
            x=robot(1)*cos(theta(1))+robot(2)*cos(theta(1)+theta(2))+robot(3)*cos(theta(1)+theta(2)+theta(3));
            y=robot(1)*sin(theta(1))+robot(2)*sin(theta(1)+theta(2))+robot(3)*sin(theta(1)+theta(2)+theta(3));
            theta(3)=theta(3)+dtheta;
            count=count+1;
            points(1,count)=x;
            points(2,count)=y;
        end
        theta(3)=-c;
        theta(2)=theta(2)+dtheta;
    end
    theta(2)=-c;
    theta(1)=theta(1)+dtheta;
end
toc

plot(points(1,:),points(2,:),'b*')
hold on
plot(0,0,'r*')
axis([-5,8,-8,8])
title('The set of all reachable points, l=(3,2,2),  c=pi/2')

            