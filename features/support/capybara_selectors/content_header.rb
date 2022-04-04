Capybara.add_selector(:content_header) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:h1, :h2, :h3, :h4, :h5)[x.string.n.is(translated)] }
  end
end
