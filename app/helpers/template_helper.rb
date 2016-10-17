module TemplateHelper
  def option_link_to(form_item, sortable)
    if sortable
      content_tag(:div, icon('reorder fa-lg'), class: 'draggable')
    else
      render inline: <<-HAML, type: :haml, locals: { form_item: form_item }
= link_to '編集', edit_form_item_path(form_item)
= link_to '削除', form_item, method: :delete, data: { confirm: t('message.delete_confirm') }, class: 'delete-action'
      HAML
    end
  end
end
