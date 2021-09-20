module ApplicationHelper
  def format_flash_message(messages)
    if messages.is_a?(Array)
      safe_join(messages, tag(:br))
    else
      messages
    end
  end
end
