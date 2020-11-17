class BaseBuilder
  include ApplicationHelper
  include ActionView::Helpers::TranslationHelper

  def stylesheet_link_tag file, *args
    "<link rel='stylesheet' media='all' href='/stylesheets/#{file}.css' />"
  end

  def javascript_include_tag file, *args
    "<script src='/javascripts/#{file}.js'></script>"
  end

  def build path:, locals: {}, out: nil
    if locals.is_a? Hash
      locals.each do |k, v|
        singleton_class.class_eval { attr_accessor k }
        send("#{k}=", v)
      end
    end

    erb = read_erb_file(path)
    write_erb_file(out || path, erb)
  end

  def layout(path = "layouts/application.html.erb", &block)
    erb = read_erb_file(path)

    erb.result(binding, &block)
  end

  def read_erb_file path
    ERB.new(File.read(get_view_path(path)))
  end

  def write_erb_file path, erb
    puts ">> write: #{public_path(path)}"

    File.write(public_path(path), layout{ erb.result(binding) })
  end

  def get_view_path path
    Rails.root.join("app", "views", path)
  end

  def public_path path
    dirname, _, filename = path.rpartition("/")
    FileUtils.mkdir_p(Rails.root.join("public", dirname))
    Rails.root.join("public", [dirname, filename.sub(".erb", "")].reject(&:blank?).join("/"))
  end
end
