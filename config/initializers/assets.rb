# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.precompile << "jquery.js"
Rails.application.config.assets.precompile << "jquery-ui.js"
Rails.application.config.assets.precompile << "tinymce-jquery.js"

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( chek-box-text.js, public.css )
Rails.application.config.assets.precompile += %w( toggle-panels.js )
Rails.application.config.assets.precompile += %w( jquery-ui.css )
Rails.application.config.assets.precompile += %w( font-awesome.css )