class NodesController < ApplicationController
  authorize_resource

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

  def generate_archive
    @node = Node.find(params[:id])
    @node.delay(priority: 15, user: current_user).generate_archive
    redirect_to @node, notice: I18n.t('nodes.archive_will_be_generated')
  end

  def remove_archive
    @node = Node.find(params[:id])
    @node.archive = nil
    @node.save
    redirect_to @node
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

  def options
    ancestors = params[:fid].blank? ? [] : Node.find(params[:fid]).ancestors.map(&:id)

    nodes = Node.where(parent_id: params[:pid].blank? ? nil : params[:pid])

    json = nodes.map do |node|
      {
        value: node.id,
        text: node.name,
        selected: ancestors.include?(node.id)
      }
    end

    render json: json
  end

  private

  def node_params
    params.require(:node).permit!
  end
end
