class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def new_actor
    actor = Actor.new

    actor.name = params.fetch("query_name")
    actor.dob = params.fetch("query_dob")
    actor.bio = params.fetch("query_bio")
    actor.image = params.fetch("query_image")

    actor.save

    redirect_to("/actors")
  end

  def delete_actor
    the_id = params.fetch("path_id")
    actor = Actor.find(the_id)

    actor.delete

    redirect_to("/actors")
  end

  def update_actor
    the_id = params.fetch("path_id")
    actor = Actor.find(the_id)

    updated_name = params.fetch("query_name")
    updated_dob = params.fetch("query_dob")
    updated_bio = params.fetch("query_bio")
    updated_image = params.fetch("query_image")

    actor.update(name: updated_name, dob: updated_dob, bio: updated_bio,
                    image: updated_image)

    redirect_to("/actors/#{the_id}")
  end
end
