classdef monkey   %declares monkey object
    properties    %define monkey properties (parameters) 
        pos;
        state;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
                                    %all additional member functions associated with this class are included as separate mfiles in the @monkey folder. 
        function r=monkey(varargin) %constructor method for monkey - assigns values to monkey properties
                %r=monkey(pos,state)
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

                switch nargin           %Use switch statement with nargin,varargin contructs to overload constructor methods
                    case 0				%create default object
                       r.pos=[];
                       r.state=[];
                    case 1              %input is already a monkey, so just return!
                       if (isa(varargin{1},'monkey'))		
                            r=varargin{1};
                       else
                            error('Input argument is not a monkey')
                            
                       end
                    case 2               %create a new monkey (currently the only constructor method used)
                       r.pos=varargin{1};               %current position in Cartesian co-ords [x y]
                       r.state=varargin{2};             %number of kilometres monkey can migrate in 1 day
                    otherwise
                       error('Invalid no. of input arguments')
                end
        end
    end
end
