clear;
img01 = imread('666.jpg');
[rows,cols,color] = size(img01);

img01_gray = rgb2gray(img01);
img01_gray = im2double(img01_gray);

img01_gaussian = fspecial('gaussian',[3 3],3);
img = imfilter(img01_gray,img01_gaussian,'same');

img01_convX = zeros(rows,cols);
img01_convY = zeros(rows,cols);
for r = 2:rows-1
    for c = 2:cols-1
        img01_convX(r,c) = (img(r-1,c-1)+2*img(r,c-1)+img(r+1,c-1))-(img(r-1,c+1)+2*img(r,c+1)+img(r+1,c+1));
        img01_convY(r,c) = (img(r-1,c-1)+img(r+1,c-1))+(2*img(r,c-1)-2*img(r,c+1))+(img(r-1,c+1)-img(r+1,c+1));
    end
end

img01_amplitude = zeros(rows,cols);
for r = 1:rows
    for c = 1:cols
        img01_amplitude(r,c) = sqrt(img01_convX(r,c)^2+img01_convY(r,c)^2);
    end
end

img01_direction = zeros(rows,cols);
for r = 1:rows
    for c = 1:cols
        img01_direction(r,c) = atan(img01_convY(r,c)/img01_convX(r,c));
        img01_direction(r,c) = img01_direction(r,c)*180/pi;
    end
end

canny1_1 = zeros(rows,cols);
for r = 1:rows
    for c = 1:cols
      if ((-22.5 < img01_direction(r,c) && img01_direction(r,c) <= 22.5) && (180 < img01_direction(r,c) && img01_direction(r,c) <= 157.5) && (-180 < img01_direction(r,c) && img01_direction(r,c) <= -157.5))
%           if (img01_amplitude(r,c) > img01_amplitude(r,c-1) && img01_amplitude(r,c) > img01_amplitude(r+1,c-1) && img01_amplitude(r,c) > img01_amplitude(r-1,c+1) && img01_amplitude(r,c) > img01_amplitude(r,c+1))
              canny1_1(r,c) = 0;
      end
      if ((22.5 < img01_direction(r,c) && img01_direction(r,c) <= 67.5) && (-157.5 < img01_direction(r,c) && img01_direction(r,c) <= -112.5))
%           if (img01_amplitude(r,c) > img01_amplitude(r+1,c-1) && img01_amplitude(r,c) > img01_amplitude(r+1,c) && img01_amplitude(r,c) > img01_amplitude(r-1,c) && img01_amplitude(r,c) > img01_amplitude(r-1,c+1))
              canny1_1(r,c) = -45;
      end
      if ((67.5 < img01_direction(r,c) && img01_direction(r,c) <= 112.5) && (-112.5 < img01_direction(r,c) && img01_direction(r,c) <= -67.5))
%           if (img01_amplitude(r,c) > img01_amplitude(r+1,c) && img01_amplitude(r,c) > img01_amplitude(r+1,c+1) && img01_amplitude(r,c) > img01_amplitude(r-1,c) && img01_amplitude(r,c) > img01_amplitude(r-1,c-1))
              canny1_1(r,c) = 90;
      end
      if ((112.5 < img01_direction(r,c) && img01_direction(r,c) <= 157.5) && (-67.5 < img01_direction(r,c) && img01_direction(r,c) <= -22.5))
%           if (img01_amplitude(r,c) > img01_amplitude(r+1,c+1) && img01_amplitude(r,c) > img01_amplitude(r,c+1) && img01_amplitude(r,c) > img01_amplitude(r-1,c-1) && img01_amplitude(r,c) > img01_amplitude(r,c-1))
              canny1_1(r,c) = 45;
      end
    end
end

canny1_2 = zeros(rows,cols);
for r = 2:rows-1
    for c = 2:cols-1
        if(canny1_1(r,c) == 0 && (img01_amplitude(r,c) == max([img01_amplitude(r,c),img01_amplitude(r+1,c),img01_amplitude(r-1,c)])))
            canny1_2(r,c) = img01_amplitude(r,c);
        end
        if(canny1_1(r,c) == -45 && (img01_amplitude(r,c) == max([img01_amplitude(r,c),img01_amplitude(r+1,c-1),img01_amplitude(r-1,c+1)])))
            canny1_2(r,c) = img01_amplitude(r,c);
        end
        if(canny1_1(r,c) == 90 && (img01_amplitude(r,c) == max([img01_amplitude(r,c),img01_amplitude(r,c+1),img01_amplitude(r,c-1)])))
            canny1_2(r,c) = img01_amplitude(r,c);
        end
        if(canny1_1(r,c) == 0 && (img01_amplitude(r,c) == max([img01_amplitude(r,c),img01_amplitude(r+1,c+1),img01_amplitude(r-1,c-1)])))
            canny1_2(r,c) = img01_amplitude(r,c);
        end
    end
end
canny_max = max(max(canny1_2));

% canny_max = max(max(canny1_1));
% canny_max
% for r = 1:rows
%     for c = 1:cols
%         for i = 1:rows-r
%             max = canny1_1(r,c);
%             if(max < canny1_1(r+i,c))
%                 max = canny1_1(r+i,c);
%             end
%         end
%     end
% end

TH = 0.2;
TL = 0.1;
TH_max = TH * canny_max;
TL_max = TL * canny_max;

canny1_3 = zeros(rows,cols);
for r = 2:rows-1
    for c = 2:cols-1
%         if(r = 1 || r = rows || c = 1 || c = cols)
%             if(canny1_1(r,c) < TL_max)
%                canny1_2(r,c) = 0;
%             end
%             if(canny1_1(r,c) > TH_max)
%                canny1_2(r,c) = 1;
%             end
            
        if(canny1_2(r,c) < TL_max)
            canny1_3(r,c) = 0;
        end
        if(canny1_2(r,c) > TH_max)
            canny1_3(r,c) = 255;
        end
        if(canny1_2(r,c) > TL_max && canny1_2(r,c) < TH_max)
            if((canny1_3(r-1,c-1) == 1) || (canny1_3(r,c-1) == 1) || (canny1_3(r+1,c-1) == 1) || (canny1_3(r-1,c) == 1) || (canny1_3(r+1,c) == 1) || (canny1_3(r-1,c+1) == 1) || (canny1_3(r,c+1) == 1) || (canny1_3(r+1,c+1) == 1))
                canny1_3(r,c) = 255;
            else
                canny1_3(r,c) = 0;
            end
        end
    end
end
canny1_3 = uint8(canny1_3);
        
figure(1);
subplot(121);
imshow(img01);
subplot(122);
imshow(canny1_3);