local io = require("io")
local http = require("socket.http")
local ltn12 = require("ltn12")

local hydna = {}


function hydna.send(url, data, priority)
    priority = priority or 0
    return do_request(url, data, priority)
end


function hydna.emit(url, data)
    return do_request(url, data, nil)
end


function do_request(url, data, priority)
    local response_body = {}
    local headers

    if url == nil then
        error("Expected url")
    end

    if data == nil or type(data) ~= "string" then
        error("Expected data as string")
    end

    if (string.sub(url, 1, 7) == "http://") == false or 
       (string.sub(url, 1, 8) == "https://") == false then
           url = "http://"..url
    end

    if #data > 0xffff then
        error("Data to large")
    end
    

    headers = {
        ["Content-Type"] = "text/plain",
        ["Content-Length"] = #data
    }

    if type(priority) == "number" then
        headers["X-Priority"] = priority
    else
        headers["X-Emit"] = "yes"
    end

    local r, code = http.request {
        method = "POST",
        headers = headers,
        url = url,
        source = ltn12.source.string(data),
        sink = ltn12.sink.table(response_body)
    }

    if r == nil then
        return code
    end

    if code ~= 200 then
        return table.concat(response_body)
    end
end


return hydna