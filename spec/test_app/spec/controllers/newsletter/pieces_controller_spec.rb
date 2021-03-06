require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Newsletter::PiecesController, :type => :controller do
  render_views
  routes {Newsletter::Engine.routes}
  # This should return the minimal set of attributes required to create a valid
  # Newsletter::Piece. As you add validations to Newsletter::Piece, be sure to
  # adjust the attributes here as well.
  before(:each) do
    @design = import_design
    @newsletter = FactoryGirl.create(:newsletter, design: @design)
    @area = @newsletter.area('right_column')
    @element = @area.elements.detect{|e| e.name.eql?('Right Column Headline')}
    @field = @element.fields.first
  end
  let(:valid_attributes) {{
    newsletter_id: @newsletter.id,
    area_id: @area.id,
    element_id: @element.id,
    field_values_attributes: {
      @field.id => {
        text: "Extra! Extra!"
      }
    }
  }}

  let(:invalid_attributes) {{
    newsletter_id: @newsletter.id,
    element_id: @element.id,
    field_values_attributes: {
      @field.id => {
        text: "Extra! Extra!"
      }
    }
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Newsletter::PiecesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new piece as @piece" do
      get :new, {newsletter_id: @newsletter.id, element_id: @element.id, area_id: @area.id}, 
        valid_session
      expect(assigns(:piece)).to be_a_new(Newsletter::Piece)
    end
  end

  describe "GET #edit" do
    it "assigns the requested piece as @piece" do
      piece = Newsletter::Piece.create! valid_attributes
      get :edit, {:id => piece.to_param}, valid_session
      expect(assigns(:piece)).to eq(piece)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Newsletter::Piece" do
        expect {
          post :create, {:piece => valid_attributes}, valid_session
        }.to change(Newsletter::Piece, :count).by(1)
      end

      it "assigns a newly created piece as @piece" do
        post :create, {:piece => valid_attributes}, valid_session
        expect(assigns(:piece)).to be_a(Newsletter::Piece)
        expect(assigns(:piece)).to be_persisted
      end

      it "redirects to the created piece" do
        post :create, {:piece => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_newsletter_path(@newsletter))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved piece as @piece" do
        pending "Currently having issues forcing a piece to be valid and save, also except for associations... there are no validations currently"
        post :create, {:piece => invalid_attributes}, valid_session
        expect(assigns(:piece)).to be_a_new(Newsletter::Piece)
      end

      it "re-renders the 'new' template" do
        pending "Currently having issues forcing a piece to be valid and save, also except for associations... there are no validations currently"
        post :create, {:piece => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        newsletter_id: @newsletter.id,
        area_id: @area.id,
        element_id: @element.id,
        field_values_attributes: {
          @field.id => {
            text: "Extra! Extra!"
          }
        }
      }}

      it "updates the requested piece" do
        piece = Newsletter::Piece.create! valid_attributes
        put :update, {:id => piece.to_param, :piece => new_attributes}, valid_session
        piece.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested piece as @piece" do
        piece = Newsletter::Piece.create! valid_attributes
        put :update, {:id => piece.to_param, :piece => valid_attributes}, valid_session
        expect(assigns(:piece)).to eq(piece)
      end

      it "redirects to the newsletter edit" do
        piece = Newsletter::Piece.create! valid_attributes
        put :update, {:id => piece.to_param, :piece => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_newsletter_path(@newsletter))
      end
    end

    context "with invalid params" do
      it "assigns the piece as @piece" do
        piece = Newsletter::Piece.create! valid_attributes
        put :update, {:id => piece.to_param, :piece => invalid_attributes}, valid_session
        expect(assigns(:piece)).to eq(piece)
      end

      it "re-renders the 'edit' template" do
        pending "Currently having issues forcing a piece to be valid and save, also except for associations... there are no validations currently"
        piece = Newsletter::Piece.create! valid_attributes
        put :update, {:id => piece.to_param, :piece => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested piece" do
      piece = Newsletter::Piece.create! valid_attributes
      expect {
        delete :destroy, {:id => piece.to_param}, valid_session
      }.to change(Newsletter::Piece, :count).by(-1)
    end

    it "redirects to the newsletter edit" do
      piece = Newsletter::Piece.create! valid_attributes
      delete :destroy, {:id => piece.to_param}, valid_session
      expect(response).to redirect_to(edit_newsletter_path(@newsletter))
    end
  end

end
