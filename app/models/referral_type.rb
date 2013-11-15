class ReferralType < ActiveRecord::Base
  has_many :referrals

  validates :name,      :presence => true

  DIRECT_WEB_FORM = 'Directly through Web Form'
  ADMIN_WEB_FORM  = 'Admin Web Form'
  NAMES = [ DIRECT_WEB_FORM, ADMIN_WEB_FORM]

  DIRECT_WEB_FORM_ID  = 1
  ADMIN_WEB_FORM_ID  = 2

  def self.create_all
    find_or_create_by(id: DIRECT_WEB_FORM_ID, name: DIRECT_WEB_FORM)
    find_or_create_by(id: ADMIN_WEB_FORM_ID, name: ADMIN_WEB_FORM)    
  end
end
