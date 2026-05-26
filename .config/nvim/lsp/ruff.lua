-- Ruff handles formatting/linting only; disable hover so other LSPs (e.g. basedpyright) take over
return {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
