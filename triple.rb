class Triple
    include Enumerable

    def initialize(a=nil, b=nil, c=nil)
        @a, @b, @c = a, b, c
    end

    def each
        yield @a
        yield @b
        yield @c
    end
end