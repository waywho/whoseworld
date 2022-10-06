# frozen_string_literal: true

class AlertComponentPreview < ViewComponent::Preview
  def default
    render(AlertComponent.new({notice: "this is a notice", alert: "this is an alert"}))
  end
end
