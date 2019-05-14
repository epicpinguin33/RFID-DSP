function r = SelectTaglocation(s,position)
%APP.SYSTEMSIDEVIEW Summary of this function goes here
%   Detailed explanation goes here
fig=figure();
fig.Position=position;
ax=subplot(1,1,1);
plotSideView(ax,s.geometry)
[r]=ginput(1);
close
end

