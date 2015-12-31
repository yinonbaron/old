clear all 
im = imread('F5.large.jpg');
mega = ((im(:,:,2)>150) & (im(:,:,1)<30));
livestock = (im(:,:,2)>100 & im(:,:,2)<150 & im(:,:,1)<20);

topY = 14;
bottomY = 906;
rightX = 1056;
leftX = 74;

mega_CC = bwconncomp(mega,8);
size_mega_CC = cellfun(@(x) length(x),mega_CC.PixelIdxList);
mega_center = regionprops(mega_CC,'centroid');
mega_box = regionprops(mega_CC,'BoundingBox');
mega_center = mega_center(size_mega_CC>10);
livestock_CC = bwconncomp(livestock,8);
size_livestock_CC = cellfun(@(x) length(x),livestock_CC.PixelIdxList);
livestock_center = regionprops(livestock_CC,'centroid');
livestock_box = regionprops(livestock_CC,'BoundingBox');
livestock_center = livestock_center(size_livestock_CC>10);

livestock_points(1,:) = [74 808];
livestock_points(2,:) = [133 808];
livestock_points(3,:) = [192 813];
livestock_points(4,:) = [212 813];
livestock_points(5,:) = [236 844];
livestock_points(6,:) = [252 844];
livestock_points(7,:) = [271 853];
livestock_points(8,:) = [290 867];
livestock_points(9,:) = [314 865];
livestock_points(10,:) = [349 862];
livestock_points(11,:) = [374 856];
livestock_points(12,:) = [408 843];
livestock_points(13:17,:) = reshape([livestock_center(end-4:end).Centroid],[2 5])';
livestock_points(17,1) = rightX;

mega_points(1,:) = [74 808];
mega_points(2,:) = [133 808];
mega_points(3,:) = [192 813];
mega_points(4,:) = [212 813];
mega_points(5,:) = [236 844];
mega_points(6,:) = [252 844];
mega_points(7,:) = [271 853];
mega_points(8,:) = [290 867];
mega_points(9,:) = [349 867];
mega_points(10,:) = [349 869];
mega_points(11,:) = [374 867];
mega_points(12,:) = [408 863];
mega_points(13:17,:) = reshape([mega_center(end-4:end).Centroid],[2 5])';
mega_points(17,1) = rightX;

mega_corr_points(:,1) = 10.^(-(mega_points(:,1)-rightX)/((rightX-leftX)/5));
livestock_corr_points(:,1) = 10.^(-(livestock_points(:,1)-rightX)/((rightX-leftX)/5));
mega_corr_points(:,2) = 1.6-(mega_points(:,2)-topY)/(bottomY-topY)*1.6;
livestock_corr_points(:,2) = 1.6-(livestock_points(:,2)-topY)/(bottomY-topY)*1.6;

% The y axis is total mass. to convert to mass of collagen we multiply by
% 0.2*0.3 = 0.06
%{
semilogx(mega_corr_points(:,1),mega_corr_points(:,2),'.g')
hold on
%}
semilogx(livestock_corr_points(:,1),livestock_corr_points(:,2)*0.06*100,'or','MarkerFaceColor','r')
set(gca,'Xdir','reverse')
xlabel('Years BP'), ylabel('10^{13} grams')
line([1 100000],[7.5 7.5],'LineWidth',2,'Color','k')

line([300 300],[0 10],'LineStyle','--','LineWidth',2,'Color','k')
text(50000, 7.2,'RuBisCO mass')
text(500, 0.1,'Begining of the industrial revolution','Rotation',90)
legend('Total collagen')