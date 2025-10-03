function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
   newStd = sqrt(((OldStd^2 )*(n-1) + n*(OldMean^2)    +(NewDataValue^2)- (n+1)*(NewMean^2))/n ) ; 
end 