Capybara.add_selector(:admin_export_event_row) do
  xpath do |_locator, _options|
    XPath.generate do |x|
      x.descendant(:tr)
    end
  end

  expression_filter(:erroring_with_message, valid_values: [Regexp, String]) do |xpath, message|
    XPath.generate do |x|
      xpath[x.child(:td)[x.string.n.contains(message)] & x.child(:td)[x.string.equals('erroring')]]
    end
  end
  describe :expression_filters do |options|
    "erroring with message #{options[:erroring_with_message]}"
  end
end
