class Contact < ActiveRecord::Base
    #Contact from validations
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true

end
