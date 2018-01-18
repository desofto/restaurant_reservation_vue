# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class Base < Grape::Entity
    format_with(:iso_timestamp, &:iso8601)

    expose :id

    with_options(format_with: :iso_timestamp) do
      expose :created_at, format_with: :iso_timestamp
      expose :updated_at, format_with: :iso_timestamp
    end
  end
end
