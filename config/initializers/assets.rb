# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( accounts.js alejandros.js bancos.js cart.js categories.js members.js menu.js pages.js pagos.js predios.js products.js queries.js shops.js orders.js)
Rails.application.config.assets.precompile += %w( accounts.css alejandros.css bancos.css cart.css categories.css members.css menu.css pages.css pagos.css predios.css products.css queries.css shops.css orders.css )
