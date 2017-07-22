class Api::ParamMissing < Exception
    def message
        "Parameter #{super} is missing"    
    end
end