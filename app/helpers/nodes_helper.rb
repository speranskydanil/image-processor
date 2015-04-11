module NodesHelper
  def node_title(node)
  	length = node.name.to_s.length
  	cls = length < 80 ? 'large' : length < 160 ? 'medium' : 'small'
  	content_tag :h1, node.name, class: cls
  end
end

