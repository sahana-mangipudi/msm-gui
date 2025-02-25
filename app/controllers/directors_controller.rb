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

  def new_director
    director = Director.new

    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")

    director.save

    redirect_to("/directors")
  end

  def delete_director
    the_id = params.fetch("path_id")
    director = Director.find(the_id)

    director.delete

    redirect_to("/directors")
  end

  def update_director
    the_id = params.fetch("path_id")
    director = Director.find(the_id)

    updated_name = params.fetch("query_name")
    updated_dob = params.fetch("query_dob")
    updated_bio = params.fetch("query_bio")
    updated_image = params.fetch("query_image")

    director.update(name: updated_name, dob: updated_dob, bio: updated_bio,
                    image: updated_image)

    redirect_to("/directors/#{the_id}")
  end
end
