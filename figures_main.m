% Program file used for "Clean innovation, heterogeneous financing costs, and the optimal climate policy mix"
% By ANTHONY WISKICH

% This script draws the different figures
clear all;
%---------------------------

% Optimal
load Results.mat;
%set(groot,'defaultfigureposition',[100 100 400 300]) % useful while debugging
set(groot,'defaultlegendbox','off')
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')
set(groot,'defaultAxesFontSize',14)
set(groot,'DefaultLineLineWidth', 1.5);

% Name sims
LF=Sim(2,1); %Laissez-Faire
S=Sim(1,2,1); %Symmetric
S2=Sim(1,2,2); % Symmetric sensitivity
S3=Sim(1,2,3);
S4=Sim(1,2,4);
S5=Sim(1,2,5);
S11=Sim(1,2,11);
BF=Sim(3,2,1); %Exogenous
B=Sim(2,2,1); %Full model
B2=Sim(2,2,2); %Full model sensitivity
B3=Sim(2,2,3);
B4=Sim(2,2,4);
B5=Sim(2,2,5);
B10=Sim(2,2,10);
B11=Sim(2,2,11);
BR=Sim(4,2,1); %Full model research

%Some parameters% of GDP
Y0=LF.Y(1)/(1+LF.Yg(1));
Yd0=37;
S_c0=LF.S_c(1); % LF (symmetric) clean share does not change
S_c20=0.1962; % From LF initial output
Y0_=1000*85*5; % Actual 2020 GDP $85 trillion
%nu0=0.9297;
nu0=1/1.157;

% Subsidies
Ssub=100*max(0,S.Qrev_rat);
BFsubp=100*max(0,BF.Qrev_rat)-Ssub; %subp means % of GDP change
Bsubp=100*max(0,B.Qrev_rat)-Ssub;
Sbank=100*S.banktot./transpose(S.Y);
BFbank=100*BF.banktot./transpose(BF.Y);
Bbank=100*B.banktot./transpose(B.Y);
BRbank=100*BR.banktot./transpose(BR.Y);
B2bank=100*B2.banktot./transpose(B2.Y);
B3bank=100*B3.banktot./transpose(B3.Y);
B4bank=100*B4.banktot./transpose(B4.Y);
B5bank=100*B5.banktot./transpose(B5.Y);
B10bank=100*B10.banktot./transpose(B10.Y);
B11bank=100*B11.banktot./transpose(B11.Y);
B2subp=100*max(0,B2.Qrev_rat)-100*max(0,S2.Qrev_rat);;
B3subp=100*max(0,B3.Qrev_rat)-100*max(0,S3.Qrev_rat);
B4subp=100*max(0,B4.Qrev_rat)-100*max(0,S4.Qrev_rat);
B5subp=100*max(0,B5.Qrev_rat)-100*max(0,S5.Qrev_rat);
B10subp=100*max(0,B10.Qrev_rat)-100*max(0,S.Qrev_rat);
B11subp=100*max(0,B11.Qrev_rat)-100*max(0,S11.Qrev_rat);
BRsubp=100*max(0,BR.Qrev_rat)-Ssub;

%Tax
Stax=Y0_/Y0*S.tau.*transpose(S.pd);
S2tax=Y0_/Y0*S2.tau.*transpose(S2.pd);
S3tax=Y0_/Y0*S3.tau.*transpose(S3.pd);
S4tax=Y0_/Y0*S4.tau.*transpose(S4.pd);
S5tax=Y0_/Y0*S5.tau.*transpose(S5.pd);
S11tax=Y0_/Y0*S11.tau.*transpose(S11.pd);
BFtaxp=-100+100*Y0_/Y0*BF.tau.*transpose(BF.pd)./Stax;
Btaxp=-100+100*Y0_/Y0*B.tau.*transpose(B.pd)./Stax;
B2taxp=-100+100*Y0_/Y0*B2.tau.*transpose(B2.pd)./S2tax;
B3taxp=-100+100*Y0_/Y0*B3.tau.*transpose(B3.pd)./S3tax;
B4taxp=-100+100*Y0_/Y0*B4.tau.*transpose(B4.pd)./S4tax;
B5taxp=-100+100*Y0_/Y0*B5.tau.*transpose(B5.pd)./S5tax;
B10taxp=-100+100*Y0_/Y0*B10.tau.*transpose(B10.pd)./Stax;
B11taxp=-100+100*Y0_/Y0*B11.tau.*transpose(B11.pd)./S11tax;
BRtaxp=-100+100*Y0_/Y0*BR.tau.*transpose(BR.pd)./Stax;

%Extra Appendix
B6=Sim(2,2,6);
B7=Sim(2,2,7);
B8=Sim(2,2,8);
B9=Sim(2,2,9);
B6taxp=-100+100*Y0_/Y0*B6.tau.*transpose(B6.pd)./Stax;
B7taxp=-100+100*Y0_/Y0*B7.tau.*transpose(B7.pd)./Stax;
B8taxp=-100+100*Y0_/Y0*B8.tau.*transpose(B8.pd)./Stax;
B9taxp=-100+100*Y0_/Y0*B9.tau.*transpose(B9.pd)./Stax;
B6subp=100*max(0,B6.Qrev_rat)-Ssub;
B7subp=100*max(0,B7.Qrev_rat)-Ssub;
B8subp=100*max(0,B8.Qrev_rat)-Ssub;
B9subp=100*max(0,B9.Qrev_rat)-Ssub;
B6bank=100*B6.banktot./transpose(B6.Y);
B7bank=100*B7.banktot./transpose(B7.Y);
B8bank=100*B8.banktot./transpose(B8.Y);
B9bank=100*B9.banktot./transpose(B9.Y);

%Emissions
SYd=S.Yd/5;
BFYd=BF.Yd/5-SYd;
BYd=B.Yd/5-SYd;
BRYd=BR.Yd/5-SYd;

disp(['LF clean res share (2020, Long-run)=' num2str( S_c20 ) ' ' num2str( LF.S_c(40) )]);
disp(['LF clean output share (2020, Long-run)=' num2str(0.2) ' ' num2str( LF.Yc(40)/(LF.Yc(40)+LF.Yd(40)) )]);
disp(['LF Finance costs (%, 2025 2030 2035 2040 2045 2050)=' num2str(1./LF.nuc(1:6)-1)]);
disp(' ')
disp(['Optimal policy']);
disp(['Full tax (2025 2050 )= ' num2str( Stax(1)*(1+Btaxp(1)/100) ) ' ' num2str( Stax(6)*(1+Btaxp(6)/100) )]);
disp(['Full tax rel symm 2025=' num2str( Btaxp(1) )]);
disp(['Full sub % GDP (2025 2030) =' num2str( 100*B.Qrev_rat(1) ) ' ' num2str( 100*B.Qrev_rat(2) )]);
disp(['Research sub rel symm 2025=' num2str(BRsubp(1)/Ssub(1)) ' ' num2str(BRsubp(1)+Ssub(1)) ' ' num2str(Ssub(1))]);
disp(['Full/Research finance sub % GDP (2025 2050) = ' num2str(Bbank(1)) '/' num2str(BRbank(1)) ' ' num2str(Bbank(6)) '/' num2str(BRbank(6))]);
disp(['Full sub rel symm 2025=' num2str(Bsubp(1)/Ssub(1)) ' ' num2str(Bsubp(1)+Ssub(1)) ' ' num2str(Ssub(1))]);
disp(['2050 & 2100 emissions reduction=' num2str( B.Yd(6)/5/Yd0-1 ) ' ' num2str( B.Yd(16)/5/Yd0-1 )]);
disp(['Symm tax (2025 2050)= ' num2str( Stax(1) ) ' ' num2str( Y0_/Y0*S.tau(6)*S.pd(6) )]);
disp(['Full clean research (2025 2050 2100)= ' num2str( B.S_c(1) ) ' ' num2str( B.S_c(6) ) ' ' num2str( B.S_c(16) )]);
disp(['Full Finance costs (%, 2025 2030 2035 2040 2045 2050)=' num2str(B.nuc(1:6).^(-1)-1)]);
%disp(['S2 Finance costs (%, 2025 2030 2035 2040 2045 2050)=' num2str(B2.nuc(1:6).^(-2)-1)]);
%disp(['S3 Finance costs (%, 2025 2030 2035 2040 2045 2050)=' num2str(B3.nuc(1:6).^(-2)-1)]);
%disp(['Util loss endog output (%)=' num2str( 100*( sum(B.Util)/sum(S.Util)-1) )]);
disp(['Util loss endog output & success (%)=' num2str( 100*( sum(B.Util)/sum(S.Util)-1) )]);
%pause
%---------------------------------
%Write to excel

x=transpose([2025:5:2220]);
x1=transpose([2020:5:2220]);
Name=["";"Carbon tax (2020 US$)";"Fin sub % of GDP";"Research sub % of GDP";"Annual emissions (GtCO2)";"Consumption"];
Tsym=table(Name,[x';transpose(Stax);Sbank;Ssub;transpose(SYd);S.C]);
Tbfull=table(Name,[x';transpose(Stax.*(1+Btaxp/100));Bbank;Ssub+Bsubp;transpose(BYd+SYd);B.C]);
Tbnofin=table(Name,[x';transpose(Stax.*(1+BFtaxp/100));BFbank;Ssub+BFsubp;transpose(BFYd+SYd);BF.C]);
Tbres=table(Name,[x';transpose(Stax.*(1+BRtaxp/100));BRbank;Ssub+BRsubp;transpose(BRYd+SYd);BR.C]);
writetable(Tsym,'results.xlsx','Sheet',1,'WriteVariableNames', 0);
writetable(Tbfull,'results.xlsx','Sheet',2,'WriteVariableNames', 0);
writetable(Tbnofin,'results.xlsx','Sheet',3,'WriteVariableNames', 0);
writetable(Tbres,'results.xlsx','Sheet',4,'WriteVariableNames', 0);

%----------------------------------
% Figures
clear Stack
close all

figure('Name','1a','NumberTitle','off');
plot(x1,[0;Stax.*(1+Btaxp/100)],'-k',x1,[0;Stax],'-.k');
ylabel('$2020 per tCO_2 (log scale)')
set(gca, 'YScale', 'log')
ax = gca;
ax.YAxis.Exponent = 0;
yticks([100 200 500 1000 2000 4000])
axis([2020 2100 140 4000])
legend('Full model','Symmetric','location','best')
set(gca,'box','off')
print('1a','-dpng','-r300')

figure('Name','1b','NumberTitle','off');
plot(x1,[0,Ssub+Bsubp],'-k',x1,[0,Ssub],'-.k');
ylabel('% of GDP')
axis([2020 2100 -0.01 0.4])
legend('Full model','Symmetric','location','best')
set(gca,'box','off')
print('1b','-dpng','-r300')

figure('Name','1c','NumberTitle','off');
plot(x1,[0,Bbank],'-k',x1,[0,Sbank],'-.k');
ylabel('% of GDP')
axis([2020 2100 -0.001 0.08])
legend('Full model','Symmetric','location','best')
set(gca,'box','off')
print('1c','-dpng','-r300')

%-----

figure('Name','2a','NumberTitle','off');
h=plot(x1,[Yd0;B.Yd/5],'-k',x1,[Yd0;LF.Yd/5],'--k',x1,[Yd0;S.Yd/5],'-.k');
axis([2020 2100 0 100])
ylabel('GtCO_2')
legend('Full model','Laissez-faire','Symmetric','location','best')
set(gca,'box','off')
print('2a','-dpng','-r300')

figure('Name','2b','NumberTitle','off');
plot(x1,100*[S_c20;B.S_c],'-k',x1,100*[S_c20;LF.S_c],'--k',x1,100*[S_c20;S.S_c],'-.k');
ylabel('% of total research')
axis([2020 2100 0 100])
legend('Full model','Laissez-faire','Symmetric','location','best')
set(gca,'box','off')
print('2b','-dpng','-r300')

figure('Name','2d','NumberTitle','off');
Theta0=1-(1-nu0)*exp(nu0);
plot(x1,100*[1/nu0-1,1./B.nuc-1],'-k',x1,100*[1/nu0-1,1./LF.nuc-1],'--k',x1,zeros(1,41),'-.k');
%plot(x1,100*[1-nu0,1-LF.nuc],'--k',x1,100*[1-nu0,(1-B.nuc).*exp(B.nuc.*(1-B.effort))],'-k'); %,x1,100*[1-nu0,1-B.nuc],':k');
%plot(x1,[15.7,100*(B.nuc.^(-2)-1)],'-k',x1,[15.7,100*(LF.nuc.^(-2)-1)],'--k');
axis([2020 2100 0 16])
ylabel('%')
legend('Full model','Laissez-faire','Symmetric','location','best')
set(gca,'box','off')
print('2d','-dpng','-r300')

figure('Name','2c','NumberTitle','off');
plot(x1,100*[0.2;B.Yc./(B.Yc+B.Yd)],'-k',x1,100*[0.2;LF.Yc./(LF.Yc+LF.Yd)],'--k',x1,100*[0.2;S.Yc./(S.Yc+S.Yd)],'-.k');
axis([2020 2100 0 100])
ylabel('% of total output')
legend('Full model','Laissez-faire','Symmetric','location','best')
set(gca,'box','off')
print('2c','-dpng','-r300')

%------

figure('Name','3c','NumberTitle','off')
plot(x1,[0,Bsubp],'-k',x1,[0,BFsubp],'--k',x1,[0,BRsubp],':k');
ylabel('change in % of GDP')
axis([2020 2100 -0.16 0.11])
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3c','-dpng','-r300')

figure('Name','3b','NumberTitle','off')
plot(x1,[0;Btaxp],'-k',x1,[0;BFtaxp],'--k',x1,[0;BRtaxp],':k')
ylabel('% change in tax')
axis([2020 2100 -1 50]) 
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3b','-dpng','-r300')

figure('Name','3d','NumberTitle','off');
plot(x1,[0,Bbank],'-k',x1,[0,BFbank],'--k',x1,[0,BRbank],':k');
ylabel('% of GDP')
axis([2020 2100 -0.001 0.08])
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3d','-dpng','-r300')

figure('Name','3a','NumberTitle','off')
plot(x1,[0;BYd],'-k',x1,[0;BFYd],'--k',x1,[0;BRYd],':k');
ylabel('change in GtCO_2')
axis([2020 2100 -2 0.5])
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3a','-dpng','-r300')

figure('Name','3e','NumberTitle','off')
plot(x1,[0,100*(B.C./S.C-1)],'-k',x1,[0,100*(BF.C./S.C-1)],'--k',x1,[0,100*(BR.C./S.C-1)],':k')
ylabel('%')
axis([2020 2100 -1.5 0]) 
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3e','-dpng','-r300')

figure('Name','3f','NumberTitle','off');
plot(x1,100*[1/nu0-1,1./B.nuc-1],'-k',x1,100*[1/nu0-1,1./B2.nuc-1],'--k',x1,100*[1/nu0-1,1./BR.nuc-1],':k');
%plot(x1,[15.7,100*(B.nuc.^(-2)-1)],'-k',x1,[15.7,100*(LF.nuc.^(-2)-1)],'--k');
axis([2020 2100 0 16])
ylabel('%')
legend('Full model','Second best','Research','location','best')
set(gca,'box','off')
print('3f','-dpng','-r300')

%------------------

figure('Name','A1b','NumberTitle','off');
plot(x1,[0,Bsubp],'-k',x1,[0,B2subp],'^k',x1,[0,B3subp],'xk',x1,[0,B4subp],'ok',x1,[0,B5subp],'*k',x1,[0,B10subp],'squarek',x1,[0,B11subp],'diamondk','LineWidth',1);
ylabel('change in % of GDP')
axis([2020 2100 -0.17 0.02])
legend('Full model','Low learning rate','High initial cum clean output','High discount rate','Low elasticity','High assessment power','Low cross-sector spillovers','location','southeast')
set(gca,'box','off')
print('A1b','-dpng','-r300')

figure('Name','A1a','NumberTitle','off');
plot(x1,[0;Btaxp],'-k',x1,[0;B2taxp],'^k',x1,[0;B3taxp],'xk',x1,[0;B4taxp],'ok',x1,[0;B5taxp],'*k',x1,[0;B10taxp],'squarek',x1,[0;B11taxp],'diamondk','LineWidth',1);
ylabel('% change in tax')
axis([2020 2100 -5 42])
legend('Full model','Low learning rate','High initial cum clean output','High discount rate','Low elasticity','High assessment power','Low cross-sector spillovers','location','northeast')
set(gca,'box','off')
print('A1a','-dpng','-r300')

figure('Name','A1c','NumberTitle','off');
plot(x1,[0,Bbank],'-k',x1,[0,B2bank],'^k',x1,[0,B3bank],'xk',x1,[0,B4bank],'ok',x1,[0,B5bank],'*k',x1,[0,B10bank],'squarek',x1,[0,B11bank],'diamondk','LineWidth',1);
ylabel('change in % of GDP')
axis([2020 2100 0 0.11])
legend('Full model','Low learning rate','High initial cum clean output','High discount rate','Low elasticity','High assessment power','Low cross-sector spillovers','location','northeast')
set(gca,'box','off')
print('A1c','-dpng','-r300')

figure('Name','4a','NumberTitle','off');
plot(x1,[0;Stax.*(1+B9taxp/100)],'o:k',x1,[0;Stax.*(1+B8taxp/100)],'x:k',x1,[0;Stax.*(1+Btaxp/100)],'-k',x1,[0;Stax.*(1+B7taxp/100)],'--k',x1,[0;Stax.*(1+B6taxp/100)],'-.k',x1,[0;Stax],':k');
ylabel('$2020 per tCO_2 (log scale)')
set(gca, 'YScale', 'log')
ax = gca;
ax.YAxis.Exponent = 0;
yticks([100 200 500])
axis([2020 2050 140 500])
legend('25%','20%','Full model (15.7%)','10%','5%','Symmetric (0%)','location','best')
set(gca,'box','off')
print('4a','-dpng','-r300')

figure('Name','4b','NumberTitle','off');
plot(x1,[0,Ssub+B9subp],'o:k',x1,[0,Ssub+B8subp],'x:k',x1,[0,Ssub+Bsubp],'-k',x1,[0,Ssub+B7subp],'--k',x1,[0,Ssub+B6subp],'-.k',x1,[0,Ssub],':k');
ylabel('% of GDP')
axis([2020 2100 -0.01 0.4])
legend('25%','20%','Full model (15.7%)','10%','5%','Symmetric (0%)','location','best')
set(gca,'box','off')
print('4b','-dpng','-r300')

figure('Name','4c','NumberTitle','off');
plot(x1,[0,B9bank],'o:k',x1,[0,B8bank],'x:k',x1,[0,Bbank],'-k',x1,[0,B7bank],'--k',x1,[0,B6bank],'-.k',x1,[0,Sbank],':k');
ylabel('% of GDP')
axis([2020 2100 -0.001 0.12])
legend('25%','20%','Full model (15.7%)','10%','5%','Symmetric (0%)','location','best')
set(gca,'box','off')
print('4c','-dpng','-r300')

%---------------------------------
% Damages

D1=Sim(5,2,1); %Damage model
D2=Sim(6,2,1); %Damage model
D1tax=Y0_/Y0*D1.tau.*transpose(D1.pd);
D1sub=100*max(0,D1.Qrev_rat);
D1bank=100*D1.banktot./transpose(D1.Y);
D2tax=Y0_/Y0*D2.tau.*transpose(D2.pd);
D2sub=100*max(0,D2.Qrev_rat);
D2bank=100*D2.banktot./transpose(D2.Y);

figure('Name','1ad','NumberTitle','off');
plot(x1,[0;Stax.*(1+Btaxp/100)],'-k',x1,[0;D1tax],'-.k',x1,[0;D2tax],':k');
ylabel('$2020 per tCO_2 (log scale)')
set(gca, 'YScale', 'log')
ax = gca;
ax.YAxis.Exponent = 0;
yticks([100 200 500 1000 2000 4000])
axis([2020 2100 140 4000])
legend('Full model','2.1% damage at 3^oC','7.5% damage at 3^oC','location','best')
set(gca,'box','off')
print('1ad','-dpng','-r300')

figure('Name','1bd','NumberTitle','off');
plot(x1,[0,Ssub+Bsubp],'-k',x1,[0,D1sub],'-.k',x1,[0,D2sub],':k');
ylabel('% of GDP')
axis([2020 2100 -0.01 0.4])
legend('Full model','2.1% damage at 3^oC','7.5% damage at 3^oC','location','best')
set(gca,'box','off')
print('1bd','-dpng','-r300')

figure('Name','1cd','NumberTitle','off');
plot(x1,[0,Bbank],'-k',x1,[0,D1bank],'-.k',x1,[0,D2bank],':k');
ylabel('% of GDP')
axis([2020 2100 -0.001 0.08])
legend('Full model','2.1% damage at 3^oC','7.5% damage at 3^oC','location','best')
set(gca,'box','off')
print('1cd','-dpng','-r300')

%--------------------------------
% For checking that enforcing dirty research sub=0 would not change results significantly

%{
SS=Sim(1,3);
BS=Sim(2,3);
SSsub=100*max(0,SS.Qrev_rat);
BSsubp=100*max(0,BS.Qrev_rat)-SSsub;
SStax=Y0_/Y0*SS.tau.*transpose(SS.pd);
BStaxp=-100+100*Y0_/Y0*BS.tau.*transpose(BS.pd)./SStax;
BSbank=100*BS.banktot./transpose(BS.Y);

figure('Name','5a','NumberTitle','off');
plot(x,Bsubp, '-k',x,BSsubp,'--k');
ylabel('% of GDP')
axis([2025 2100 -0.15 0])
legend('Full','Sub>0','location','best')

figure('Name','5b','NumberTitle','off');
plot(x,Btaxp, '-k',x,BStaxp,'--k');
ylabel('% of GDP')
axis([2025 2100 -1 40])
legend('Full','Sub>0','location','best')

figure('Name','5c','NumberTitle','off');
plot(x,Bbank,'-k',x,BSbank,'--k');
ylabel('% of GDP')
axis([2025 2100 -0.001 0.08])
legend('Full','Sub>0','location','best')
%}