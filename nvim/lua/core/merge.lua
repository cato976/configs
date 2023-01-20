local api = vim.api
local group = vim.api.nvim_create_augroup("Merge_Diff", {clear = true})

api.nvim_create_autocmd(
{"WinEnter","BufEnter"},
{
    group = group,
    callback = function ()
        vim.schedule(CheckDiffMode)
    end
})

api.nvim_create_autocmd(
{"VimEnter","WinEnter"},
{
    group =group,
    callback = function ()
        vim.schedule(HighlightConflictMarkers)
    end,
})

function HighlightConflictMarkers()
    -- Inspect whether some windows are diff mode, and apply changes for
    -- such windows 
    -- Run asynchronously, to ensure '&diff' option is properly set in VIM

    -- Highlight VCS conflict markers
    if(not vim.fn.exists('w:_vsc_conflict_marker_match')) then
        vim.g['w:_vsc_conflict_marker_match'] = vim.fn.matchadd('ErrorMsg', '^(<|=|||>){7}([^=].+)?$')
    end
end

-- Set option using set or setlocal , be it string or boolean value
function _G.set_option(option, value, ...)
    local isLocal = value or 0
    local isBoolean = ... or 0
    if (isBoolean ~= 0) then
        if(isLocal == true) then
            if(value == true) then
                vim.fn.executable("setlocal "..option)
            else
                vim.fn.executable("setlocal no"..option)
            end
        else
            if(value == true) then
                vim.fn.executable("set "..option["option"])
            else
                vim.fn.executable("set no"..option)
            end
        end
    else
        if(isLocal == true) then
            vim.fn.executable("setlocal " ..option["option"].."="..option["value"])
        else
            vim.fn.executable("set " ..option["option"].."="..option["value"])
        end
    end
end

-- Detect window or buffer local option is in sync with diff mode
function Change_option_in_diffmode(scope, option, value, ...)
    local isBoolean = ... or 0
    local backupVarname = scope .. "_old_" .. option

    -- Entering diff mode
    if (vim.o.diff and vim.fn.exists(backupVarname)) == 0 then
        vim.fn.executable( "let " .. backupVarname .. "=&" .. value)
        set_option(option, value, 1, isBoolean)
    end

    -- Exiting diff mode
    if (not vim.o.diff and vim.fn.exists(backupVarname)) then
        local oldValue = value 
        set_option(option, oldValue, 1, isBoolean)
        vim.fn.executable( "unlet " .. backupVarname)
    end
end

function QuitWindow()
    if (vim.g["is_started_as_vim_diff"] == 1) then
        vim.cmd("qall")
        return
    end
    vim.cmd("quit")
end

-- In diff mode:
--  Disable syntax highlighting
--  Disable spell checking
function CheckDiffMode()
    -- Check each window
    if vim.o.diff then
        vim.g["is_started_as_vim_diff"] = 1
        vim.o.syntax = "off"
        vim.o.spell = "nospell"
    end
    vim.keymap.set("n", '<leader>q',  ":lua QuitWindow()<CR>")

    local rangeTable = vim.fn.range(1, vim.fn.winnr('$'))
    for k, _win in pairs(rangeTable) do
        vim.fn.executable( "noautocmd " .. _win .. "wincmd w")

        Change_option_in_diffmode('b:', 'syntax', 'off')
        Change_option_in_diffmode('w:', 'spell', 0, 1)
    end

    if vim.o.diff then
        vim.cmd("NvimTreeClose")
    end

    -- Get back to original window
    vim.fn.executable( "noautocmd " .. vim.fn.winnr() .. "wincmd w")
end
