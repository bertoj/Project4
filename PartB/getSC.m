function SC = getSC(samp,point,r_min,r_max,nbins_theta,nbins_r)

%SCDRAWPOLAR draw a polar on the center point
%   point           - the center point
%   r_min           - min radius
%   r_max           - max radius
%   nbins_theta     - theta divide
%   nbins_r         - r divide
%   fig_handle      - draw the diagram on which figure
gca;
hold on;

plot(samp(:,2)',samp(:,1)','r.');
plot(point(1),point(2),'ko');

r_bin_edges=logspace(log10(r_min),log10(r_max),nbins_r);

% draw circles
th = 0 : pi / 50 : 2 * pi;
xunit = cos(th);
yunit = sin(th);
for i=1:length(r_bin_edges)
    line(xunit * r_bin_edges(i) + point(1), ...
                    yunit * r_bin_edges(i) + point(2), ...
        'LineStyle', ':', 'Color', 'k', 'LineWidth', 1);
end

% draw spokes
th = (1:nbins_theta) * 2*pi / nbins_theta;
cs = [cos(th);zeros(1,size(th,2))];
sn = [sin(th);zeros(1,size(th,2))];
line(r_max*cs + point(1), r_max*sn + point(2),'LineStyle', ':', ...
    'Color', 'k', 'LineWidth', 1);

axis equal;
axis off;
hold off;
N = length(samp);
x = repmat(samp(:,2),1,N);
y = repmat(samp(:,1),1,N);

dist = sqrt((point(1)-samp(:,2)).^2 + (point(2)-samp(:,1)).^2);
%dist = dist(mean(mean(dist)));

theta = atan2(samp(:,1)-point(2),samp(:,2)-point(1));
theta = mod(theta,2*pi);

theta_bin = cell(5,1);
v = logspace(log10(r_min),log10(r_max),nbins_r);
for i = 1:8
theta_bin{i} = (theta>((i-1)/4) && (theta<i/4));

dist_bin = log10(theta_bin{i}.*dist);
dist_bin(dist_bin==0) = [];
SC(1,i) = sum(dist_bin>v(3)) && (dist_bin<v(4));
SC(2,i) = sum(dist_bin>v(2)) && (dist_bin<v(3));
SC(3,i) = sum(dist_bin>v(1)) && (dist_bin<v(2));
SC(4,i) = sum(dist_bin<v(1));
end

end