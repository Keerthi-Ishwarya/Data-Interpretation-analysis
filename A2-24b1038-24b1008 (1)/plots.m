clear ;
clc ; 
close all ; 


image1 = double(imread('T1.jpg')) ; 
image2 = double(imread('T2.jpg')) ;


part_2 = 255 - image1 ; 
part_3 = 255*(image1.^2) /( max(image1(:).^2) + 1 ) ;  
[rows , columns] = size(image2) ; 
txran = -10:10 ;  
 binwidth = 10 ; 
nbin= ceil(256/10) ; 


[cv1, qmiv1 , miv1 ] =  for_graphs(image1 , image2 , txran ,  binwidth ,nbin ); 
[cv2, qmiv2 , miv2 ] =  for_graphs(image1 , part_2 , txran ,  binwidth , nbin);
[cv3, qmiv3 , miv3 ] =  for_graphs(image1 , part_3 , txran ,  binwidth , nbin);

figure;
plot(txran, cv1 ,'-s' , 'LineWidth', 2.0 ,'Color', 'r'  ) ; 
title('case1 : I1 VS I2 - Correlation value ') ; 
xlabel('shift in tx ') ; 
ylabel('Correlation value') ; 

figure;
plot(txran, qmiv1 ,'-s' , 'LineWidth', 2.0  , 'Color', 'b'  ) ; 
title('case1 : I1 VS I2 - QMI value ') ; 
xlabel('shift in tx ') ; 
ylabel('QMI value') ; 

figure;
plot(txran, miv1 , '-s' , 'LineWidth', 2.0  , 'Color', 'g'  ) ; 
title('case1 : I1 VS I2 - MI value ') ; 
xlabel('shift in tx ') ; 
ylabel('MI value') ; 



figure;
plot(txran, cv2 , '-^' , 'LineWidth', 2.0 , 'Color', 'r'  ) ; 
title('case2 : I1 VS  255-I1 - correlation value ') ; 
xlabel('shift in tx ') ; 
ylabel('Correlation value') ; 

figure;
plot(txran, qmiv2 ,'-^' , 'LineWidth', 2.0 , 'Color', 'b'  ) ; 
title('case2 : I1 VS 255-I1 - QMI value ') ; 
xlabel('shift in tx ') ; 
ylabel('QMI value') ; 

figure;
plot(txran, miv2 ,'-^' , 'LineWidth', 2.0  , 'Color', 'g'  ) ; 
title('case2 : I1 VS 255-I1 - MI value ') ; 
xlabel('shift in tx ') ; 
ylabel('MI value') ; 





figure;
plot(txran, cv3 ,'-x' , 'LineWidth', 2.0 , 'Color', 'r'   ) ; 
title('case3 : I1 VS 255*(I1.^2) /( max(I1(:).^2) + 1 ) - correlation value ') ; 
xlabel('shift in tx ') ; 
ylabel('Correlation value') ; 

figure;
plot(txran, qmiv3 ,'-x' , 'LineWidth', 2.0  , 'Color', 'b'  ) ; 
title('case3 : I1 VS 255*(I1.^2) /( max(I1(:).^2) + 1 ) - QMI value ') ; 
xlabel('shift in tx ') ; 
ylabel('QMI value') ; 

figure;
plot(txran, miv3 , '-x' , 'LineWidth', 2.0  , 'Color', 'g'  ) ; 
title('case3 : I1 VS 255*(I1.^2) /( max(I1(:).^2) + 1 ) - MI value ') ; 
xlabel('shift in tx ') ; 
ylabel('MI value') ; 



function [cv , qmi , mi ] = for_graphs(I1 , I2 , txrange , binwidth , nbin)
len = length(txrange) ; 
cv =zeros(1 , len  ) ; 
qmi =zeros(1 , len  ) ; 
mi =zeros(1 , len  ) ; 
ep = 1e-10 ; 
[rows , columns] = size(I1) ; 
  
for u =1:length(txrange)
    tx =txrange(u);
       if tx>= 0
           v1 = I1(:, tx+1:columns);
           v2 = I2(:, 1:columns-tx);
        else
            v1 = I1(:,1:columns+tx);
            v2 = I2(:,-tx+1:columns);
       end
       v1 = v1(:);  
       v2 = v2(:);
       cv(u) = corre(v1, v2, ep);
       
        joihis = jointhisto(v1, v2, nbin, binwidth);
        p_joint = joihis / sum(joihis(:));
        p1 = sum(p_joint, 2);   
        p2 = sum(p_joint, 1);  
        qmi(u) = qmiv(p_joint, p1, p2);
         mi(u)  = miv(p_joint, p1, p2, ep);
end
end




function c = corre(x, y, eps)
    m_x =mean(x); 
    m_y =mean(y);
    num =sum((x-m_x).*(y-m_y));
    den = sqrt(sum((x - m_x).^2) * sum((y-m_y).^2));
    if den>eps
    c = (num/den);
    else
    c = 0;
    end
end


function H = jointhisto(v1, v2, nbin, binwidth)
    H = zeros(nbin, nbin);
    for k = 1:length(v1)
        b1 =floor(v1(k)/binwidth) + 1;
        b2 =floor(v2(k)/binwidth) + 1;
        b1 =max(1, min(b1, nbin));
        b2 =max(1, min(b2, nbin));
        H(b1,b2)= (H(b1,b2)+1) ;
    end
end


function q = qmiv(pint, p1, p2)
    q = 0;
    for a =1:length(p1)
        for b =1:length(p2)
            diff = pint(a,b) -p1(a)*p2(b);
            q= q+diff^2;
        end
    end
end


function m = miv(pint, p1, p2, eps)
    m = 0;
    for q= 1:length(p1)
         for o= 1:length(p2)
            pj =pint(q,o);
             pm = (p1(q)*p2(o)) ; 
            if pj>eps && pm>eps
                m = (m+pj*log(pj/pm));
            end
         end
     end
 end







