%% generating random constrains
% y = ai x + bi
N=1000; % number of constrains
rho=2*pi*rand(N,1);
a=-1./tan(rho);
r=1/16+15/16*rand(N,1);
b=r./sin(rho);
s=rho>pi;
m=420; % plot accuracy
k=42; % interation number

%% ploting all current constrains
hold on
for i=1:N
    x=linspace(-1,1,m);
    y=a(i)*x+b(i);
    x(y>1)=[];
    y(y>1)=[];
    x(y<-1)=[];
    y(y<-1)=[];
    plot(x,y)
end

%%
% known: (0,0) inside the domain
% finding the northest point
idx_temp1=find(b>0);
[v,idx_temp2]=min(b(idx_temp1));
idx_ini1=idx_temp1(idx_temp2);
% idx_ini1=1; % starting from a random line
idx_temp1=find(b<0);
[v,idx_temp2]=max(b(idx_temp1));
idx_ini2=idx_temp1(idx_temp2);
% idx_ini2=2; % starting from a random line
hold on
for idx_ini=[idx_ini1,idx_ini2]
    x=linspace(-1,1,m*(1+abs(a(idx_ini))));
    y=a(idx_ini)*x+b(idx_ini);
    x(y>1)=[];
    y(y>1)=[];
    x(y<-1)=[];
    y(y<-1)=[];
    plot(x,y,'.')
end
% boundary on the left quadrant
hold on
rec=[];
for i=[idx_ini1,idx_ini2]
for k=1:42 % an arbitrary iriteration number
% finding the lines to cross
   rel_idx1=[find(a>a(i))];
   rel_idx2=[find(s==0)];
   rel_idx3=[find(a<a(i))];
   rel_idx4=[find(s>0)];
   rel_idx=[intersect(rel_idx1,rel_idx2);intersect(rel_idx3,rel_idx4)];
% solving for intersections
   ai=a(i)*ones(size(rel_idx,1),1);
   aj=a(rel_idx);
   bi=b(i)*ones(size(rel_idx,1),1);
   bj=b(rel_idx);
   sx=-(bi-bj)./(ai-aj);
   [v,temp_idx]=max(sx);
   idx_left=rel_idx(temp_idx);
% plot
    x=linspace(-1,1,m*(1+abs(a(i))));
    y=a(i)*x+b(i);
    x(y>1)=[];
    y(y>1)=[];
    x(y<-1)=[];
    y(y<-1)=[];
    plot(x,y,'.')
% recording 
   rec=[rec;i];
   i=idx_left;

end
end
% boundary on the right quadrant
hold on
for i=[idx_ini1,idx_ini2]
for k=1:42 % an arbitrary iriteration number
% finding the lines to cross
   rel_idx1=[find(a>a(i))];
   rel_idx2=[find(s>0)];
   rel_idx3=[find(a<a(i))];
   rel_idx4=[find(s==0)];
   rel_idx=[intersect(rel_idx1,rel_idx2);intersect(rel_idx3,rel_idx4)];
% solving for intersections
   ai=a(i)*ones(size(rel_idx,1),1);
   aj=a(rel_idx);
   bi=b(i)*ones(size(rel_idx,1),1);
   bj=b(rel_idx);
   sx=-(bi-bj)./(ai-aj);
   [v,temp_idx]=min(sx);
   idx_right=rel_idx(temp_idx);
% recording    
   rec=[rec;i];
   i=idx_right;
% plot   
    x=linspace(-1,1,m*(1+abs(a(i))));
    y=a(i)*x+b(i);
    x(y>1)=[];
    y(y>1)=[];
    x(y<-1)=[];
    y(y<-1)=[];
    plot(x,y,'.')
end
end