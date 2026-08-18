Capybara.add_selector(:h3_containing) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:h3)[x.string.n.is(translated)] }
  end
end
