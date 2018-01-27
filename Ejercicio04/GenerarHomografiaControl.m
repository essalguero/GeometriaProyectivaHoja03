% mOri -> mOriginales
% mCor -> mCorrespondencias

function homografia = GenerarHomografiaControl(mOri, mCor)
  
  A = [mOri(1, 1), mOri(1, 2), mOri(1, 3), 1, 0, 0, 0, 0, 0, 0, 0, 0, ...
      -mOri(1, 1) * mCor(1, 1), -mOri(1, 2) * mCor(1, 1), -mOri(1, 3) * mCor(1, 1);
       0, 0, 0, 0, mOri(1, 1), mOri(1, 2), mOri(1, 3), 1, 0, 0, 0, 0, ...
      -mOri(1, 1) * mCor(1, 2), -mOri(1, 2) * mCor(1, 2), -mOri(1, 3) * mCor(1, 2);
       0, 0, 0, 0, 0, 0, 0, 0, mOri(1, 1), mOri(1, 2), mOri(1, 3), 1, ...
      -mOri(1, 1) * mCor(1, 3), -mOri(1, 2) * mCor(1, 3), -mOri(1, 3) * mCor(1, 3);
       
       
       mOri(2, 1), mOri(2, 2), mOri(2, 3), 1, 0, 0, 0, 0, 0, 0, 0, 0, ...
      -mOri(2, 1) * mCor(2, 1), -mOri(2, 2) * mCor(2, 1), -mOri(2, 3) * mCor(2, 1);
       0, 0, 0, 0, mOri(2, 1), mOri(2, 2), mOri(2, 3), 1, 0, 0, 0, 0, ...
      -mOri(2, 1) * mCor(2, 2), -mOri(2, 2) * mCor(2, 2), -mOri(2, 3) * mCor(2, 2);
       0, 0, 0, 0, 0, 0, 0, 0, mOri(2, 1), mOri(2, 2), mOri(2, 3), 1, ...
      -mOri(2, 1) * mCor(2, 3), -mOri(2, 2) * mCor(2, 3), -mOri(2, 3) * mCor(2, 3);
      
      
      mOri(3, 1), mOri(3, 2), mOri(3, 3), 1, 0, 0, 0, 0, 0, 0, 0, 0, ...
      -mOri(3, 1) * mCor(3, 1), -mOri(3, 2) * mCor(3, 1), -mOri(3, 3) * mCor(3, 1);
       0, 0, 0, 0, mOri(3, 1), mOri(3, 2), mOri(3, 3), 1, 0, 0, 0, 0, ...
      -mOri(3, 1) * mCor(3, 2), -mOri(3, 2) * mCor(3, 2), -mOri(3, 3) * mCor(3, 2);
       0, 0, 0, 0, 0, 0, 0, 0, mOri(3, 1), mOri(3, 2), mOri(3, 3), 1, ...
      -mOri(3, 1) * mCor(3, 3), -mOri(3, 2) * mCor(3, 3), -mOri(3, 3) * mCor(3, 3);
      
      
      mOri(4, 1), mOri(4, 2), mOri(4, 3), 1, 0, 0, 0, 0, 0, 0, 0, 0, ...
      -mOri(4, 1) * mCor(4, 1), -mOri(4, 2) * mCor(4, 1), -mOri(4, 3) * mCor(4, 1);
       0, 0, 0, 0, mOri(4, 1), mOri(4, 2), mOri(4, 3), 1, 0, 0, 0, 0, ...
      -mOri(4, 1) * mCor(4, 2), -mOri(4, 2) * mCor(4, 2), -mOri(4, 3) * mCor(4, 2);
       0, 0, 0, 0, 0, 0, 0, 0, mOri(4, 1), mOri(4, 2), mOri(4, 3), 1, ...
      -mOri(4, 1) * mCor(4, 3), -mOri(4, 2) * mCor(4, 3), -mOri(4, 3) * mCor(4, 3);
      
      
      mOri(5, 1), mOri(5, 2), mOri(5, 3), 1, 0, 0, 0, 0, 0, 0, 0, 0, ...
      -mOri(5, 1) * mCor(5, 1), -mOri(5, 2) * mCor(5, 1), -mOri(5, 3) * mCor(5, 1);
       0, 0, 0, 0, mOri(5, 1), mOri(5, 2), mOri(5, 3), 1, 0, 0, 0, 0, ...
      -mOri(5, 1) * mCor(5, 2), -mOri(5, 2) * mCor(5, 2), -mOri(5, 3) * mCor(5, 2);
       0, 0, 0, 0, 0, 0, 0, 0, mOri(5, 1), mOri(5, 2), mOri(5, 3), 1, ...
      -mOri(5, 1) * mCor(5, 3), -mOri(5, 2) * mCor(5, 3), -mOri(5, 3) * mCor(5, 3);
      
      ];
      
       
  
  b = [mCor(1,1:3), mCor(2,1:3), mCor(3,1:3), mCor(4,1:3), mCor(5,1:3)]';


  h = A \ b;


  H = [h(1, 1), h(2, 1), h(3, 1), h(4, 1); 
       h(5, 1), h(6, 1), h(7, 1), h(8, 1); 
       h(9, 1), h(10, 1), h(11, 1), h(12, 1); 
       h(13, 1), h(14, 1), h(15, 1), 1];
  
  homografia = H;
  
end