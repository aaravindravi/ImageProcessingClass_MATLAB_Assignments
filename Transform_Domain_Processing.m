%% IP_assignment_01 - Transform Domain Processing
% To filter images in the transform domain (High pass and Low Pass
% filtering)

clc;
clear all;
close all;

input_image=imread('cameraman.tif');
input_image_doub=double(input_image);
%% Nomalization and Transform

[m n]=size(input_image_doub);
%Normalising the data
normalised_input_image=(input_image_doub - min(min(input_image_doub)))/((max(max(input_image_doub)))-(min(min(input_image_doub))));
%Taking the 2D fourier transform
fourier_input_image=(fft2(normalised_input_image));
fourier_input_image1=log10(abs(fourier_input_image));
transform_rep_image=fftshift(fourier_input_image1);

%% Mask Creation
mask_low(1:m,1:n)=0; %initialize to zeros
ms=100;              %Mask Size
for k=1:ms           %Creation of low pass filter Mask
    for l=1:ms
    mask_low(((m/2)+(ms/2)-k),((n/2)+(ms/2)-l))=1;  
    end
end

%% Filtering Lowpass
low_pass_transform=(fftshift(fourier_input_image)).*mask_low;
low_pass_filtered_out=abs(ifft2(low_pass_transform));

%% Filtering Highpass
mask_high=1-mask_low;

high_pass_transform=(fftshift(fourier_input_image)).*mask_high;
high_pass_filtered_out=abs(ifft2(high_pass_transform));

%% Displaying Operations
save_figure = figure;subplot(2,3,4);imshow(input_image,[]);title('Input Image');
subplot(2,3,1);imshow(transform_rep_image,[]);title('Input Image Magnitude Spectrum');
subplot(2,3,2);imshow(mask_low,[]);title('Low Pass Filter');
subplot(2,3,5);imshow(low_pass_filtered_out,[]);title('Smooth Image');
subplot(2,3,3);imshow(mask_high,[]);title('High Pass Filter');
subplot(2,3,6);imshow(high_pass_filtered_out,[]);title('Sharp Image');
print(save_figure,'Transform_Domain_Processing','-dpng');