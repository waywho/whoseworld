module Sluggable
  extend ActiveSupport::Concern

  def symbolized_slug
    slug.underscore.to_sym if defined?(:slug)
  end
end
