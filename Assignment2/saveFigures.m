% the code below was used to save figures into the output folder as jpg
% images in the specified directory. Parts of it are hard-coded, so it wont
% work on all machines
function saveFigures(assignmentNum,fileTitle, type)
folder = strcat('C:\Users\Skylar\Documents\GitHub\CS3200\Assigment',num2str(assignmentNum),'\output');
fileName = sprintf(fileTitle);
saveas(gcf, fullfile(folder, fileName), type);
