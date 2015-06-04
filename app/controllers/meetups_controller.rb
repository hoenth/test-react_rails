class MeetupsController < ApplicationController
  # GET /meetups
  # GET /meetups.json
  def index
    @meetups = Meetup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetups }
    end
  end

  # GET /meetups/1
  # GET /meetups/1.json
  def show
    @meetup = Meetup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meetup }
    end
  end

  # GET /meetups/new
  # GET /meetups/new.json
  def new
    @meetup = Meetup.new
    @technologies = Technology.all.to_a
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meetup }
    end
  end

  # GET /meetups/1/edit
  def edit
    @meetup = Meetup.find(params[:id])
  end

  # POST /meetups
  # POST /meetups.json
  def create
    @meetup = Meetup.new(meetup_params)
    respond_to do |format|
      if @meetup.save
        format.html { redirect_to @meetup, notice: 'Meetup was successfully created.' }
        format.json { render json: @meetup, status: :created, location: @meetup }
      else
        format.html { render action: "new" }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetups/1
  # PUT /meetups/1.json
  def update
    @meetup = Meetup.find(params[:id])

    respond_to do |format|
      if @meetup.update_attributes(meetup_params)
        format.html { redirect_to @meetup, notice: 'Meetup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetups/1
  # DELETE /meetups/1.json
  def destroy
    @meetup = Meetup.find(meetup_params[:id])
    @meetup.destroy

    respond_to do |format|
      format.html { redirect_to meetups_url }
      format.json { head :no_content }
    end
  end

  private

  def meetup_params
    params.require(:meetup).permit(:title, :description, :date, :technology_id, :seo, guests: [])
  end

end
