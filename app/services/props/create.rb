module Props
  class Create
    pattr_initialize :props_repository, :attrs

    def call
      prop = create_prop attrs
      if prop.persisted?
        send_notification(prop)
        Response::Success.new(data: prop)
      else
        Response::Error.new(errors: prop.errors)
      end
    end

    private

    def create_prop(prop_attrs)
      clean_body = clean_text prop_attrs.fetch(:body)
      prop_attrs[:body] = clean_body

      props_repository.add prop_attrs
    end

    def clean_text(text)
      text.strip
    end

    def send_notification(prop)
      notification = NewPropNotification.new prop
      Notifier.new(notification).call
    end
  end
end
