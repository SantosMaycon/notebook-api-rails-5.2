class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    
    # def contact_kind
    #     self.kind.description
    # end

    def as_json(options={})
        super(root: true)
    end
end
