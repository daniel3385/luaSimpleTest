--[[
-- Author: Daniel Cabral Silveira
--]]

function inRed(text)
    return "\27[31m"..text.."\27[37m"
end

function inGreen(text)
    return "\27[32m"..text.."\27[37m"
end

---------------------------------------------------------------
-- Class Test
Test = {}

function Test:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.results = {}
    self.ok = 0
    self.nok = 0
    return obj
end

function Test:setDescription(text)
    self.description = text
end

function Test:getDescription()
    return self.description
end

function Test:incrementOk()
    self.ok = self.ok + 1
end

function Test:incrementNok()
    self.nok = self.nok + 1
end

function Test:equal(value1, value2)
    local result
    result = "Expected "..tostring(value2).." got "..tostring(value1)
    if value1 == value2 then
        result = result.." ----> OK"
        self:incrementOk()
    else
        result = result..inRed("----> NOK")
        self:incrementNok()
    end
    self.results[#self.results + 1] = result
end

function Test:runTests()
    print("\n----------------------------------------")
    print(self:getDescription())
    local results = self.results
    for i,v in ipairs(results) do
        print("Test "..i..":"..v)
    end
    print("OK: "..self.ok)
    print("NOK: "..self.nok)
    if self.nok ~= 0 then
        print(tostring("\""..self:getDescription()).."\""..inRed(" FAILED!"))
    else
        print(tostring("\""..self:getDescription()).."\""..inGreen(" PASSED!"))
    end
end
