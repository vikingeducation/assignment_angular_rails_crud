require 'rails_helper'

describe PinsController do

  let(:json) { JSON.parse(response.body) }
  let!(:pin) { create(:pin) }


  describe 'GET pins' do

    before do
      create_list(:pin, 9)
      get :index, format: :json
    end


    it 'should return collection of pins' do
      expect(json).to be_an(Array)
    end


    it 'should return the full number of pins' do
      expect(json.count).to eq(10)
    end


    it 'should include associated usernames' do
      expect(json.first['user']['username']).to eq(pin.user.username)
    end

  end


  describe 'POST pins' do

    let(:status) { response.status }

    context 'with valid params' do

      it 'should save with valid params' do
        current_pins = Pin.all.count
        post :create, format: :json, :pin => attributes_for(:pin)
        expect(Pin.all.count).to eq(current_pins + 1)
      end

      it 'should return status 201' do
        post :create, format: :json, :pin => attributes_for(:pin)
        expect(response).to have_http_status(:created)
      end

    end


    context 'with invalid params' do


      xit 'should not save' do
        current_pins = Pin.all.count
        post :create, :pin => attributes_for(:pin, :description => nil)
        expect(Pin.all.count).to eq(current_pins)
      end

      xit 'should return status 422' do
        expect(response).to have_http_status(:error)
      end

    end


  end


end