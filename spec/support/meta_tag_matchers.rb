module MetaTagMatchers
  def response_meta_title
    response.body.scan(/<title>(.+)<\/title>/)[0][0]
  rescue
    ""
  end

  def response_meta_desc
    response.body.scan(/<meta content="(.*?)" name="description" \/>/)[0][0]
  rescue
    ""
  end

  def response_meta_canonical
    response.body.scan(/<link href="(.+?)" rel="canonical" \/>/)[0][0]
  rescue
    ""
  end

end
