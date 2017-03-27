module Forms
  class NewSlackOrganisation
    attr_reader :name, :subdomain, :slack_uid, :image_url

    def initialize(name:, subdomain:, slack_uid:, image_url:)
      @name = name
      @subdomain = subdomain
      @slack_uid = slack_uid
      @image_url = image_url
    end

    def valid?
      Organisation.new(attrs_hash)
    end

    def persist!
      Organisation.create(attrs_hash)
    end

    private

    def attrs_hash
      {
        name: name,
        subdomain: subdomain,
        slack_uid: slack_uid,
        image_url: image_url,
      }
    end
  end
end
