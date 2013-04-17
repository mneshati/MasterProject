function result = funkygenerator(varargin)
% usage:
% result_matrix = funkygenerator([a b c], [d e f], [g h i], ...)
% where abc is for the first dimension where a: lower limit; b: step size;
% c: higher limit


% to extract varargin
% cell2mat(varargin(k))

% number of dimensions = number of inputs
nDim = nargin;

sizes = [];
for i = 1:nargin
    sizes(i,:) = cell2mat(varargin(i));
end

%{
for i = 1 : nDim
   
    % another thought
%   varDim(i) = sizes(i,1):sizes(i,2):sizes(i,3);
   v = sizes(2,1)
   
   
   l = l + sizes(1,2)
   if (l == sizes(1,3)
        v = v + sizes(2,2)
end
%}

varNDim = 1:nDim;
varIndices = [];
varStepSizes = [];
varUpLimit = [];
for i = 1 : nDim
   varIndices(1, i) = sizes(i, 1);
   varStepSizes(1, i) = sizes(i, 2);
   varUpLimit(1, i) = sizes(i, 3);
end

% initialize the "result" matrix
% result = ???

go = 0;
while (go)
    neighbour_matrix = generate_neighbours(varIndices);
    something = your_thing(neighbour_matrix);
    result(varIndices(1), varIndices(2), varIndices(3)) = something
    
    % now here we have to update each indices one by one
    % use varUpLimit to stop updating with conditional if
    % 
    % varIndices = varIndices + varStepSizes
end



end % function ends