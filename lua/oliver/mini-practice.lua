-- =============================================================================
-- mini.surround practice
-- =============================================================================
--
-- Default keymaps:
--   sa{motion}{char}  Add surrounding
--   sd{char}          Delete surrounding
--   sr{char}{char}    Replace surrounding
--   sf{char}          Find surrounding (forward)
--   sF{char}          Find surrounding (backward)
--   sh{char}          Highlight surrounding
--
-- Common surrounding chars:
--   ( ) [ ] { }   brackets (use either open or close)
--   ' " `         quotes
--   t             HTML tag
--
-- =============================================================================
-- SECTION 1: sa - Add surrounding
-- =============================================================================

-- Exercise 1: saiw)
-- Place cursor on a word below, then type: saiw)
-- Goal: wrap the word in parentheses

local hello = (world)
local foo = (bar)
local result = (value)

-- Exercise 2: saiw"
-- Place cursor on a word, type: saiw"
-- Goal: wrap the word in double quotes

local name = "Oliver"
local city = "London"
local lang = "Lua"

-- Exercise 3: saiw]
-- Place cursor on a word, type: saiw]
-- Goal: wrap the word in square brackets

local index = [key]
local lookup = [item]
local get = [entry]

-- Exercise 4: sa + visual selection
-- Visually select some text (v or V), then type: sa)
-- Goal: wrap the selection in parens

local x = (one + two)
local y = (alpha + beta)
local z = (left + right)

-- Exercise 5: saip{
-- Place cursor inside a paragraph/block, type: saip{
-- Goal: wrap the inner paragraph in braces


{ local a = 1
local b = 2
local c = 3 }


-- =============================================================================
-- SECTION 2: sd - Delete surrounding
-- =============================================================================

-- Exercise 6: sd"
-- Place cursor inside quotes, type: sd"
-- Goal: remove the double quotes

local msg = hello world
local tag = neovim
local greeting = good morning

-- Exercise 7: sd)
-- Place cursor inside parens, type: sd)
-- Goal: remove the parentheses

local sum = a + b
local product = x * y
local check = condition

-- Exercise 8: sd]
-- Place cursor inside brackets, type: sd]

local arr = element
local ref = pointer

-- Exercise 9: sd'
-- Place cursor inside single quotes, type: sd'

local key1 = alpha
local key2 = beta
local key3 = gamma

-- =============================================================================
-- SECTION 3: sr - Replace surrounding
-- =============================================================================

-- Exercise 10: sr)"
-- Place cursor inside parens, type: sr)"
-- Goal: replace ( ) with " "

local call = "my_function"
local val = "some_value"
local expr = "x + 1"

-- Exercise 11: sr"'
-- Place cursor inside double quotes, type: sr"'
-- Goal: replace " " with ' '

local str1 = 'replace me'
local str2 = 'swap quotes'
local str3 = 'double to single'

-- Exercise 12: sr']
-- Place cursor inside single quotes, type: sr']
-- Goal: replace ' ' with [ ]

local item1 = [alpha]
local item2 = [beta]

-- Exercise 13: sr{)
-- Place cursor inside braces, type: sr{)
-- Goal: replace { } with ( )

local block = (content)
local scope = (inner)

-- =============================================================================
-- SECTION 4: sf / sF - Find surrounding
-- =============================================================================

-- Exercise 14: sf"
-- Place cursor BEFORE the quoted string, type: sf"
-- Goal: jump cursor to the next " surrounding

local a1 = "first" .. "second" .. "third"

-- Exercise 15: sF)
-- Place cursor AFTER parens, type: sF)
-- Goal: jump cursor to the previous ) surrounding

local b1 = func(arg1) + func(arg2) + func(arg3)

-- =============================================================================
-- SECTION 5: sh - Highlight surrounding
-- =============================================================================

-- Exercise 16: sh"
-- Place cursor inside quotes, type: sh"
-- Goal: highlight the surrounding quotes (useful to verify before sd/sr)

local h1 = "highlight this"
local h2 = 'and this'
local h3 = (or this)

-- =============================================================================
-- SECTION 6: Mixed drills
-- =============================================================================

-- Drill A: Chain operations
-- 1. saiw"  on:  word
-- 2. sr"'   on result
-- 3. sd'    on result
-- Goal: practice the full add -> replace -> delete cycle

local word = practice

-- Drill B: Nested surroundings
-- Try: saiw)  then  saiw"  on the result
-- Goal: build up nested surroundings

local nested = deep

-- Drill C: Multi-word with visual
-- Visually select "quick brown" below, then sa"
-- Then sr"' on the result

local sentence = quick brown fox

-- Drill D: Replace all quote styles on this line
-- sr"' then sr'` then sr`"  -- cycle through all quote types

local cycling = word

-- =============================================================================
-- vim: ts=2 sts=2 sw=2 et
