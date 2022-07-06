clear,clc,close all;
picture1=im2double(imread("fft1.png"));
[gac,ghc,gvc,gdc]=dwt2(picture1,'haar');
%normalize
ghc_l1=ghc(:,:,:,1);  
pp=max(max(max(ghc_l1)));
ghc_l1=ghc_l1-pp;
qq=min(min(min(ghc_l1)));
ghc_l1=ghc_l1./qq;

gac_l1=gac(:,:,:,1);  
pp=max(max(max(gac_l1)));
gac_l1=gac_l1-pp;
qq=min(min(min(gac_l1)));
gac_l1=gac_l1./qq;

gvc_l1=gvc(:,:,:,1);  
pp=max(max(max(gvc_l1)));
gvc_l1=gvc_l1-pp;
qq=min(min(min(gvc_l1)));
gvc_l1=gvc_l1./qq;

gdc_l1=gdc(:,:,:,1);  
pp=max(max(max(gdc_l1)));
gdc_l1=gdc_l1-pp;
qq=min(min(min(gdc_l1)));
gdc_l1=gdc_l1./qq;


% mean(mean(ghc_l1+gvc_l1+gdc_l1))
figure()
histogram(ghc,[-0.15:0.002:0.15])
% set(gca,'YLim',[0 18000])
figure()
histogram(gvc,[-0.08:0.001:0.08])
% set(gca,'YLim',[0 30000])
figure()
histogram(gdc,[-0.06:0.001:0.06])