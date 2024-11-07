% Program file used for "Clean innovation, heterogeneous financing costs, and the optimal climate policy mix"
% By ANTHONY WISKICH

% This function computes the utility 

function [U,Resp] = mysimopt(s_c,tau,nuc,effort,display)
global rho psi alpha gamma delta epsilon toes numsim phiSP nuc0 omega Yc0 Yd0 Ydcum Ycumc0 Scumc0 NucendogF SubposF NucResearchF PolicyF ClimateF DamageF k mu;
%%% Setting vectors' sizes
[A_c,A_d,q__,C,Yc,Yd,Yg,Y,Cg,C_rat,t_rat,crit,s_d,muc] = deal(zeros(numsim,1));
e=epsilon;
phi=(1-alpha)*(1-e);

%%% Initial values

%pause
Ac0=Yc0*(1+(Yc0/Yd0)^(1/e-1))^(alpha/phi+1);
Ad0=Yd0*(1+(Yd0/Yc0)^(1/e-1))^(alpha/phi+1);
pc0=((Yc0/Yd0)^(1/e-1)+1)^(1/(e-1));
Abar=Ac0/Ad0;
pd0=pc0*Abar^(1-alpha);
checkp=1-(pc0^(1-e)+pd0^(1-e));
Y0=(Yc0^((e-1)/e)+Yd0^((e-1)/e))^(e/(e-1));
Ybar=Yc0/Yd0;
Ld0=1/(1+Abar^(-phi));
Lc0=Ld0*Abar^(-phi);
Cutil0=Y0-alpha*(Yc0*pc0+Yd0*pd0);
Srat0=( Abar^(1-phiSP) * (pc0/pd0)^(1/(1-alpha)) * Lc0/Ld0 * nuc0 )^(1/(1-toes));
%Srat0=( Abar^(1-phiSP) * (pc0/pd0)^(1/(1-alpha)) * Lc0/Ld0 * nuc0^2 )^(1/(1-toes));
Sc0=Srat0/(1+Srat0); % Gives initial clean research in LF case with finance costs
%pause
time=1:numsim+20;
betav = transpose((1+rho).^(-time+1));

%-------------------------
% diminishing returns to research

s_c_=max(0.000000001,s_c);
s_d_=1-s_c_;
%s_d_=max(0.000000001,1-s_c);
for j=1:numsim 
  s_c(j)=s_c_(j)^toes;
  s_d(j)=s_d_(j)^toes;
end

A__0=Ac0+Ad0;

[SP_c,SP_d] = deal(ones(numsim,1));
[SP_0,A__] = deal(ones(1,numsim));
 
SP_c(1)=(A__0/Ac0)^phiSP; %1
SP_d(1)=(A__0/Ad0)^phiSP; %1

%muc(1)=(1+nuc(1))/2-(1-nuc(1)) * exp( nuc(1)*(1-effort(1)) );
muc(1)=delta + (1-delta)*nuc(1)-delta*(1-nuc(1)) * exp( -effort(1) );
A_c(1)=(1+muc(1)*gamma*s_c(1)*SP_c(1))*Ac0;
%A_c(1)=(1+nuc(1)*gamma*s_c(1)*SP_c(1))*Ac0;
A_d(1)=(1+gamma*s_d(1)*SP_d(1))*Ad0;

s_c_prod(1)=s_c(1)/s_c_(1)*SP_c(1);
if s_d_(1)>0
  s_d_prod(1)=s_d(1)/s_d_(1)*SP_d(1);
else
  s_d_prod(1)=SP_d(1);
end  
  
for n = 2:numsim
 
  A__(n-1)=A_c(n-1)+A_d(n-1);

  SP_c(n)=(A__(n-1)/A_c(n-1))^phiSP;
  SP_d(n)=(A__(n-1)/A_d(n-1))^phiSP;
  
  %muc(n)=(1+nuc(n))/2-(1-nuc(n)) * exp( nuc(n)*(1-effort(n)) );
  muc(n)=delta+(1-delta)*nuc(n)-delta*(1-nuc(n)) * exp( -effort(n) );
  A_c(n)=(1+muc(n)*gamma*s_c(n)*SP_c(n))*A_c(n-1);
  %A_c(n)=(1+nuc(n)*gamma*s_c(n)*SP_c(n))*A_c(n-1);
  A_d(n)=(1+gamma*s_d(n)*SP_d(n))*A_d(n-1);
  
  s_c_prod(n)=s_c(n)/s_c_(n)*SP_c(n);
  if s_d_(n)>0
    s_d_prod(n)=s_d(n)/s_d_(n)*SP_d(n);
  else
    s_d_prod(n)=SP_d(n);      
  end
end

%----------------------------
% Set variables given research, productivity, tax, nuc and nuc
for j=1:numsim 

  t=tau(j);
  phi=(1-alpha)*(1-e);
  Abar=A_c(j)/A_d(j);
  pd(j)=Abar^(1-alpha)/((1+t)^(1-e)*Abar^phi+1)^(1/(1-e));
  pc(j)=pd(j)/Abar^(1-alpha);
  Ld(j)=1/(1+(1+t)^e*Abar^(-phi));
  Lc(j)=Ld(j)*(1+t)^e*Abar^(-phi);
  Yc(j)=pc(j)^(alpha/(1-alpha))*A_c(j)*Lc(j);
  Ybar=Abar^(e*(1-alpha)) * (1+t)^e;
  Yd(j)=Yc(j)/Ybar;
  Y(j)=exp(-mu*sum(Yd(1:numsim))) * (Yc(j)^(1-1/e)+Yd(j)^(1-1/e))^(e/(e-1));
  checkYd(j)=Yd(j)-pd(j)^(alpha/(1-alpha))*A_d(j)*Ld(j);
  checkYc(j)=Yc(j)-pc(j)^(alpha/(1-alpha))*A_c(j)*Lc(j);
  
  if NucendogF==0
    nuc_(j)=nuc0;
  elseif NucResearchF==1
    nuc_(j)=( 1+ (1/nuc0-1)*( Scumc0 /( Scumc0+sum(s_c_(1:j)) ) )^omega )^(-1);
  else
    nuc_(j)=( 1+ (1/nuc0-1)*( Ycumc0 /( Ycumc0+sum(Yc(1:j)) ) )^omega )^(-1);
  end

  if j==1
    wHc(j)= muc(j) * alpha*(1-alpha) * pc(j)^(1/(1-alpha)) * gamma * Ac0 * s_c_prod(j) * Lc(j);
    wHd(j)=1         * alpha*(1-alpha) * pd(j)^(1/(1-alpha)) * gamma * Ad0 * s_d_prod(j) * Ld(j);  
  else
    wHc(j)= muc(j) * alpha*(1-alpha) * pc(j)^(1/(1-alpha)) * gamma * A_c(j-1) * s_c_prod(j) * Lc(j);
    wHd(j)=1         * alpha*(1-alpha) * pd(j)^(1/(1-alpha)) * gamma * A_d(j-1) * s_d_prod(j) * Ld(j); 
  end
  
  crit(j)=wHd(j)/wHc(j);
  q__(j)= crit(j)-1;
  
  qtot(j)=(wHd(j)-wHc(j))*s_c_(j);
  qtot_(j)=(wHd(j)-wHc(j))*(1-s_c_(j));
  %banktot(j)=(effort(j)-1)*(1-nuc(j))/nuc(j)*wHc(j)*s_c_(j);
  banktot(j)=( exp(delta*effort(j))-1 )*(1-nuc(j))/nuc(j)*wHc(j)*s_c_(j);
  banktotrat(j)=banktot(j)/Y(j);
  %pause
end

Util=zeros(numsim,1);
for j=1:numsim
  trev(j)=tau(j)*pd(j)/(1+tau(j))*Yd(j);
   
  Cutil(j)=max(0,Y(j)-alpha*(Yc(j)*pc(j)+Yd(j)*pd(j)))-banktot(j); 
  UCons=(1+rho)^(-j+1)/Cutil(j)^0.5;
  UEmis=ClimateF*( 0.000000005*max(0,sum(Yd(1:numsim))-Ydcum)^2 ); % Climate constraint
  USub=0;
  if j<15
    USub=SubposF*( 1000*sum( max(0,-qtot_./transpose(Y)).^2 ) ); % Enforce zero dirty research subsidy
  end
  UNuc=NucendogF*( 0.6* ( sum( (nuc-nuc_).^2 ) ) ); % Makes nuc approach nuc_. This variable could perhaps be calculated in the code, but not trivial to derive given s_c and tax.

  Util(j)=UCons + UEmis + UNuc + USub; 
  
  t_rat(j)=tau(j)/Cutil(j)*pd(j);
  yshare(j)=Yc(j)/(Yc(j)+Yd(j));
  xshare(j)=Yc(j)*pc(j) / (Yc(j)*pc(j)+Yd(j)*pd(j));
end

if PolicyF==0
 U=( 1000*q__(k) )^2+100000*(nuc(k)-nuc_(k))^2;
 %k,s_c(k),q__(k)
 %pause
else
 U=sum(Util);
end
Yg(1)=Y(1)/Y0-1;
Cg(1)=Cutil(1)/Cutil0-1;
for j=2:numsim
  Yg(j)=Y(j)/Y(j-1)-1;
  Cg(j)=Cutil(j)/Cutil(j-1)-1;
end

%Display variables
if exist('display','var')
  %disp(['C=' num2str(transpose(C))]);
  disp(['xshare=' num2str(xshare)]);
  disp(['Util=' num2str(transpose(Util))]);
  disp(['ObjLF=' num2str(U)]);
  disp(['Cutil=' num2str(Cutil)]);
  disp(['wHc=' num2str(wHc)]);
  disp(['wHd=' num2str(wHd)]);
  disp(['s_c_prod=' num2str(s_c_prod)]);
  disp(['s_d_prod=' num2str(s_d_prod)]);
  disp(['crit=' num2str(transpose(crit))]);
  disp(['tau=' num2str(transpose(tau))]);
  disp(['Y=' num2str(transpose(Y))]);
  disp(['q__=' num2str(transpose(q__))]);
  disp(['qtot=' num2str(qtot)]);
  disp(['qtot_=' num2str(qtot_)]);
  disp(['Yc=' num2str(transpose(Yc))]);
  disp(['Yd=' num2str(transpose(Yd))]);
  disp(['nuc=' num2str(nuc)]);
  disp(['nuc_=' num2str(nuc_)]);
  disp(['nuc error=' num2str(sum( (nuc-nuc_).^2))]);
  disp(['muc=' num2str(transpose(muc))]);
  disp(['pc=' num2str(pc)]);
  disp(['pd=' num2str(pd)]);
  disp(['Lc=' num2str(Lc)]);
  disp(['Ld=' num2str(Ld)]);
  disp(['A_c=' num2str(transpose(A_c))]);
  disp(['A_d=' num2str(transpose(A_d))]);
  disp(['s_c=' num2str(transpose(s_c_))]);
  disp(['s_d=' num2str(transpose(s_d_))]);
  disp(['SP_c=' num2str(transpose(SP_c))]);
  disp(['SP_d=' num2str(transpose(SP_d))]);
  disp(['t_rat=' num2str(transpose(t_rat))]);
  %disp(['t_diff=' num2str(t_diff)]);
  disp(['effort=' num2str(effort)]);
  disp(['banktot=' num2str(banktot)]);
  disp(['banktotrat=' num2str(banktotrat)]);
  disp(['checkYc=' num2str(checkYc)]);
  disp(['checkYd=' num2str(checkYd)]);
  %pause
end

Resp.Util = Util; % utility flow
Resp.C = Cutil; % consumption
Resp.Y = Y; % output
Resp.Yc = Yc; % clean output
Resp.Yd = Yd; % dirty output
Resp.Ac = A_c; % quality of clean machines
Resp.Ad = A_d; % quality of dirty machines
Resp.tau = tau; % numerical input tax
Resp.S_c = s_c_; % share of scientists in clean research
Resp.S_d = s_d_; % share of scientists in dirty research
Resp.effort = effort; % share of scientists in dirty research
Resp.Q = qtot; % subsidy to clean research
Resp.banktot = banktot; % subsidy to clean finance
Resp.Share = xshare; %Yc./(Yc+Yd); % share of clean inputs of energy inputs
Resp.Lc = Lc; % Labour
Resp.pd = pd; % dirty price
Resp.Yg = Yg;%Yg;
Resp.Cg = Cg;
Resp.C_rat = C_rat; 
Resp.Qrev_rat = qtot./transpose(Y);
Resp.t_rat = t_rat;
Resp.UtilT=sum(Util);
Resp.crit=crit;
Resp.nuc = nuc;
Resp.muc = muc;

