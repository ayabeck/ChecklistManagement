module ApplicationHelper
  # テキストをsimple_formatで整形した上で
  # テキスト内に記載されたURLやemail_addressesをリンクとして有効にして返す
  def auto_link_text(text)
    auto_link(simple_format(h(text)), :all, target: '_blank' ) do |link|
      truncate(link, length: 30)
    end
  end

  def indented_help_text(item, form_items)
    help_text = content_tag(:div, auto_link_text(item.label), class: 'help-text')

    if item.order == 0
      return content_tag(:div, help_text, class: 'col-xs-12')
    end

    none, more = %w(Heading HelpText), %w(Checkbox)
    case form_items[item.order - 1].type
      when *none
        content_tag(:div, help_text, class: 'col-xs-12')
      when *more
        content_tag(:div, content_tag(:div, help_text, class: 'double-indent'), class: 'col-sm-offset-4 col-sm-8')
      else
        # 通常の入力フォーム用字下げ
        content_tag(:div, help_text, class: 'col-sm-offset-4 col-sm-8')
    end
  end
end
