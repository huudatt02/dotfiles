local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"

local lombok_path = jdtls_path .. "/lombok.jar"
local jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server"
local java_test_path = mason_path .. "/packages/java-test/extension/server"

local bundles = {
	vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar", 1),
}
local java_test_bundles = vim.split(vim.fn.glob(java_test_path .. "/*.jar", 1), "\n")
local excluded = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}
for _, java_test_jar in ipairs(java_test_bundles) do
	local fname = vim.fn.fnamemodify(java_test_jar, ":t")
	if not vim.tbl_contains(excluded, fname) then
		table.insert(bundles, java_test_jar)
	end
end
vim.list_extend(bundles, require("spring_boot").java_extensions())

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local uv = vim.uv or vim.loop
local uname = uv.os_uname()
local os_config

if uname.sysname == "Darwin" then
	os_config = uname.machine == "arm64" and "config_mac_arm" or "config_mac"
elseif uname.sysname == "Windows_NT" then
	os_config = "config_win"
else
	os_config = "config_linux"
end

local os_config_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/" .. os_config

local config = {
	name = "jdtls",
	on_attach = function(client, bufnr)
		if client.name ~= "jdtls" then
			return
		end

		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()

		vim.lsp.codelens.refresh({ bufnr = bufnr })

		vim.api.nvim_create_autocmd("BufWritePost", {
			buffer = bufnr,
			desc = "Refresh CodeLens for jdtls",
			callback = function()
				vim.lsp.codelens.refresh({ bufnr = bufnr })
			end,
		})
	end,
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-Xmx2G",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_path,
		"-jar",
		jar_path,
		"-configuration",
		os_config_path,
		"-data",
		workspace_dir,
	},
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			format = {
				enabled = false,
			},
			saveActions = {
				organizeImports = true,
			},
			implementationCodeLens = "types",
			referencesCodeLens = {
				enabled = false,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticThreshold = 9999,
				},
			},
			signatureHelp = {
				enabled = true,
				description = {
					enabled = true,
				},
			},
		},
	},
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
}
require("jdtls").start_or_attach(config)

local map = vim.keymap.set
-- Normal mode
map("n", "<leader>co", jdtls.organize_imports, { desc = "JDTLS: Organize Imports" })
map("n", "<leader>crv", jdtls.extract_variable, { desc = "JDTLS: Extract Variable" })
map("n", "<leader>crc", jdtls.extract_constant, { desc = "JDTLS: Extract Constant" })
map("n", "<leader>df", jdtls.test_class, { desc = "JDTLS: Test Class" })
map("n", "<leader>dn", jdtls.test_nearest_method, { desc = "JDTLS: Test Nearest Method" })

-- Visual mode
map("v", "<leader>crv", function()
	jdtls.extract_variable(true)
end, { desc = "JDTLS: Extract Variable" })
map("v", "<leader>crc", function()
	jdtls.extract_constant(true)
end, { desc = "JDTLS: Extract Constant" })
map("v", "<leader>crm", function()
	jdtls.extract_method(true)
end, { desc = "JDTLS: Extract Method" })
