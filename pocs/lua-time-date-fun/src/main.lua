print("Current Time:")
local now = os.time()
print("Timestamp:", now)
print("Formatted:", os.date("%Y-%m-%d %H:%M:%S", now))

print("\nDate Components:")
local date = os.date("*t", now)
print("Year:", date.year, "Month:", date.month, "Day:", date.day)
print("Hour:", date.hour, "Min:", date.min, "Sec:", date.sec)

print("\nDate Formats:")
print("ISO 8601:", os.date("%Y-%m-%dT%H:%M:%S", now))
print("US Format:", os.date("%m/%d/%Y", now))
print("Long:", os.date("%A, %B %d, %Y", now))

local function create_date(year, month, day, hour, min, sec)
    return os.time({year = year, month = month, day = day, hour = hour or 0, min = min or 0, sec = sec or 0})
end

local function add_days(timestamp, days)
    return timestamp + (days * 24 * 60 * 60)
end

local function days_between(ts1, ts2)
    return math.floor((ts2 - ts1) / (24 * 60 * 60))
end

local function is_leap_year(year)
    return (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)
end

print("\nDate Arithmetic:")
local tomorrow = add_days(now, 1)
local yesterday = add_days(now, -1)
print("Yesterday:", os.date("%Y-%m-%d", yesterday))
print("Tomorrow:", os.date("%Y-%m-%d", tomorrow))

print("\nUtility:")
print("2024 is leap:", is_leap_year(2024))
print("2023 is leap:", is_leap_year(2023))

local new_year = create_date(2025, 1, 1)
print("Days until 2025:", days_between(now, new_year))

local function format_duration(seconds)
    local days = math.floor(seconds / (24 * 60 * 60))
    seconds = seconds % (24 * 60 * 60)
    local hours = math.floor(seconds / (60 * 60))
    seconds = seconds % (60 * 60)
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%dd %dh %dm %ds", days, hours, mins, secs)
end

print("\nDuration:")
print("100000 seconds:", format_duration(100000))
