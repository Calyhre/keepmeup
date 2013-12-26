class AppDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def status_icon
    klass = ''
    case true
    when object.maintenance
      klass = 'wrench'
    when object.processes.dynos.ups.any?
      klass = 'check'
    when object.processes.dynos.asleep.any?
      klass = 'moon-o'
    else
      klass = 'exclamation'
    end
    content_tag :i, nil, class: "fa fa-#{klass}"
  end

  def locked_icon
    if object.http_status == 401
      h.content_tag :i, class: "fa fa-lock" do
        self.tooltip(:locked)
      end
    end
  end

  def region_badge
    content_tag :span, object.region, class: "badge badge-#{object.region}"
  end

  def tooltip(field)
    if not object.respond_to? field
      h.content_tag :div, class: 'tooltip' do
        t "tooltips.apps.#{field}", { app_name: object.name }
      end
    elsif object.send(field).nil?
      h.content_tag :div, class: 'tooltip' do
        t "tooltips.apps.#{field}.#{object.send field}_value", { app_name: object.name, default: t("tooltips.apps.#{field}", app_name: object.name) }
      end
    end
  end
end
