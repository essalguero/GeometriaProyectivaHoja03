% mOri -> mOriginales
% mCor -> mCorrespondencias

function homografia = GenerarHomografia(mOri, mCor)
  
  A = [mOri(1, 1), mOri(1, 2), 1, 0, 0, 0, -mOri(1, 1) * mCor(1, 1), -mOri(1, 2) * mCor(1, 1);
       0, 0, 0, mOri(1, 1), mOri(1, 2), 1, -mOri(1, 1) * mCor(1, 2), -mOri(1, 2) * mCor(1, 2);
       
       mOri(2, 1), mOri(2, 2), 1, 0, 0, 0, -mOri(2, 1) * mCor(2, 1), -mOri(2, 2) * mCor(2, 1);
       0, 0, 0, mOri(2, 1), mOri(2, 2), 1, -mOri(2, 1) * mCor(2, 2), -mOri(2, 2) * mCor(2, 2);
       
       mOri(3, 1), mOri(3, 2), 1, 0, 0, 0, -mOri(3, 1) * mCor(3, 1), -mOri(3, 2) * mCor(3, 1);
       0, 0, 0, mOri(3, 1), mOri(3, 2), 1, -mOri(3, 1) * mCor(3, 2), -mOri(3, 2) * mCor(3, 2);
       
       mOri(4, 1), mOri(4, 2), 1, 0, 0, 0, -mOri(4, 1) * mCor(4, 1), -mOri(4, 2) * mCor(4, 1);
       0, 0, 0, mOri(4, 1), mOri(4, 2), 1, -mOri(4, 1) * mCor(4, 2), -mOri(4, 2) * mCor(4, 2);
       
       ];
  
  b = [mCor(1,1:2), mCor(2,1:2), mCor(3,1:2), mCor(4,1:2)]';


  h = A \ b;


  H = [h(1, 1), h(2, 1), h(3, 1); 
       h(4, 1), h(5, 1), h(6, 1); 
       h(7, 1), h(8, 1), 1];
  
  homografia = H;
  
end
  