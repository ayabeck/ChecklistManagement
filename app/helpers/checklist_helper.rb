module ChecklistHelper
  def status_or_progress(checklist)
    if checklist.submit_at
      icon 'check-circle status', '提出済み'
    else
      valuenow = checklist.progression_rate
      opts = {
          role: 'progressbar',
          aria: {
              valuenow: valuenow,
              valuemin: '0',
              valuemax: '100'
          },
          style: "min-width: 2em; width: #{ valuenow }%;"
      }
      render inline: <<-HAML, type: :haml, locals: { opts: opts, valuenow: valuenow }
.progress.m-b-0
  .progress-bar.progress-bar-success{ opts }
    = "#{ valuenow }%"
      HAML
    end
  end

  def option_link_to(form_item)
    render inline: <<-HAML, type: :haml, locals: { form_item: form_item }
= link_to '編集', edit_form_item_path(form_item)
= link_to '削除', form_item, method: :delete, data: { confirm: t('message.delete_confirm') }, class: 'delete-action'
    HAML
  end

  def indented_help_text(item, form_items)
    help_text = content_tag(:div, auto_link_text(item.label), class: 'help-text')

    if item.order == 1
      content_tag(:div, help_text, class: 'col-xs-12')
      return
    end

    single, double = %w(Heading HelpText), %w(Checkbox)
    case form_items[item.order - 2].type
      when *single
        content_tag(:div, help_text, class: 'col-xs-12')
      when *double
        content_tag(:div, content_tag(:div, help_text, class: 'double-indent'), class: 'col-xs-12')
      else
        # 入力フォーム用の特別字下げ
        content_tag(:div, help_text, class: 'col-sm-offset-4 col-sm-8')
    end
  end
end
