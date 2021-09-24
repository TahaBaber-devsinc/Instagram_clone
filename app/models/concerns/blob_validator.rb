# frozen_string_literal: true

class BlobValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    return unless values.attached?

    Array(values).each do |value|
      record.errors.add(attribute, :content_type) unless valid_content_type?(value.blob)
    end
  end

  private

  def valid_content_type?(blob)
    return true if options[:content_type].nil?

    options[:content_type].include?(blob.content_type)
  end
end
