class NodesController < ApplicationController
  def index
    redirect_to Node.root if Node.root
  end

  def show
    @node = Node.find(params[:id])
  end

  def new
    @node = Node.new(parent_id: params[:parent_id])
  end

  def edit
    @node = Node.find(params[:id])
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      redirect_to @node, notice: I18n.t('nodes.created')
    else
      render action: 'new'
    end
  end

  def update
    @node = Node.find(params[:id])

    if @node.update_attributes(node_params)
      redirect_to @node, notice: I18n.t('nodes.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    redirect_to @node.parent || root_url
  end

  def upload_pages
    @node = Node.find(params[:id])
  end

  def update_pages_positions
    @node = Node.find(params[:id])
    @pages = @node.pages

    @pages.each do |page|
      page.update_attributes(position: params['pages_ids'].index(page.id.to_s))
    end

    redirect_to @node
  end

  def cancel
    @node = Node.find(params[:id])
    @node.cancel
    redirect_to @node
  end

  def duplicate
    @node = Node.find(params[:id])
    @node.duplicate
    redirect_to @node
  end

  def generate_zip
    @node = Node.find(params[:id])

    filename = SecureRandom.hex
    @node.delay.generate_zip filename
    @node.delay(run_at: 60.minutes.from_now).remove_zip filename

    render text: "/system/nodes/#{@node.id}/zip/#{filename}.zip"
  end

  def destroy_children
    @node = Node.find(params[:id])
    @node.children.destroy_all
    redirect_to @node
  end

  def destroy_pages
    @node = Node.find(params[:id])
    @node.delete_pages
    redirect_to @node
  end

  private

  def node_params
    params.require(:node).permit!
  end
end
