clear;
img = imread('test.jpg'); 
if length(size(img))>2
img = rgb2gray(img);
end 
%%applying sobel edge detector in the horizontal direction
fx = [-1 0 1;-1 0 1;-1 0 1];
ix = filter2(fx,img);
% applying sobel edge detector in the vertical direction
fy = [1 1 1;0 0 0;-1 -1 -1];
iy = filter2(fy,img); 

ix2 = ix.^2;
iy2 = iy.^2;
ixy = ix.*iy;

%%
%applying gaussian filter on the computed value
h= fspecial('gaussian',[9 9],2); 
ix2 = filter2(h,ix2);
iy2 = filter2(h,iy2);
ixy = filter2(h,ixy);
height = size(img,1);
width = size(img,2);
result = zeros(height,width); 
R = zeros(height,width);
%%
Rmax = 0; 
for i = 1:height
for j = 1:width
M = [ix2(i,j) ixy(i,j);ixy(i,j) iy2(i,j)]; 
R(i,j) = det(M)-0.01*(trace(M))^2;
if R(i,j) > Rmax
Rmax = R(i,j);
end;
end;
end;
for i = 2:height-1
for j = 2:width-1
if R(i,j) > 0.3*Rmax && R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)
result(i,j) = 1;
end;
end;
end;
[posc, posr] = find(result == 1);

imshow(img);
hold on;
plot(posr,posc,'g*');