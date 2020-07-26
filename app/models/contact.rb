class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_one :address
    has_many :phones

    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true

    def as_json(options={})
        hash = super(options)
        hash[:birthdate] = (I18n.l(self.birthdate) unless I18n.l(self.birthdate).blank?)
        hash
    end

    # def date_ptBR
    #     {
    #         name: self.name,
    #         email: self.email,
    #         birthdate: (I18n.l(self.birthdate) unless I18n.l(self.birthdate).blank?),
    #         kind_id: self.kind_id
    #     }
    # end

    # def contact_kind
    #     self.kind.description
    # end

    # def as_json(options={})
    #     super(root: true)
    # end
end
