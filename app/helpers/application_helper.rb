module ApplicationHelper
  def concave_errors_for(object, method)
    errors = object.errors[method].collect do |msg|
      content_tag(:li, msg)
    end.join.html_safe

    content_tag(:ul, errors, :class => 'errors_on_field control-errors')
  end

  def url_form
    if params[:user_id]
      user_contents_path
    else
      space_contents_path
    end
  end
end
