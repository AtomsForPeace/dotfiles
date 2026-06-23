return {
  {
	  "nvim-telescope/telescope.nvim",
	  tag = '0.1.5',
	  branch = '0.1.x',
	  dependencies = {
	    {'nvim-lua/plenary.nvim'},
	    {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
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
		  require('telescope').extensions.live_grep_args.live_grep_args()
	      	end,
	      	mode = {'n'},
	    }
      },

	  config = function(_, opts)
	    require('telescope').load_extension('fzf')
        require('telescope').load_extension("live_grep_args")
	  end
  }
}
