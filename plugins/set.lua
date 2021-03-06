local function save_value(msg, name, value)
  if (not name or not value) then
    return "Usage: !set var_name value"
  end
  local hash = nil
  if msg.to.type == 'chat' then
    hash = 'chat:'..msg.to.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
    return "ذخیره شد "..name
  end
end
local function run(msg, matches)
  if not is_momod(msg) then
    return "فقط برای مدیر!"
  end
  local name = string.sub(matches[1], 1, 50)
  local value = string.sub(matches[2], 1, 1000)
  local name1 = user_print_name(msg.from)
  savelog(msg.to.id, name1.." ["..msg.from.id.."] ذخیره شد ["..name.."] به شماره > "..value )
  local text = save_value(msg, name, value)
  return text
end

return {
  patterns = {
   "^ذخیره ([^%s]+) (.+)$",
   "^[!/#]set ([^%s]+) (.+)$",
   "^set ([^%s]+) (.+)$"
  }, 
  run = run 
}

