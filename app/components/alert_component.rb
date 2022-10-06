# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  def initialize(flash)
    @flash = flash
  end

  def icon
    {
      alert: "text-red-700 dark:text-red-800",
      notice: "text-blue-700 dark:text-blue-800"
    }.freeze
  end

  def body
    {
      alert: "bg-red-100 dark:bg-red-200",
      notice: "bg-blue-100 dark:bg-blue-200"
    }
  end

  def text
    {
      alert: "text-red-700 dark:text-red-800",
      notice: "text-blue-700 dark:text-blue-800"
    }.freeze
  end

  def btn
    {
      alert: "bg-red-100 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:bg-red-200 dark:text-red-600 dark:hover:bg-red-300",
      notice: "bg-blue-100 text-blue-500 focus:ring-blue-400 hover:bg-blue-200 dark:bg-blue-200 dark:text-blue-600 dark:hover:bg-blue-300"
    }.freeze
  end
end
