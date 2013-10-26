local hydna = require "hydna"


local err = hydna.send("public.hydna.net", "Hello world from Lua!")

if err ~= nil then
    print("An error occured: "..err)
else
    print("Message was sent successfully")
end
