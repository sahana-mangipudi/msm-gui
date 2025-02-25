class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    director = Director.new
    director.name = params.fetch("the_name")
    #director.dob = params.fetch("")
    #director.bio = params.fetch("")
    director.image = params.fetch("the_image")

    if actor.save
      redirect_to("/actors")
    else
      render({ :template => "actor_templates/index" })
    end
  end

  def update
    the_id = params.fetch("path_id")
    actor = Actor.find(the_id)

    actor.image = params.fetch("the_image")

    if actor.save
      redirect_to("/actors/#{actor.id}")
    else
      render({ :template => "actor_templates/show" })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    actor = Actor.find(the_id)
    actor.destroy

    redirect_to("/actors")
  end
end
