
module FlashHelper
  def flash_class_name(message_type)
    case message_type
    when "notice" then "success"
    when "alert"  then "danger"
    else message_type
    end
  end
end
