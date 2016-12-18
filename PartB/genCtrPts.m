function CtrPts = genCtrPts(features,CB,face)

[row col,d] = size(face);
voteMap1 = zeros(row,col);
voteMap = zeros(row,col);
% voteMap = cell(5,1);
for j =1:5
    p_last = 0;
    for i = 1:10000
        feature = features(i).feature;
        mask = features(i).mask;
        loc = features(i).loc;
        %     for j = 1:5
        %     SSD(j) = norm(feature-CB(j).feature);
        %     end
        SSD = norm(feature-CB(j).feature);
        p = (exp(-SSD));
%         if p>p_last
%             voteMap{j} = loc;
%             p_last = p;
%         end
%             
        %[m, ind] = min(SSD);
        %     if m<2
        %         m = 1;
        %     elseif (m>2 & m<4)
        %         m = 0;
        %     else
        %         m = 0;
        %     end
        %     voteMap = voteMap + (m*mask);
        % if m<2
        %     m = 1;
        % else
        %     m=0;
        % end
        if p<.4
            p = 0;
        end
        voteMap1(loc(2),loc(1)) = p;
        %voteMap = voteMap+(p*mask);
    end
        shift = CB(1).pos - CB(j).pos;
        vM = zeros(size(voteMap1));
    
        if (shift(1)<0 && shift(2)<0)
    
            vM(1:end+shift(2),1:end+shift(1)) = voteMap1(-shift(2)+1:end,-shift(1)+1:end);
    
        elseif (shift(1)<0 && shift(2)>0)
    
            vM(shift(2)+1:end,1:end+shift(1)) = voteMap1(1:end-shift(2),-shift(1)+1:end);
    
        elseif(shift(1)>0 && shift(2)<0)
    
            vM(1:end+shift(2),shift(1)+1:end) = voteMap1(-shift(2)+1:end,1:end-shift(1));
        else
            vM(shift(2)+1:end,shift(1)+1:end) = voteMap1(1:end-shift(2),1:end-shift(1));
        end
        voteMap = voteMap+vM;
end
%colormap('hot')
%magesc(voteMap)
[value, location] = max(voteMap(:));
[R,C] = ind2sub(size(voteMap),location);

CtrPts(1,:) = [R,C];
offset = CB(2).offset;
CtrPts(2,:) = [R-offset(2),C-offset(1)];
offset = CB(3).offset;
CtrPts(3,:) = [R-offset(2),C-offset(1)];
offset = CB(4).offset;
CtrPts(4,:) = [R-offset(2),C-offset(1)];
offset = CB(5).offset;
CtrPts(5,:) = [R-offset(2),C-offset(1)];
end