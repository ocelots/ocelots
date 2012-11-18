module Pages
  class Page
    include Capybara::DSL
  end

  class PageMatcher
    def initialize module_name
      @module_name = module_name
    end

    def matches? ignored
      @module_name.on?
    end

    def failure_message
      "not on page #{@module_name}"
    end
  end

  def on module_name
    page = Page.new
    page.extend module_name
    yield page if block_given?
    page
  end

  def be_on module_name
    PageMatcher.new module_name
  end
end

World Pages
World Pages