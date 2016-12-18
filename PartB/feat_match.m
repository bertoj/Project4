% descs1 is a 64x(n1) matrix of double values
% descs2 is a 64x(n2) matrix of double values
% match is n1x1 vector of integers where m(i) points to the index of the
% descriptor in p2 that matches with the descriptor p1(:,i).
% If no match is found, m(i) = -1

function [match] = feat_match(descs1, descs2)

num = length(descs1);
threshold = .75;

for i = 1:num
    % Compute SSD 
     %SSD = sum((descs1(:, i) - descs2).^2, 1);
    squared_dist = sum(bsxfun(@minus, descs1(:, i), descs2).^2, 1);

    % 2 closest points
    [squared_dist index] = sort(squared_dist, 2);
    
    % check if match. if not set to -1
    if ((squared_dist(1)/ squared_dist(2))<threshold)
        match(i) = index(1);
    else
        match(i) = -1;
    end
end
end