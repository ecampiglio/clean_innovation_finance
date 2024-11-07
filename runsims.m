% Program file used for "Clean innovation, heterogeneous financing costs, and the optimal climate policy mix"
% By ANTHONY WISKICH

% automates sims

clear all; % uncomment to clear memory
%-------
%{ 
(i,j,k)
i 1- Symmetric
  2- Full model
  3- No finance subsidy       
  4- Full model Research 
  5- Include damage function

j %Policy?
  1-LF
  2-Policy 
  3-Policy & Sub>0

k %Sensitivities
  1-Main
  2-omega=0.8
  3-Ycumc0=3*Yc0;
  4-rho=0.15;
  5-epsilon=2;
  6-Ydcum=1150
%}

%LF
main(2,1)

%optimal
main(1,2)
main(2,2)
main(3,2)
main(4,2)

%Sensitivities
main(1,2,2)
main(2,2,2)
main(1,2,3)
main(2,2,3)
main(1,2,4)
main(2,2,4)
main(1,2,5)
main(2,2,5)
main(1,2,11)
main(2,2,11)

main(2,2,6) %Different finance costs
main(2,2,7)
main(2,2,8)
main(2,2,9)

main(2,2,10) % Different power of assessment
main(2,2,11)
main(2,2,12)
main(2,2,13)
main(2,2,14)
main(2,2,15)

%Sub>0
%main(1,3)
%main(10,3)
%main(11,3)
%main(12,3)
