class NewPropNotification < BaseNotification
  include Rails.application.routes.url_helpers

  vattr_initialize :prop

  def body
    "#{prop.propser} just gave a prop to *#{prop_receivers_list}*: " \
      "#{italicized_content} - <#{app_domain}|Check it out!>"
  end

  private

  def app_domain
    root_url(protocol: :https, host: AppConfig.app_domain)
  end

  def italicized_content
    prop.body.split("\n")
           .map { |part_of_content| "_#{part_of_content}_" }
           .join("\n")
  end

  def prop_receivers_list
    prop.users.to_a.join(', ')
  end
end
