function __parseIndexStr(indexstr, callback)
    if (type(indexstr) ~= "string") then
        return nil
    end
    for index in string.gmatch(indexstr, "[^|]+") do
        callback(tonumber(index))
    end
end

u8 = setmetatable({
    new = function(self, size)
        for index = 1, size do
            self[index] = 0
        end
        self.__size = size
        return self
    end
}, {
    __index = function(self, key)
        if (type(key) == "number") then
            for index = 1, key do
                self[index] = 0
            end
            self.__size = key
            return self
        end
    end,
    __call = function(self, indexs, value)
        if type(indexs) == "table" then
            for index in pairs(indexs) do
                rawset(self, index, value)
            end
        elseif type(indexs) == "string" then
            __parseIndexStr(indexs, function(index)
                rawset(self, index, value)
            end)
        end
    end,
    __newindex = function(self, key, value)
        if (type(key) == "table") then
            for index in pairs(key) do
                rawset(self, index, value)
            end
        elseif (type(key) == "string" and key:find("|")) then
            __parseIndexStr(key, function(index)
                rawset(self, index, value)
            end)
        else
            rawset(self, key, value)
        end
    end,
    __tostring = function(self)
        local str = "[ "
        local size = self.__size
        for index = 1, size do
            str = str .. tostring(self[index]) .. ", "
        end
        return str:sub(0, -3) .. " ]"
    end
})

local stringmt = getmetatable("")
stringmt.__bor = function(a, b)
    if type(a) ~= "table" then
        a = { a }
    end
    table.insert(a, b)
    return a
end
debug.setmetatable('', stringmt)

function prints(chars)
    local str = ""
    if type(chars) == "table" then
        for _, char in ipairs(chars) do
            str = str .. string.char(char)
        end
    else
        for code in string.gmatch(chars, "[^|]+") do
            str = str .. string.char(tonumber(code))
        end
    end
    print(str)
end

function test5g()
    os.execute("start https://speedtest.net")
end
