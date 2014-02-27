class PagesController < ApplicationController
  before_filter :redirect_if_page_is_in_processing, except: %w(show create process_form)

  def redirect_if_page_is_in_processing
    @page = Page.find(params[:id])
    redirect_to @page unless @page.free?
  end

  def show
    @page = Page.find(params[:id])
    @node = @page.node
  end

  def create
    if params[:files]
      page = Page.create(page_params.merge(image: params[:files].first))
      render json: { files: [page.hash_for_fileupload] }
    else
      render nothing: true
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to @page.node
  end

  def process_form
    @page = Page.find(params[:id])
    @node = @page.node
  end

  def process_act
    @page = Page.find(params[:id])

    angle, x1, y1, x2, y2 = params[:process_data][:angle].to_i,
                            params[:process_data][:x1].to_i,
                            params[:process_data][:y1].to_i,
                            params[:process_data][:x2].to_i,
                            params[:process_data][:y2].to_i

    @page.process angle, x1, y1, x2, y2

    @page.update_attributes angle: nil, x1: nil, y1: nil, x2: nil, y2: nil

    if params[:apply_to_prev]
      ids = @page.prev_all.map(&:id).reverse.select.with_index { |_, i| (i + 1) % @page.node.n_sided == 0 }
      Page.where(id: ids).update_all("angle = #{angle}, x1 = #{x1}, y1 = #{y1}, x2 = #{x2}, y2 = #{y2}")
    end

    if params[:apply_to_next]
      ids = @page.next_all.map(&:id).select.with_index { |_, i| (i + 1) % @page.node.n_sided == 0 }
      Page.where(id: ids).update_all("angle = #{angle}, x1 = #{x1}, y1 = #{y1}, x2 = #{x2}, y2 = #{y2}")
    end

    redirect_to process_form_page_path(@page.next)
  end

  def cancel
    @page = Page.find(params[:id])
    @page.cancel
    redirect_to @page
  end

  def duplicate
    @page = Page.find(params[:id])
    @page.duplicate
    redirect_to @page
  end

  def insert
    @page = Page.find(params[:id])
    redirect_to @page.insert(params[:image])
  end

  private

  def page_params
    params.require(:page).permit!
  end
end
