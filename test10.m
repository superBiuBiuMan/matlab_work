% Sigma=1.5;%σ为高斯模糊半径，半径越大模糊程度越大
% for x = 1: 3  % 垂直方向
%     for y = 1:3  % 水平方向
%         WeightMatrix(x, y)=exp(-((x)^2+(y)^2)/(2*Sigma^2))/(2*pi*Sigma^2);
%     end
% end
bb=fspecial('gaussian', [3 3], 1.5);