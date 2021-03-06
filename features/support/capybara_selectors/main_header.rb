Capybara.add_selector(:main_header) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:h1, :h2)[x.string.n.is(translated)] }
  end
end
