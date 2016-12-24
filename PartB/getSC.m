function SC = getSC(samp,point,r_min,r_max,nbins_theta,nbins_r)

dist = sqrt((point(1)-samp(:,2)).^2 + (point(2)-samp(:,1)).^2);
%dist = dist(mean(mean(dist)));

theta = atan2(samp(:,1)-point(2),samp(:,2)-point(1));
theta = mod(theta,2*pi);

theta_bin = cell(5,1);
v = logspace(log10(r_min),log10(r_max),nbins_r);
for i = 1:8
theta_bin{i} = (theta>(pi*(i-1)/4) & (theta<pi*i/4));

dist_bin = (theta_bin{i}.*dist);
dist_bin(dist_bin==0) = [];
SC(1,i) = sum((dist_bin>v(3)) & (dist_bin<v(4)));
SC(2,i) = sum((dist_bin>v(2)) & (dist_bin<v(3)));
SC(3,i) = sum((dist_bin>v(1)) & (dist_bin<v(2)));
SC(4,i) = sum(dist_bin<v(1));
end
SC = SC/max(max(SC));
end