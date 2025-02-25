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
  
  def create
    actor = Actor.new
    actor.name = params.fetch("the_name")
    actor.image = params.fetch("the_image")

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
