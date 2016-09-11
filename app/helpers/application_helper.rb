module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
  }

  STATE_MAP = {
      'waiting' => 'wait.png',
      'active' => 'yes.png',
      'accepted' => 'yes.png',
      'refused' => 'no.png',
      'closed' => 'no.png'
  }

  COLORS = %w(
      #1A98FF #0582CA #006494 #003554 #051923
)

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "text-center alert #{bootstrap_class_for(msg_type)}") do
        concat content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'})
        concat message
      end)
      flash.clear
    end
    nil
  end

end
