module ApplicationHelper
  # テキストをsimple_formatで整形した上で
  # テキスト内に記載されたURLやemail_addressesをリンクとして有効にして返す
  def auto_link_text(text)
    auto_link(simple_format(h(text)), :all, target: '_blank' ) do |link|
      truncate(link, length: 30)
    end
  end
end
