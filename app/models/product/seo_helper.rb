module Product::SeoHelper
  # if the permalink is not filled in set it equal to the name
  def sanitize_data
    sanitize_permalink
    assign_meta_keywords  if meta_keywords.blank? && description
    sanitize_meta_description
  end

  def sanitize_permalink
    self.permalink = name if permalink.blank? && name
    self.permalink = permalink.squeeze(" ").strip.gsub(' ', '-') if permalink
  end

  def sanitize_meta_description
    if name && description.present? && meta_description.blank?
      self.meta_description = [name.first(55), description.remove_hyper_text.first(197)].join(': ')
    end
  end

  def assign_meta_keywords
    self.meta_keywords =  [name.first(55),
                          description.
                          remove_non_alpha_numeric.           # remove non-alpha numeric
                          remove_hyper_text.                  # remove hyper text
                          remove_words_less_than_x_characters. # remove words less than 2 characters
                          first(197)                       # limit to 197 characters
                          ].join(': ')
  end
end
