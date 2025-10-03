function newMedian = UpdateMedian (OldMedian, NewDataValue, x, n)
  if  mod(n,2) == 0
       if NewDataValue > x(n/2 + 1 )  
          newMedian = x(n/2+ 1)  ; 
       elseif NewDataValue < x(n/2 )
            newMedian = x(n/2 )  ;
      
       elseif  NewDataValue > x(n/2 ) && NewDataValue < x((n/2) + 1 )
             newMedian =   NewDataValue ;
       end 
  end 

    if mod(n,2) ~= 0 
        if  NewDataValue > OldMedian
            if NewDataValue < x((n+1)/2 + 1 ) 
                newMedian =  (NewDataValue  + x((n+1)/2) )/ 2 ; 
            else 
                newMedian =  (x ((n+1)/2) +  x((n+1)/2 + 1 )  )/ 2  ; 
            end 
        end 

      if  NewDataValue < OldMedian
            if NewDataValue > x((n+1)/2 - 1 ) 
                newMedian =  (NewDataValue  + x((n+1)/2) )/ 2 ; 
            else 
                newMedian =  (x ((n+1)/2) +  x((n+1)/2 - 1 )  )/ 2  ; 
            end
      end 
    end 

        
       
end 
