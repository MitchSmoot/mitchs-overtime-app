module PostsHelper
  def status_label(status)
    status_span_generator(status)
  end

  private

  def status_span_generator(status)
    case status
      when 'submitted'
        content_tag(:span, status.titleize, class: 'label label-warning')
      when 'approved'
        content_tag(:span, status.titleize, class: 'label label-primary')
      when 'rejected'
        content_tag(:span, status.titleize, class: 'label label-danger')
    end
  end
end
