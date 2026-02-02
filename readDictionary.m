% This is the function: ReadDictionary

function [fileWords] = readDictionary(filename)
% This function reads in a dictionary
% Inputs: filename where the word is going to be generated from

% Read the file name
file = fileread(filename);

% Convert the texts to each word i.e. strings
fileWords = strsplit(file, ', ');

end