module ApplicationHelper
  def default_meta_tags
    {
      site: 'BRIDESAP',
      title: 'BRIDESAP',
      description: '他撮り頻発イベント「前撮り」「結婚式」に向けて、華奢に写る姿勢を練習するアプリです',
      keywords: '結婚式, 前撮り, 姿勢, 華奢, 肩幅, 猫背, 花嫁, プレ花嫁, スタイルアップ',
      noindex: !Rails.env.production?,
      canonical: request.original_url,
      reverse: true,
      charset: 'UTF-8',
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        #{ href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        creator: '@onna__________',
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end
