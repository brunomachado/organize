# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  navigation.autogenerate_item_ids = false

  navigation.items do |primary|
    primary.dom_class = 'tabs'
    primary.selected_class = 'tab-active'

    primary.item :my_links, 'Meus links', contents_path,
      class: "tab",
      link: { class: "tab-title icon-profile-lightblue_16_18-before",
              title: "Meus links" },
      details: { text: 'Todos seus links', class: 'tab-sub-title legend' } do |subtabs|
        subtabs.dom_class = 'tab-buttons'
        subtabs.selected_class = 'tab-button-active'

        subtabs.item :last_updates, "Últimos adicionados", contents_path, class: "tab-button"
        subtabs.item :bests, "Melhores avaliados", "#", class: "tab-button"
        subtabs.item :less_time, "Menor tempo", "#", class: "tab-button"
      end
    primary.item :space_links, 'Disciplina', space_contents_path(current_space),
      class: "tab",
      link: { class: "tab-title icon-space-lightblue_16_18-before",
              title: "Disciplina" }
    # :if => Proc.new { current_user.admin? }
    primary.item :new_link, 'Adicionar link', new_content_path,
      class: "tab",
      link: { class: "tab-title icon-file-lightblue_16_18-before",
              title: "Adicionar link" }
  end
end
