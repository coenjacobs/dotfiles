return {
	-- https://github.com/nvim-lualine/lualine.nvim
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			options = {
				theme = 'catppuccin'
			}})
	end
}
