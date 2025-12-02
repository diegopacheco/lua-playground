local function create_fsm(initial_state, transitions)
    local state = initial_state
    return {
        get_state = function() return state end,
        transition = function(event)
            if transitions[state] and transitions[state][event] then
                state = transitions[state][event]
                return true
            end
            return false
        end
    }
end

local function create_fsm_with_actions(initial, transitions)
    local state = initial
    return {
        get_state = function() return state end,
        transition = function(event)
            if transitions[state] and transitions[state][event] then
                local trans = transitions[state][event]
                if trans.action then trans.action() end
                state = trans.to
                return true
            end
            return false
        end
    }
end

print("Basic State Machine:")
local door = create_fsm("closed", {closed = {open = "opened"}, opened = {close = "closed"}})
print("Initial state:", door.get_state())
door.transition("open")
print("After open:", door.get_state())
door.transition("close")
print("After close:", door.get_state())

print("\nFSM with Actions:")
local turnstile = create_fsm_with_actions("locked", {
    locked = {
        coin = {to = "unlocked", action = function() print("  Unlocking...") end},
        push = {to = "locked", action = function() print("  Locked, need coin") end}
    },
    unlocked = {push = {to = "locked", action = function() print("  Locking...") end}}
})
print("State:", turnstile.get_state())
turnstile.transition("coin")
turnstile.transition("push")
print("Final state:", turnstile.get_state())
