module Newsletter
  class NewslettersController < ApplicationController
    layout 'admin', :except => "archive"
    skip_before_filter :authorize, :only => ["archive","show"]
    before_filter :find_newsletter, :only => [:publish,:unpublish,:edit,:update,:destroy,:show]
  
  
    def sort
      Newsletter.all.each do | newsletter |
        newsletter.sequence = params["newsletters"].index(newsletter.id.to_s)+1
        newsletter.save
      end
      head :ok
    end
  
    def archive
      @newsletters = Newsletter.published
      render :layout => Conf.newsletter_public_layout, :action => 'archive'
    end
  
    def publish
      if @newsletter.publish
        flash[:notice] = 'Newsletter Published'
      else
        flash[:notice] = @newsletter.errors
      end
      redirect_to(newsletter_newsletters_path)
    end
  
    def unpublish
      if @newsletter.unpublish
        flash[:notice] = 'Newsletter UnPublished'
      else
        flash[:notice] = @newsletter.errors
      end 
      redirect_to(newsletter_newsletters_path)
    end
  
    def index
      @newsletters = Newsletter.active.paginate(:all, :page => params[:page], :order => 'sequence')
    end
  
    def show
      return redirect_to(newsletter_archive_path) unless @newsletter.present?
      newsletter_html = render_to_string :inline => File.readlines(@newsletter.design.view_path).join, 
        :locals => @newsletter.locals
      if params[:mode].eql?('email')
        #mailer handles substitutions
        render :text => newsletter_html
      else
        #no substitutions
        render :text => newsletter_html
      end
    end

    def new
      @newsletter = Newsletter.new
      @designs = Design.active
    end

    def edit
      @designs = Design.active
    end

    def create
      @newsletter = Newsletter.new(params[:newsletter_newsletter])
      if @newsletter.save
        flash[:notice] = 'Newsletter was successfully created.'
        redirect_to(edit_newsletter_newsletter_path(@newsletter))
      else
        @designs = Design.active
        render :action => "new"
      end
    end

    def update
      if @newsletter.update_attributes(params[:newsletter_newsletter])
        flash[:notice] = 'Newsletter was successfully updated.'
        redirect_to(edit_newsletter_newsletter_path(@newsletter))
      else
        @designs = Design.active
        render :action => "edit"
      end
    end

    def destroy
      @newsletter.destroy
      redirect_to(newsletter_newsletters_url)
    end
  
    protected 
    def find_newsletter
      @newsletter = Newsletter.find_by_id(params[:id])
    end
  end
end
