clear,clc,close all;
%https://www.cnblogs.com/wxl845235800/p/7700887.html
    Picx=[1.0 2.0 1.0;0.0 0.0 0.0;-1.0 -2.0 -1.0];
    Picy=[-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];
    Pic=rgb2gray(imread('666.jpg'));
    %扩展
    %expandNumber=1;
    %expand_img = double(wextend('2D','zpd',Pic,expandNumber));
    [rows,cols]=size(Pic);
    tempAll=zeros(rows,cols);
    for i=2:rows-1
        for j=2:cols-1
            %取出x
            tempAreaX=Pic(i:i+2,j:j+2);
            tempAreaX=double(tempAreaX);
            tempX=tempAreaX*Picx;
            %取出y
            tempAreaY=Pic(i:i+2,j:j+2);
            tempAreaY=double(tempAreaY);
            tempY=tempAreaY*Picy;
          
        end
    end
    %tempAll=abs(tempX)+abs(tempY);
    subplot(221),imshow(tempAll,[]);
    g=edge(Pic,'sobel','both');
     subplot(222),imshow(g,[]);