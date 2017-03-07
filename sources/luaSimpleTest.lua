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
    self.blocks = {}
    self.results = {}
    self.ok = 0
    self.nok = 0
    return obj
end

function Test:incrementOk()
    self.ok = self.ok + 1
end

function Test:incrementNok()
    self.nok = self.nok + 1
end

function Test:blockNew()
    local block = Block:new()
    table.insert(self.blocks, block)
    return block
end

function Test:runTests()
    for _,v in ipairs(self.blocks) do
        print("\n----------------------------------------")
        print(v:getDescription())
        -- result of each block
        local results = v.results
        print("dnaiel -> "..tostring(results))
        for i,v in ipairs(results) do
            print("Test "..i..": "..v)
        end
        print("OK: "..v.ok)
        print("NOK: "..v.nok)
        if v.nok ~= 0 then
            print(tostring("\""..v:getDescription()).."\""..inRed(" FAILED!"))
        else
            print(tostring("\""..v:getDescription()).."\""..inGreen(" PASSED!"))
        end
        self.ok = self.ok + v.ok
        self.nok = self.nok + v.nok
    end
    print("Result of tests: OK:"..self.ok.. " NOK:"..self.nok)
    if self.nok ~= 0 then
        print(inRed("Test FAILED!"))
    else
        print(inGreen("Test PASSED!"))
    end
end

---------------------------------------------------------------
-- Class Block
Block = {}
function Block:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.results = {}
    self.ok = 0
    self.nok = 0
    return obj
end

function Block:setDescription(text)
    self.description = text
end

function Block:getDescription()
    return self.description
end

function Block:incrementOk()
    self.ok = self.ok + 1
end

function Block:incrementNok()
    self.nok = self.nok + 1
end

function Block:equal(value1, value2)
    local result
    result = "Expected "..tostring(value2).." got "..tostring(value1)
    if value1 == value2 then
        result = result.." ----> OK"
        self:incrementOk()
    else
        result = result..inRed(" ----> NOK")
        self:incrementNok()
    end
    print("daniel: "..tostring(self.results))
    print(result)
    print(#self.results)
    --self.results[#self.results + 1] = result
    table.insert(self.results, result)
end

