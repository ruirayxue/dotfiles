vim.bo.formatprg = "prettier --parser typescript"

vim.lsp.start({
	name = "tsserver",
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local dap = require("dap")

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { "/Users/xuerx/Developer/vscode-js-debug/dist/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}
