local function create_stack()
    local items = {}
    return {
        push = function(value) table.insert(items, value) end,
        pop = function() return table.remove(items) end,
        peek = function() return items[#items] end,
        size = function() return #items end
    }
end

local function create_queue()
    local items, head, tail = {}, 1, 0
    return {
        enqueue = function(value) tail = tail + 1; items[tail] = value end,
        dequeue = function() if head > tail then return nil end; local v = items[head]; items[head] = nil; head = head + 1; return v end,
        size = function() return tail - head + 1 end
    }
end

local function create_tree(value)
    return {value = value, left = nil, right = nil}
end

local function insert_tree(root, value)
    if not root then return create_tree(value) end
    if value < root.value then root.left = insert_tree(root.left, value)
    else root.right = insert_tree(root.right, value) end
    return root
end

local function inorder(root, result)
    result = result or {}
    if root then inorder(root.left, result); table.insert(result, root.value); inorder(root.right, result) end
    return result
end

print("Stack:")
local stack = create_stack()
stack.push(1); stack.push(2); stack.push(3)
print("Top:", stack.peek())
print("Pop:", stack.pop(), stack.pop())

print("\nQueue:")
local queue = create_queue()
queue.enqueue("a"); queue.enqueue("b"); queue.enqueue("c")
print("Dequeue:", queue.dequeue(), queue.dequeue())

print("\nBinary Tree:")
local tree = create_tree(50)
tree = insert_tree(tree, 30)
tree = insert_tree(tree, 70)
tree = insert_tree(tree, 20)
tree = insert_tree(tree, 40)
print("Inorder:", table.concat(inorder(tree), ", "))
