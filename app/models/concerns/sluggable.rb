module Sluggable
  extend ActiveSupport::Concern

  def symbolized_slug
    slug&.parameterize(separator: "_")&.to_sym if defined?(slug)
  end

  private

  def slugify
    self.slug ||= title.parameterize if respond_to?(:title)
    self.slug ||= name.parameterize if respond_to?(:name)
  end
end
