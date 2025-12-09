local function create_subject()
    local observers = {}
    return {
        attach = function(observer) table.insert(observers, observer) end,
        detach = function(observer)
            for i, obs in ipairs(observers) do
                if obs == observer then table.remove(observers, i); break end
            end
        end,
        notify = function(data)
            for _, observer in ipairs(observers) do observer(data) end
        end
    }
end

local function create_event_emitter()
    local listeners = {}
    return {
        on = function(event, callback)
            if not listeners[event] then listeners[event] = {} end
            table.insert(listeners[event], callback)
        end,
        emit = function(event, ...)
            if listeners[event] then
                for _, callback in ipairs(listeners[event]) do callback(...) end
            end
        end
    }
end

local function create_observable(initial_value)
    local value, observers = initial_value, {}
    return {
        get = function() return value end,
        set = function(new_value)
            local old_value = value
            value = new_value
            for _, observer in ipairs(observers) do observer(new_value, old_value) end
        end,
        observe = function(callback) table.insert(observers, callback) end
    }
end

print("Basic Observer:")
local subject = create_subject()
subject.attach(function(data) print("Observer 1:", data) end)
subject.attach(function(data) print("Observer 2:", data) end)
subject.notify("Hello!")

print("\nEvent Emitter:")
local emitter = create_event_emitter()
emitter.on("data", function(value) print("Data event:", value) end)
emitter.emit("data", 42)

print("\nObservable:")
local counter = create_observable(0)
counter.observe(function(new_val, old_val) print("Changed from", old_val, "to", new_val) end)
counter.set(1)
counter.set(5)
