package.path = package.path .. ';.\\?.lua';
require "helang"

prints'72 | 101 | 108 | 108 | 111 | 44 | 32 | 119 | 111 | 114 | 108 | 100 | 33'

-- forceCon = u8:new(68)
forceCon = u8[68]

forceCon('1 | 2 | 6 | 7 | 11 | 52 | 57 | 58 | 65', 10)
-- or
-- forceCon['1 | 2 | 6 | 7 | 11 | 52 | 57 | 58 | 65'] = 10

print(forceCon)

test5g()
