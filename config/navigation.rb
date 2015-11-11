# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.active_leaf_class = 'active'
  
  navigation.items do |primary|
    primary.item :projects_link, 'Projects', projects_path
    primary.item :environments_link, 'Environments', environments_path
    primary.item :tokens_link, 'Tokens', tokens_path

    primary.dom_class = 'nav'
    primary.auto_highlight = true
  end
end
