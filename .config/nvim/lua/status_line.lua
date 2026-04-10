Statusline = {}

local config = {
    placeholder_hl = "StatusLineDim",
}


-- local function hl(group, text)
--     return string.format("%%#%s#%s%%*", group, text)
-- end
-- vim.api.nvim_set_hl(0, config.placeholder_hl, {}) -- create if missing
-- vim.api.nvim_set_hl(0, config.placeholder_hl, { link = "String" })
--
-- local function filepath()
--     local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
--
--     if fpath == "" or fpath == "." then
--         return ""
--     end
--
--     -- return string.format("%%<%s/", fpath)
--
--     return hl(config.placeholder_hl, string.format("%%<%s/", fpath))
-- end

function Statusline.active()
    -- `%P` shows the scroll percentage but says 'Bot', 'Top' and 'All' as well.
    -- %= is midline
    return table.concat { "%f %m %=", vim.diagnostic.status(), "  %b 0x%B %l:%c" }
end

function Statusline.inactive()
    return " %t"
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})
