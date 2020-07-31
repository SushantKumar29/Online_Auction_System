module ApplicationHelper
  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end

  def get_user_name(profile)
    profile.name || profile.user.email.split('@').first
  end
  
end
