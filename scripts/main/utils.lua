function TransferTable(source, destination)
    for key, value in pairs(source) do
        if type(value) == "table" then
            if not destination[key] then
                destination[key] = {} 
            end
            TransferTable(value, destination[key]) 
        else
            if not destination[key] then
                destination[key] = value 
            end
        end
    end
end

_G.TransferTable = TransferTable