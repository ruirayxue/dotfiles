vim.bo.formatprg = "stylua -"

vim.lsp.start({
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim", "hs" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})