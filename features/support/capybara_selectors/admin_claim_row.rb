Capybara.add_selector(:admin_claim_row) do
  css do |_locator, _options|
    'tr'
  end

  node_filter([:reference]) do |node, value|
    node.all(:xpath, XPath.generate { |x| x.child(:td)[x.string.n.equals value] }, wait: 0).length > 0
  end
end
