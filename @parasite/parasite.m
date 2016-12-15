classdef parasite   %declares parasite object
    properties    %define parasite properties (parameters)
        m_index;
        pos;
        state;
        time;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
        %all additional member functions associated with this class are included as separate mfiles in the @parasite folder.
        function r=parasite(varargin) %constructor method for parasite - assigns values to parasite properties
            %r=parasite(pos,state)
            %pos - vector containg x,y, co-ords
            
            %Modified by Martin Bayley on 29/01/13
            
            switch nargin           %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0				%create default object
                    r.m_index = [];
                    r.pos=[];
                    r.state=[];
                    r.time=[];
                case 1              %input is already a parasite, so just return!
                    if (isa(varargin{1},'parasite'))
                        r=varargin{1};
                    else
                        error('Input argument is not a parasite')
                    end
                case 4               %create a new parasite (currently the only constructor method used)
                    r.m_index = varargin{1};
                    r.pos=varargin{2};               %current position in Cartesian co-ords [x y]
                    r.state=varargin{3};             %number of kilometres parasite can migrate in 1 day
                    r.time=varargin{4};
                otherwise
                    error('Invalid no. of input arguments')
            end
        end
    end
end
