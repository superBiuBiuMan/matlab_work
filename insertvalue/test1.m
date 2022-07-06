
% Author: Dabao
% Time: 2019.03.28 16:01
 
    tic; % calculate running time
    
    % read original image I
    I = imread('lenna.png');
    I = double(I);
    I=[1 2 1 1;                     
            3 3 1 2; 
            3 5 4 3; 
            5 4 5 4;
            5 6 1 5; 
            6 5 2 6;
            8 7 1 2;
            9 8 3 7];
    [oh,ow,od] = size(I);
    zmf = 2; %缩放因子
    
    % initial target image TI
    th = round(oh*zmf);
    tw = round(ow*zmf);
    TI = zeros(th,tw,od); %预分配内存提高计算速度
    
    % add original image with 2 rows and 2 cols
    % expand the border to prevent calculation overflow
    a = I(1,:,:); b = I(oh,:,:);
    temp_I = [a;a;I;b;b];
    c = temp_I(:,1,:); d = temp_I(:,ow,:);
    FI = [c,c,temp_I,d,d];
    
%     % fill target image with new pixels
%     for w = 1:tw
%         j = floor(w/zmf)+2; v = rem(w,zmf)/zmf;
%         for h = 1:th
%             i = floor(h/zmf)+2;  u = rem(h,zmf)/zmf; 
%             A = [S(u+1),S(u),S(u-1),S(u-2)];
%             C = [S(v+1);S(v);S(v-1);S(v-2)];
%             for d = 1:od   % image's 3 channels    
%                B = FI(i-1:i+2,j-1:j+2,d);
%                TI(h,w,d) = A*B*C;    
%             end
%         end
%     end
%     
%     figure;
%     imshow(uint8(TI));
%     toc;