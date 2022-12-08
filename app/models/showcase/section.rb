class Showcase::Section
  mattr_reader :root, default: Rails.root.join("app/views/showcase")

  def self.all(view_context)
    Dir.glob("*", base: root).map { new(view_context, _1).tap(&:find_displays) }
  end

  attr_reader :title, :displays

  def initialize(view_context, title)
    @view_context, @title, @displays = view_context, title, []
  end

  protected

  def find_displays
    if root.join(title).directory?
      Dir.children(root.join(title)).map do
        displays << Showcase::Display.new(@view_context, title: _1)
      end
    end
  end
end
