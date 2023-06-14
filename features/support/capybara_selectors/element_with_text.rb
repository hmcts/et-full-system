Capybara.add_selector(:element_with_text) do
  xpath do |locator, options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator, **options.fetch(:i18n_params, {}))
    XPath.generate { |x| x.descendant[x.string.n.is(translated)] }
  end
  expression_filter(:i18n_params) { |xpath, _val| xpath }
end
