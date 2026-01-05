local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local jar_path =
	vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities

local os_config = ""
if vim.fn.has("macunix") == 1 then
	os_config = "config_mac_arm"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
else
	os_config = "config_linux"
end
local os_config_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/" .. os_config

local bundles = {
  vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
}
local java_test_bundles = vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n")
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

local config = {
	name = "jdtls",
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-Xmx1G",
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
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
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
map("v", "<leader>crv", function() jdtls.extract_variable(true) end, { desc = "JDTLS: Extract Variable" })
map("v", "<leader>crc", function() jdtls.extract_constant(true) end, { desc = "JDTLS: Extract Constant" })
map("v", "<leader>crm", function() jdtls.extract_method(true) end, { desc = "JDTLS: Extract Method" })
