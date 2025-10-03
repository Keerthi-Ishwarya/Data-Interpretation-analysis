clear; clc;
x=[-3:0.02:3];
y=6.5*sin(2.1*x+pi/3);
n=length(y);
i=randperm(n,round(0.3*n));
ysample=y(i);
r=100+(20)*rand(1,n);
z=y;
z(i)=z(i)+r(i);
ymedian=zeros(1,n);
for i=1:n
    first=max(1,i-8);
    last=min(i+8,n);
   
    ymedian(i)=median(z(first:last));
end

ymean=zeros(1,n);
for i=1:n
    last=min(i+8,n);
    first=max(1,i-8);
    ymean(i)=mean(z(first:last));
end

yquartile=zeros(1,n);
for i=1:n
    last=min(i+8,n);
    first=max(1,i-8);
    full=z(first:last);
    yquartile(i) =prctile(full,25);
end
figure;
plot(x,y,'b');
hold on;
plot(x,z,'y');
plot(x,ymedian,'r');
plot(x,ymean,'c');
plot(x,yquartile,'m');
legend('original','corrupted','Median','Mean',' first quartile');
xlabel('x');
ylabel('y');
title('comparing filters in case of 30% corruption');



meansqr=sum((y-ymean).^2)/sum(y.^2);
mediansqr=sum((y-ymedian).^2)/sum(y.^2);
yquartilesqr=sum((y-yquartile).^2)/sum(y.^2);
disp('for 30% corruption');
disp(['Mean Squared Error: ', num2str(meansqr)]);
disp(['Median Squared Error: ', num2str(mediansqr)]);
disp(['Quartile Squared Error: ', num2str(yquartilesqr)]);

p=randperm(n,round(0.3*n));
ysample2=y(p);
r2=100+(20)*rand(1,n);
z2=y;
z2(p)=z2(p)+r2(p);
ymedian2=zeros(1,n);
for i=1:n
    first=max(1,i-8);
    last=min(i+8,n);
   
    ymedian2(i)=median(z2(first:last));
end

ymean=zeros(1,n);
for i=1:n
    last=min(i+8,n);
    first=max(1,i-8);
    ymean2(i)=mean(z2(first:last));
end

yquartile2=zeros(1,n);
for i=1:n
    last=min(i+8,n);
    first=max(1,i-8);
    full=z2(first:last);
    yquartile2(i) =prctile(full,25);
end
figure;
plot(x,y,'b');
hold on;
plot(x,z2,'y');
plot(x,ymedian2,'r');
plot(x,ymean2,'c');
plot(x,yquartile2,'m');
legend('original','corrupted','Median','Mean',' first quartile');
xlabel('x');
ylabel('y');
title('comparing filters in case of 60% corruption');



meansqr2=sum((y-ymean2).^2)/sum(y.^2);
mediansqr2=sum((y-ymedian2).^2)/sum(y.^2);
yquartilesqr2=sum((y-yquartile2).^2)/sum(y.^2);
disp('for 60% corruption');
disp(['Mean Squared Error: ', num2str(meansqr2)]);
disp(['Median Squared Error: ', num2str(mediansqr2)]);
disp(['Quartile Squared Error: ', num2str(yquartilesqr2)]);
