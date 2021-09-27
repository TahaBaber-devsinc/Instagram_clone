# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'taha.babar@devsinc.com'
  layout 'mailer'
end
