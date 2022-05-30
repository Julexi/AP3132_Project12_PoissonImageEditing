%% texture flattening
target='disney.jpg';
im_target=imread(target);
im_source=im_target; %in this case source is the same as traget
[im_mask,u,v]=roipoly(im_target); %select the area mask

[im_out, edge] = texture_flattening(im_source, im_target, im_mask);
figure,imshow(im_out);
figure,imshow(edge);

%% local clor changes
clc
clear all

target = "park.jpg";
im_source=imread(target);
gray_target=rgb2gray(im_source);
im_target=im_source;
[im_mask,u,v]=roipoly(im_source); %select the area mask
im_source(:,:,1) = im_target(:, :, 1)*0.5;
im_source(:,:,2) = im_target(:, :, 2)*0.1;
im_source(:,:,3) = im_target(:, :, 3)*2;
im_out = color_changes(im_source, im_target, im_mask);
imshow(im_out);
%% local color changes 
% target='heart.jpg';
% im_source=imread(target);
% gray_target=rgb2gray(im_source);
% im_target=im_source;
% [im_mask,u,v]=roipoly(im_source); %select the area mask
% 
% src_R = im_target(:, :, 1);
% src_G = im_target(:, :, 2);
% src_B = im_target(:, :, 3);
% 
% %background is gray 
% % rchannel = color_changes2(src_R, gray_target, im_mask);
% % gchannel = color_changes2(src_G, gray_target, im_mask);
% % bchannel = color_changes2(src_B, gray_target, im_mask);
% rchannel = color_changes2(src_R, src_R, gray_target, im_mask);
% gchannel = color_changes2(src_G, src_G, gray_target, im_mask);
% bchannel = color_changes2(src_B, src_B, gray_target, im_mask);
% % change color of mask area
% % rchannel = color_changes2(src_R*0.5, src_R, im_mask);
% % gchannel = color_changes2(src_G*0.1, src_G, im_mask );
% % bchannel = color_changes2(src_B*2, src_B, im_mask );
% 
% im_out = zeros(size(bchannel,1), size(bchannel,2), 3);
% im_out(:, :, 1) = rchannel;
% im_out(:, :, 2) = gchannel;
% im_out(:, :, 3) = bchannel;
% imshow(im_out);
%% seamless tiling
tile_img = imread('flower2.jpg');

% Top and Bottom
north_tile = tile_img;
south_tile = tile_img;
north_tile(end,:,:) = (north_tile(end,:,:) + south_tile(1,:,:))/2;
south_tile(1,:,:) = north_tile(end,:,:);
north_tile = PIE_seamless_tiling(tile_img,north_tile);
south_tile = PIE_seamless_tiling(tile_img,south_tile);

figure,imshow(cat(1,north_tile,south_tile));
figure,imshow(cat(1,tile_img,tile_img));
tile_img2=cat(1,north_tile,south_tile);
% Left middle Right
west_tile = tile_img2;
middle_tile = tile_img2;
east_tile = tile_img2;

middle_tile(:,1,:) = (middle_tile(:,1,:) + west_tile(:,end,:))/2;
west_tile(:,end,:) = middle_tile(:,1,:);

east_tile(:,1,:) = (east_tile(:,1,:) + middle_tile(:,end,:))/2;
middle_tile(:,end,:) = east_tile(:,1,:);

west_tile = PIE_seamless_tiling(tile_img2,west_tile);
middle_tile = PIE_seamless_tiling(tile_img2,middle_tile);
east_tile = PIE_seamless_tiling(tile_img2,east_tile);

figure,imshow(cat(2,west_tile,middle_tile,east_tile));
tile_img3=cat(2,tile_img,tile_img,tile_img);
figure,imshow(cat(1,tile_img3,tile_img3));
%% illumination changes
target='kenny.jpg';
im_target=imread(target);
im_source=im_target; %in this case source is the same as traget
[im_mask,u,v]=roipoly(im_target); %select the area mask

result = illumination_changes(im_source, im_target, im_mask);
imshow(result);

