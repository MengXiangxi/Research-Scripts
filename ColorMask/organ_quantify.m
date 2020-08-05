close
clear

fname =  '2020 Jan 18 21_11_56-Frame-03.tif';
img = imread(fname);

figure('WindowState','maximized')
imagesc(img(:,:,1)) % show image
hold on
axis equal
% set to default screen
set(gcf,'outerposition',[0,0,100,100]); 
% maximize to screen
set(gcf,'outerposition',get(0,'screensize')); 
caxis([3000, 30000])
[x,y] = ginput(2);

xlim([x(1),x(2)])
ylim([y(1),y(2)])

x1 = round(x(1));
x2 = round(x(2));
y1 = round(y(1));
y2 = round(y(2));

colormap(hot)

organ = img(y1:y2,x1:x2);
organ(organ<3000) = 0;
pixel_num = sum(sum(organ>0));

disp(sum(sum(organ)))
disp(pixel_num)
disp(sum(sum(organ))./pixel_num)