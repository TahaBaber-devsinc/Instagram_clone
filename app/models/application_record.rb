# frozen_string_literal: true

# main class for models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
