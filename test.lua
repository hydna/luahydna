local hydna = require "hydna"
local err


err = hydna.send("testing.hydna.net", "testdata")
if err ~= nil then error(err) end

err = hydna.send("testing.hydna.net/open-deny", "testdata")
if err ~= "DENIED" then error(err) end

err = hydna.emit("testing.hydna.net", "testdata")
if err ~= nil then error(err) end

err = hydna.emit("testing.hydna.net/open-deny", "testdata")
if err ~= "DENIED" then error(err) end
