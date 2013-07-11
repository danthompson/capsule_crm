module CapsuleCRM
  module Taggable
    extend ActiveSupport::Concern

    def tags
      CapsuleCRM::Connection.get(
        "/api/#{api_singular_name}/#{id}/tag"
      )['tags']['tag'].map { |item| CapsuleCRM::Tag.new(item) }
    end

    def add_tag(tag_name)
      if id
        CapsuleCRM::Connection.post(
          "/api/#{api_singular_name}/#{id}/tag/#{URI.encode(tag_name)}"
        )
      end
    end

    def remove_tag(tag_name)
      if id
        CapsuleCRM::Connection.delete(
          "/api/#{api_singular_name}/#{id}/tag/#{URI.encode(tag_name)}"
        )
      end
    end

    def api_singular_name
      self.class.to_s.demodulize.downcase.singularize
    end
  end
end
