# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :services_link, 'Services', project_services_path(@project), icon: ["icon-cogs"]
    primary.dom_class = 'nav nav-tabs'
    primary.auto_highlight = true
  end
end
