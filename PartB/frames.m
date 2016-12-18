close all; clear;clc

vidObj = VideoReader('hard1.mp4');

[frames,edgeMaps] = getMaps(vidObj);