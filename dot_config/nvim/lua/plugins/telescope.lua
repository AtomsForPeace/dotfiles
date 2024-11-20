return {
  {
	  "nvim-telescope/telescope.nvim",
	  tag = '0.1.5',
	  branch = '0.1.x',
	  dependencies = {
	    {'nvim-lua/plenary.nvim'},
	    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
	  },
	  keys = {
	    {
	      '<leader>pf', 
		function()
		  require('telescope.builtin').find_files({})
		end,
	      	mode = {'n'},
      	    },
	    {
		'<leader>ps', 
		function()
		  require('telescope.builtin').live_grep({})
	      	end,
	      	mode = {'n'},
	    }
    	  },

	  config = function(_, opts)
	    require('telescope').load_extension('fzf')
	  end
  }
}
