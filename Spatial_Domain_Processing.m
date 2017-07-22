%% IP_assignment_02 - Spatial Domain Processing
% To filter images in the spatial domain (High pass and Low Pass
% filtering)

clc; 
clear all;
close all;

%% Preprocessing

%input_image=imread('rice.png');
input_image=imread('cameraman.tif');

input_image_doub=double(input_image);%preprocessing step ends

%% Processing step
brightness = 50;
bright_image_out=(input_image_doub+brightness); %increase brightness by 50 

negative_image_out=(255-input_image_doub);%negative of an image

%image smoothing by averaging 1/9 mask Lowpass filtering
low_mask=[1/9 1/9 1/9;
          1/9 1/9 1/9;
          1/9 1/9 1/9]; 
low_pass_filtered=(conv2(input_image_doub,low_mask,'same')); %2D convolution

%Laplacian filter - image highpass filtering can detect region change
high_mask=[0 -1 0;
          -1 4 -1;
           0 -1 0];
%2D convolution 
high_pass_filtered=(conv2(input_image_doub,double(high_mask),'same')); 

%% Displaying Image Output
save_figure = figure;subplot(2,3,1); imshow(input_image_doub,[]); title('Input Image');
subplot(2,3,2); imshow(bright_image_out,[]);title('Bright Image');
subplot(2,3,3); imshow(negative_image_out,[]);title('Negative Image');
subplot(2,3,4); imshow(low_pass_filtered,[]);title('LPF - Smooth Image');
subplot(2,3,5); imshow(high_pass_filtered,[]);title('HPF - Sharp Image');
print(save_figure,'Spatial_Domain_Processing','-dpng');
