module ApplicationHelper
  def title(*args)
    args.join(' | ')
  end

  def add_crumb(crumb)
    @crumbs ||= []
    @crumbs << crumb
  end

  def get_crumbs
    @crumbs.join(' <span class="arrow glyphicon glyphicon-chevron-right"></span> ').html_safe
  end

  def add_crumbs_for_node(node, last_not_active = false)
    @crumbs = node.ancestors.map { |n| short_link(n.name, n) }.reverse
    @crumbs[-1] = short_text(node.name) if last_not_active
  end

  def short_link(name, object)
    if name.length > 70
      link_to truncate(name, length: 70), object, rel: 'tooltip', title: name
    else
      link_to name, object
    end
  end

  def short_text(text)
    if text.length > 70
      content_tag :span, truncate(text, length: 70), rel: 'tooltip', title: text
    else
      content_tag :span, text
    end
  end

  def btn_to(*args)
    if args.last.is_a?(Hash)
      args[-1] = { class: 'btn btn-default' }.merge(args.last)
    else
      args << { class: 'btn btn-default' }
    end

    link_to *args
  end

  def btn_to_del(*args)
    if args.last.is_a?(Hash)
      args[-1] = { method: :delete, data: { confirm: t('are_you_sure') } }.merge(args.last)
    else
      args << { method: :delete, data: { confirm: t('are_you_sure') } }
    end

    btn_to *args
  end

  def sortable(title, column, sort, direction)
    link_to(title, params.merge(sort: column, direction: direction == 'asc' ? 'desc' : 'asc')) +
    (sort != column ? '' : direction == 'asc' ? ' &#9660;' : ' &#9650;').html_safe
  end

  def options_for_node(node = Node.deep_root, options = [], level = 0)
    return options unless node

    options << ["#{ '- - ' * level }#{ node.name }", node.id]

    node.children.each do |child|
      options_for_node(child, options, level + 1)
    end

    options
  end

  def main_path
    nodes_path
  end
end
