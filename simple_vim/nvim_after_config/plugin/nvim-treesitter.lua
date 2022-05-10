local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then
  return
end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = false,
    disable = {}
  },
  ensure_installed = {
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "html",
    "scss",
    "python"
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
