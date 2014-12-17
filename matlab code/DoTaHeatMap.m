heatmap = zeros(max(x),max(y));

for j = 2: length(x)
 heatmap(x(j), y(j)) = heatmap(x(j), y(j)) + 1;
end


heatmap = heatmap / max(heatmap(:)); %normilize
heatmap = ceil(heatmap * 40); %scale by 9

%save the heatmap matrix to a csv file
%csvwrite('heatmap.csv',heatmap)

%apply the Canny edge algorithm
%heatmap = edge(heatmap,'canny'); 

%apply a 4x4 median filter
%heatmap = medfilt2(heatmap, [4 4]);


[rows,cols] = size(heatmap);
table = zeros(rows * cols,3);
count = 1;

for j = 1: rows
    for i = 1: cols
        table(count,1) = i;
        table(count,2) = j;
        table(count,3) = heatmap(j,i);
        count = count + 1; 
    end
end

csvwrite('HM.csv',table)
