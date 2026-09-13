return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,

        inlayHints = {
          callArgumentNames = true,
          functionReturnTypes = true,
          variableTypes = true,
        },
      },
    },
  },
}
