function flag = configSpaceGeneral(L,c,p,plotOrNot,countdown)
% This function plots the set of all reachable points for a robot with
% segments lengths L = [l1,l2,....,ln] and with angles -c to c.
% For robot arms with 4 arms the function uses approximately 1 minute.

tol=0.1;
[~,s]=size(p);
angles=linspace(-c,c,50);
n=length(angles);
arms = length(L);
if arms>3
    l = 1;
    k = 1;
else
    l = 1;
    k = 1;
end
points=zeros(2,n^arms);
numPoints = length(points);
theta = ones(1,arms);
theta=theta*(-c);
dtheta=angles(2)-angles(1);
count=0;
joint = arms;
percentFinished = 0.05;
tic
notFinished = true;
while notFinished
    if (count/numPoints)>percentFinished && countdown
        fprintf('%.0f percent finished.\n',percentFinished*100);
        percentFinished = percentFinished + 0.05;
    end
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
    if joint==arms-1
        theta(joint) = theta(joint)+k*dtheta;
    else
        theta(joint) = theta(joint)+dtheta;
    end
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

dist2=zeros(1,s);
vec = zeros(1,length(points));
dist = zeros(2,length(points));
for i=1:s
dist(1,:)=points(1,:)-p(1,i);
dist(2,:)=points(2,:)-p(2,i);
dist=abs(dist);
vec=dist(1,:)+dist(2,:);
dist2(i)=min(vec);
end

if max(dist2)>tol
    flag=false;
    fprintf('Error, a point is outside of the configuration space.\n');
else
    flag=true;
end

toc
if plotOrNot
    plot(points(1,:),points(2,:),'b*')
    hold on
    plot(0,0,'r*')
    plot(p(1,:),p(2,:),'g*')
    axis([min(points(1,:))-1,max(points(1,:))+1,min(points(2,:))-1,max(points(2,:))+1])
    title('The set of all reachable points')
    legend('Configuration space','Origin','Reaching points');
end
end