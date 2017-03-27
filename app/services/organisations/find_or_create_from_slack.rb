module Organisations
  class FindOrCreateFromSlack
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      organisation_from_db = find_organisation
      return [:found, organisation_from_db] if organisation_from_db.present?

      new_organisation = create_organisation
      return [:error, new_organisation] unless new_organisation.valid?

      [:created, new_organisation]
    end

    private

    def find_organisation
      model_class.find_by(slack_uid: attributes.fetch(:slack_uid))
    end

    def create_organisation
      model_class.create(attributes)
    end

    def model_class
      Organisation
    end
  end
end
