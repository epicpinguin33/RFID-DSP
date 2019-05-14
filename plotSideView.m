function plotSideView(ax,geometry)
%PLOTSIDEVIEW Summary of this function goes here
%   Detailed explanation goes here
cla(ax)
hold(ax,'on')
plot(ax,geometry.d / 2,geometry.TxHeight,'xb')
plot(ax,-geometry.d / 2,geometry.RxHeight,'xb')
plot(ax,geometry.scatterers.x,geometry.scatterers.y,'ok','markerSize',5,'markerEdgeColor',[.01 .01 .01] )
plot(ax,[-geometry.tempWidth geometry.tempWidth],[0 0],'k')
text(ax,geometry.Tags(1,:),geometry.Tags(2,:),{'1';'2';'3';'4';'5';'6';'7';'8'},'xr')  
ax.YLim=[-geometry.GroundDepth-.01 geometry.TxHeight+.1];
ax.XLim=[-geometry.tempWidth geometry.tempWidth];
end

