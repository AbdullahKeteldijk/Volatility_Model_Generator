clear all
clc
close all

%%

load  DB_test


%% Calculating significance

% for i = 1:length(mTvalue)
%     for j = 1:length(mTvalue)
%         if (mTvalue(i,j)) > 3.291  
%             mTvalue_new(i,j) = 6;
%         end
%         if (mTvalue(i,j)) > 3.09
%             mTvalue_new(i,j) = 5;
%         end
%         if (mTvalue(i,j)) > 2.576
%             mTvalue_new(i,j) = 4;
%         end
%         if (mTvalue(i,j)) > 2.326
%             mTvalue_new(i,j) = 3;
%         end
%         if (mTvalue(i,j)) > 1.96
%             mTvalue_new(i,j) = 2;
%         end
%         if (mTvalue(i,j)) > 1.645
%             mTvalue_new(i,j) = 1;
%         end
%         if (mTvalue(i,j)) < 1.645 && (mTvalue(i,j)) > -1.645
%             mTvalue_new(i,j) = 0;
%         end
%         if (mTvalue(i,j)) < -1.645
%             mTvalue_new(i,j) = -1;
%         end
%         if (mTvalue(i,j)) < -1.96
%             mTvalue_new(i,j) = -2;
%         end
%         if (mTvalue(i,j)) < -2.326
%             mTvalue_new(i,j) = -3;
%         end
%         if (mTvalue(i,j)) < -2.576
%             mTvalue_new(i,j) = -4;
%         end
%         if (mTvalue(i,j)) < -3.09
%             mTvalue_new(i,j) = -5;
%         end
%         if (mTvalue(i,j)) < -3.291  
%             mTvalue_new(i,j) = -6;
%         end
%     end
% end


%% 

mTvalue(isnan(mTvalue))=0;
for i = 1:length(mTvalue)
    for j = 1:length(mTvalue)
        if (mTvalue(i,j)) > 1.645
            mTvalue(i,j) = 1;
        elseif  mTvalue(i,j) < 1.645 && mTvalue(i,j) > -1.645
            mTvalue(i,j) = 0;
        elseif (mTvalue(i,j)) < -1.645
            mTvalue(i,j) = -1;
        end
    end
end
            

%%
imagesc(mTvalue)%plot matrix
% set(gca, 'XTick', 1:n); % center x-axis ticks on bins
% set(gca, 'YTick', 1:n); % center y-axis ticks on bins
% set(gca, 'XTickLabel', L); % set x-axis labels
% set(gca, 'YTickLabel', L); % set y-axis labels
title('Heatmap DB test', 'FontSize', 14); % set title
colormap('jet'); % set the colorscheme
colorbar; % enable colorbar


