function systemSideView = SelectTaglocation(systemSideView)
%APP.SYSTEMSIDEVIEW Summary of this function goes here
%   Detailed explanation goes here
fig=figure();
ax=subplot(1,1,1);
plot(ax,systemSideView.Xaxis,systemSideView.Yaxis)
plot(ax,rand(1),rand(1),'x')
assignin('base','ax',systemSideView)
%systemSideView=ax
end

