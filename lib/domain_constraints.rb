class DomainConstraints
    def initialize(*domains)
        @domains = [domains].flatten
    end

    def matches?(request)
        @domains.include? request.domain
    end
end  
