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

  def link_to_template(template)
    if template
      link_to truncate(template.title, length: 12), template
    end
  end
end
