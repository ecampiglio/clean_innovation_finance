% Program file used for "Clean innovation, heterogeneous financing costs, and the optimal climate policy mix"
% By ANTHONY WISKICH

%******* This is the main program

function main(input1,input2,input3)
global dt rho psi alpha gamma delta epsilon toes numsim s_ctax phiSP nuc0 nuc omega Yc0 Yd0 Ydcum Ycumc0 Scumc0 NucendogF SubposF NucResearchF PolicyF ClimateF DamageF k mu;

if ~exist('input3','var') input3=1;
end
disp(['Sim ' num2str(input1) ' ' num2str(input2) ' ' num2str(input3)]);
file = strcat('Results.mat');
load (file);

%initial parameters
numsim=40; % number of periods
dt=5;  % number of years in a period
alpha = 1/3;% 1/3; % share of machines in production
psi= alpha^2; % cost of machines
gamma = 0.02*dt; % size of innovation
Yc_shr=0.2; % Initial share of clean production
Yd0=37*dt; % production of dirty in GtC02
Yc0=Yc_shr/(1-Yc_shr)*Yd0; % production of clean energy
rho=0.075;%0.05;
epsilon=3; % elasticity
toes=0.7; % Stepping on toes
%nuc0=0.9297; %0.953; % Fixed clean financing cost
nuc0=1/1.157; 
delta=0.2;
%nud0=1;
%nud=ones(1,numsim);
nuc=ones(1,numsim);
nuc(1)=nuc0;
%effort=ones(1,numsim);
effort=zeros(1,numsim);
qtotexog=0;
omega=1.32; %0.6;
Ydcum=1350;
Ycumc0=2*Yc0; %Yc0
mu=0; %default zero damage
inc=0.5; %default programming optimisation increment

% Optimisation settings
%opt = optimoptions('fmincon', 'Algorithm','sqp','Display','iter-detailed','Tolfun',0.0000000001,'TolX',0.0000000001);
opt = optimoptions('fmincon', 'Algorithm','sqp','Display','off','Tolfun',0.0000000001,'TolX',0.0000000001);

s_c=zeros(numsim,1);
tau=zeros(numsim,1);
% Set Variables from save Sim results if they exist
try
  s_c=Sim(input1,input2,input3).S_c(1:numsim);
  tau=Sim(input1,input2,input3).tau(1:numsim);
  qtotexog=Sim(input1,input2,input3).Q(1);
  nuc=Sim(input1,input2,input3).nuc(1:numsim);
  effort=Sim(input1,input2,input3).effort(1:numsim);
end

clear RespC A_c A_d;
[RespC.Share,RespC.Util,RespC.pd,RespC.dUdC,RespC.Ye,RespC.C_rat,RespC.pd]=deal([]);
[RespC.t_rat,RespC.Qrev_rat,RespC.trev_rat,RespC.Yg,RespC.crit,RespC.X]=deal([]);
time=1:numsim;

%-------------------
% Set flags and variables for each scenario

PolicyF=1; % Policy on by default
NucendogF=1; % Endogenous nuc by default
ClimateF=1; % Climate constraint on by default
PolicytaxF=1; % Optimal Tax policy on by default
PolicyfinF=1; %Finance subsidy on
SubposF=0; % Enforcing positive clean subsidy off by default
NucResearchF=0; % Fin costs function of output (not research) by default
DamageF=0; % Damage off by default

if input1==1
  NucendogF=0;
  nuc0=1;
elseif input1==3
  %nuc=Sim(2,input2,input3).nuc;
  %NucendogF=0;
  PolicyfinF=0;
elseif input1==4
  NucResearchF=1;
elseif input1==5
  DamageF=1;
  mu=-log(1-0.021)/3/1350;
elseif input1==6
  DamageF=1;
  mu=-log(1-0.075)/3/1350;
end

if input2==1 
  s_ctax=s_c;
  tau=zeros(numsim,1); 
  PolicyF=0;
  inc=1;
elseif input2==3 
  SubposF=1;
end

if input3==2
  omega=0.74; 
elseif input3==3
  Ycumc0=3*Yc0; %2*Yc0;
elseif input3==4
  rho=0.15;
elseif input3==5
  epsilon=2;
elseif input3==6
  nuc0=1/1.05;
elseif input3==7
  nuc0=1/1.1;
elseif input3==8
  nuc0=1/1.2;
elseif input3==9
  nuc0=1/1.25;
elseif input3==10
  delta=0.25;
elseif input3==11
  phiSP=0.5;
  inc=0.2;
elseif input3==12
  omega=0;
  %phiSP=1.085;
end

Scumc0=Ycumc0/(Yc0+Yd0);
if input3 ~= 11
    phiSP=-(1-alpha)*(1-epsilon)*toes; %0.5;
end
%--------------------
% Run the optimisation

for i=1:3  % Iterates, output shows changes in objective function
  % Get the initial value of objective function, fval_last
  [fval_last,Resp]= mysimopt(s_c,tau,nuc,effort);
   
  %Iterate for each time period, rather than do all at once, as the
  %optimisation process is more reliable 
  for k = 1:numsim
    fval= mysimopt(s_c,tau,nuc,effort);

    if PolicyF==0 || PolicytaxF==0 % exogenous tax, optimal research
      %pause
      taxopt = @(xx)mysimopt([s_c(1:k-1);xx(1);s_c(k+1:numsim)],tau,[nuc(1:k-1),xx(2),nuc(k+1:numsim)],effort);
      %taxopt = @(xx)mysimopt([s_c(1:k-1);xx(1);s_c(k+1:numsim)],tau,nuc);
      [out,fval] = fmincon(taxopt,[s_c(k);0.999],[],[],[],[],[0.05;0.9],[0.4;1],[],opt);
      %[out,fval] = fmincon(taxopt,s_c(k),[],[],[],[],0.1,0.4,[],opt);
      s_c_=out(1);
      nuc(k)=out(2);
      tau_=0;
    elseif NucendogF==0 % Exogenous finance costs
      taxopt = @(xx)mysimopt([s_c(1:k-1);xx(1);s_c(k+1:numsim)],[tau(1:k-1);xx(2);tau(k+1:numsim)],nuc,effort);
      [out,fval] = fmincon(taxopt,[0.5;2],[],[],[],[],[0.5;0],[0.99999999;100],[],opt);
      s_c_=out(1);
      tau_=out(2);               
    elseif PolicyfinF==0 % Without finance subsidy
      taxopt = @(xx)mysimopt([s_c(1:k-1);xx(1);s_c(k+1:numsim)],[tau(1:k-1);xx(2);tau(k+1:numsim)],[nuc(1:k-1),xx(3),nuc(k+1:numsim)],effort);
      [out,fval] = fmincon(taxopt,[0.5;2;0.999],[],[],[],[],[0.0000001;0;0.9],[1;100;1],[],opt);
      s_c_=out(1);
      tau_=out(2);
      nuc(k)=out(3);
    else % Optimal policy
      taxopt = @(xx)mysimopt([s_c(1:k-1);xx(1);s_c(k+1:numsim)],[tau(1:k-1);xx(2);tau(k+1:numsim)],[nuc(1:k-1),xx(3),nuc(k+1:numsim)],[effort(1:k-1),xx(4),effort(k+1:numsim)]);
      [out,fval] = fmincon(taxopt,[0.5;2;0.999;1],[],[],[],[],[0.0000001;0;0.9;0],[1;100;1;100],[],opt);
      s_c_=out(1);
      tau_=out(2);
      nuc(k)=out(3);
      effort(k)=out(4);
    end
    
    %Partial approach seems more robust
    s_c(k)=inc*s_c_+(1-inc)*s_c(k);
    tau(k)=inc*tau_+(1-inc)*tau(k);
    %disp(['s_c=' num2str(transpose(s_c))]);
    %disp(['tau=' num2str(transpose(tau))]);
    %pause
  end
  disp(['s_c=' num2str(transpose(s_c))]);
  disp(['tau=' num2str(transpose(tau))]);
  disp(['effort=' num2str(effort)]);
  disp(['fval=' num2str(transpose(fval))]);
  disp(['changefval=' num2str(transpose(fval-fval_last))]);
  if PolicyF==0 break;
  elseif abs(fval-fval_last)<0.00000001 break;
  end
end

%********************************************************************
%Take results
[U,Resp] = mysimopt(s_c,tau,nuc,effort,1);
Resp.UtilT=sum(Resp.Util(1:numsim-10));
load (file);
%clear Sim;
Sim(input1,input2,input3)=Resp;
save(file,'Sim')
clear all;
end