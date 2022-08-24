function __parseIndexStr(indexstr, callback)
    if (type(indexstr) ~= "string") then
        return nil
    end
    for index in string.gmatch(indexstr, "[^|]+") do
        callback(tonumber(index))
    end
end

u8 = setmetatable({}, {
    __index = function(self, key)
        if (type(key) == "number") then
            for index = 1, key do
                self[index] = 0
            end
            self.__size = key
            return self
        end
    end,
    __call = function(self, indexstr, value)
        __parseIndexStr(indexstr, function(index)
            self[index] = value
        end)
    end,
    __newindex = function(self, key, value)
        if (type(key) == "string" and key:find("|")) then
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

function u8:new(size)
    for index = 1, size do
        self[index] = 0
    end
    self.__size = size
    return self
end

function prints(chars)
    local str = ""
    for code in string.gmatch(chars, "[^|]+") do
        str = str .. string.char(tonumber(code))
    end
    print(str)
end

function test5g()
    os.execute("start https://speedtest.net")
end
