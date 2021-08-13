require('lspconfig').pyright.setup {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python =  {
      analysis = {
        autoSearchPaths = false,
        useLibraryCodeForTypes = false,
        diagnosticMode = 'openFilesOnly',
      }
    }
  }
}

