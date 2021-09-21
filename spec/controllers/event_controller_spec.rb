describe EventsController do


  context 'with authorized user' do

    let(:user) { create(:user) }
    before(:each) do
      sign_in user
    end

    describe 'GET new' do
      it 'assigns a new event as @event' do
        get :new
        expect(response).to render_template(:new)
        expect(assigns(:event)).to be_a_new(Event)
        expect(response).to have_http_status(200)
        expect(flash[:alert]).to be_blank
      end
    end

    describe 'GET index' do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to have_http_status(200)
      end
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
      it "loads all public events into @events" do
        event1 = create(:public_event)
        create(:private_event)
        get :index
        expect(assigns(:events)).to match_array([event1])
      end
    end

    describe 'GET show' do
      context 'public event' do
        it 'assigns an event as @event' do
          public_event = create(:public_event)
          get :show, params: { id: public_event.id }
          expect(response).to render_template(:show)
          expect(response).to have_http_status(200)
          expect(flash[:alert]).to be_blank
        end
      end

      context 'other users private event' do
        it 'redirect user to home page' do
          other_users_private_event = create(:private_event)
          get :show, params: { id: other_users_private_event.id }
          expect(response).to redirect_to( events_path )
          expect(response).to have_http_status(302)
        end
      end
      context 'current users private event' do
        it 'assigns an event as @event' do
          current_users_private_event = create(:private_event, user: user)
          get :show, params: { id: current_users_private_event.id }
          expect(response).to render_template(:show)
          expect(response).to have_http_status(200)
          expect(user.events).to include(current_users_private_event)
          expect(flash[:alert]).to be_blank
        end
      end

      context 'event does not exist in the system' do
        it 'redirect user to home page' do
          get :show, params: { id: 1 }
          expect(response).to have_http_status(302)
        end
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'save event' do
          img = build(:image)
          expect do
            post :create, params: { event: attributes_for(:event).merge({images: [img]}) }
          end.to change(Event, :count).by(1)
        end
        it 'redirect_to events page after saving event' do
          post :create, params: { event: attributes_for(:event) }
          expect(response).to redirect_to(event_path(Event.last.id))
        end
      end

      context 'with invalid params' do
        it 'does not save event' do
          post :create, params: { event: {"description"=> nil}}
        end

        it 'renders new page with validation errors' do
          post :create, params: { event: {"description"=> nil} }
          expect(response).to redirect_to(new_event_path)
          expect(response).to have_http_status(302)
        end
      end
    end

    describe 'GET my_events' do
      context 'user with public and private events' do
        it 'assigns users events as @events' do
          event_public = create(:public_event, user: user)
          event_private = create(:private_event, user: user)
          get :my_events
          expect(assigns(:events)).to include(event_private)
          expect(assigns(:events)).to include(event_public)
        end
      end
    end

    describe 'DELETE event' do
      context 'users event' do
        it 'deletes his event' do
          event_public = create(:public_event, user: user)
          delete :destroy, params: { id: event_public.id }
          expect(response).to redirect_to(events_my_events_path)
          expect(response).to have_http_status(302)
          events = Event.all
          expect(events).not_to include(event_public)
          expect(flash[:success]).to eq("Event with id = #{event_public.id} deleted.")
        end

        it 'can not delete someone else event' do
          event_public = create(:public_event)
          delete :destroy, params: { id: event_public.id }
          expect(response).to redirect_to(events_my_events_path)
          expect(response).to have_http_status(302)
          events = Event.all
          expect(events).to include(event_public)
          expect(flash[:success]).to be_nil
        end
      end
    end
  end


  context 'with unauthorized user' do
    describe 'GET new' do
      it 'redirect to sign in page with error message' do
        get :new
        expect(response).to redirect_to('/users/sign_in')
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'GET index' do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to have_http_status(200)
      end
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
      it "loads all public events into @events" do
        event1 = create(:public_event)
        event2 = create(:private_event)
        get :index
        expect(assigns(:events)).to match_array([event1])
      end
    end

    describe 'GET new' do
      it 'redirect to sign in page with error message' do
        get :my_events
        expect(response).to redirect_to( events_path )
        expect(response).to have_http_status(302)
      end
    end
  end
end
