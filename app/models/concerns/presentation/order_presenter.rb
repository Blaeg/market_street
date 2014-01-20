module Presentation
  module OrderPresenter
    extend ActiveSupport::Concern

    def display_completed_at(format = :us_date)
      completed_at ? I18n.localize(completed_at, :format => format) : 'Not Finished.'
    end    
  end
end
