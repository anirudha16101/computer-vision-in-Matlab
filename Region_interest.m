clc;
clear;
close all;
image=imread('camera.jpg');
image=imresize(image,[256 256]);
imshow(image);
[col, row]=ginput(4);
c= col;
r=row;


binary_mask=roipoly(image,c,r);
figure;
imshow(binary_mask);
title('selected region of interest');

roi=zeros(256,256);
nroi=zeros(256,256);

for i=1:256
    for j=1:256
        if(binary_mask(i,j)==1)
            roi(i,j)=image(i,j);
        else
            nroi(i,j)=image(i,j);
        end
    end
end 


figure;
subplot(1,2,1);
imshow(roi,[]);
subplot(1,2,2);
imshow(nroi,[]);

